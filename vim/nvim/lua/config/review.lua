-- PR review flow: check out a pull request (GitHub via `gh`, Forgejo via
-- `fj`, auto-detected from the repo's remote) and read the diff with
-- diffview. Kept self-contained so the whole flow can be moved or reverted
-- as a unit. Keymaps live under <leader>p ("Review") in which-key.lua.
local M = {}

-- KNOB: last-resort base if no usable remote HEAD is found.
local REVIEW_BASE = "origin/main"

-- KNOB: the remote you open PRs against. In a fork workflow this is the
-- canonical repo (conventionally "upstream") while "origin" is your fork, so
-- base_ref() prefers it. If it does not exist we fall back to origin. Set to
-- "origin" if you PR directly into origin.
local PREFERRED_REMOTE = "upstream"

-- KNOB: how many PRs the list-based pickers fetch.
local LIST_LIMIT = "50"

-- Per-repo override: `git config review.base <ref>` pins the base for one repo
-- and wins over the remote heuristic below. Use it where the heuristic guesses
-- wrong, e.g. a personal repo that has an unrelated `upstream` remote but PRs
-- into origin (`git config review.base origin/main`), or an odd default branch.
local function configured_base()
  local out = vim.fn.systemlist({ "git", "config", "--get", "review.base" })
  if vim.v.shell_error == 0 and out[1] and out[1] ~= "" then
    return out[1]
  end
  return nil
end

-- True if the named git remote exists.
local function has_remote(name)
  local out = vim.fn.systemlist({ "git", "remote" })
  if vim.v.shell_error ~= 0 then
    return false
  end
  return vim.tbl_contains(out, name)
end

-- Resolve a remote's default branch as "<remote>/<branch>", preferring its
-- recorded HEAD symref (e.g. upstream/main), falling back to <remote>/main.
-- Returns nil if neither is available.
local function remote_head(remote)
  local out = vim.fn.systemlist({ "git", "symbolic-ref", "--short", "refs/remotes/" .. remote .. "/HEAD" })
  if vim.v.shell_error == 0 and out[1] and out[1] ~= "" then
    return out[1]
  end
  vim.fn.systemlist({ "git", "rev-parse", "--verify", "--quiet", "refs/remotes/" .. remote .. "/main" })
  if vim.v.shell_error == 0 then
    return remote .. "/main"
  end
  return nil
end

-- Resolve the ref that reviews diff against. Order: per-repo `review.base`
-- config, then PREFERRED_REMOTE (the canonical repo in a fork workflow), then
-- origin, then REVIEW_BASE. This is what makes the range match the PR when
-- origin is a fork.
local function base_ref()
  local configured = configured_base()
  if configured then
    return configured
  end
  if has_remote(PREFERRED_REMOTE) then
    local head = remote_head(PREFERRED_REMOTE)
    if head then
      return head
    end
  end
  return remote_head("origin") or REVIEW_BASE
end

-- Resolve a remote's URL, or nil if the remote doesn't exist.
local function remote_url(remote)
  local out = vim.fn.systemlist({ "git", "remote", "get-url", remote })
  if vim.v.shell_error == 0 and out[1] and out[1] ~= "" then
    return out[1]
  end
  return nil
end

-- Resolve which host <leader>pc should talk to, using the same remote
-- preference as base_ref() (PREFERRED_REMOTE, then origin): github.com uses
-- `gh`, anything else is assumed to be a Forgejo instance (e.g. code.znet)
-- reached via `fj -H <host>`. Returns nil (and notifies) if neither remote
-- exists or its URL can't be parsed.
local function detect_host()
  local remote = has_remote(PREFERRED_REMOTE) and PREFERRED_REMOTE or "origin"
  local url = remote_url(remote)
  if not url then
    vim.notify("No usable git remote (" .. remote .. ") to detect review host", vim.log.levels.ERROR)
    return nil
  end
  local host = url:match("@([%w%.%-]+)[:/]") or url:match("://([%w%.%-]+)")
  if not host then
    vim.notify("Could not parse host from remote url: " .. url, vim.log.levels.ERROR)
    return nil
  end
  if host == "github.com" then
    return { kind = "github" }
  end
  return { kind = "forgejo", host = host }
end

-- `fj whoami` prints "currently signed into <user>@<host>" with no --json
-- form, so pull the bare username out of that sentence for `-c` filters.
local function fj_whoami(host)
  local out = vim.fn.system({ "fj", "-H", host, "whoami" })
  if vim.v.shell_error ~= 0 then
    vim.notify("fj whoami failed:\n" .. out, vim.log.levels.ERROR)
    return nil
  end
  local user = out:match("into%s+([^@%s]+)@")
  if not user then
    vim.notify("Could not parse fj whoami output:\n" .. out, vim.log.levels.ERROR)
    return nil
  end
  return user
end

-- Absolute path of the repo (or worktree) root, so git calls and file opens
-- work regardless of the cwd we launched nvim from. Falls back to cwd.
local function git_root()
  local out = vim.fn.systemlist({ "git", "rev-parse", "--show-toplevel" })
  if vim.v.shell_error == 0 and out[1] and out[1] ~= "" then
    return out[1]
  end
  return vim.fn.getcwd()
end

-- Check out a PR: `gh pr checkout <ref> --detach` on GitHub, or
-- `fj pr checkout <id>` on Forgejo (which takes a bare ID rather than a URL,
-- and lands on a named branch rather than a detached HEAD).
local function checkout(host, ref)
  ref = vim.trim(ref or "")
  if ref == "" then
    return
  end
  if host.kind == "github" then
    vim.notify("Checking out PR " .. ref .. " …", vim.log.levels.INFO)
    local out = vim.fn.system({ "gh", "pr", "checkout", ref, "--detach" })
    if vim.v.shell_error ~= 0 then
      vim.notify("gh pr checkout failed:\n" .. out, vim.log.levels.ERROR)
      return
    end
    vim.cmd("checktime") -- refresh open buffers to the checked-out revision
    vim.notify("Checked out PR " .. ref .. " (detached)", vim.log.levels.INFO)
    return
  end

  local id = ref:match("/pulls?/(%d+)%s*$") or ref
  vim.notify("Checking out PR " .. id .. " …", vim.log.levels.INFO)
  local out = vim.fn.system({ "fj", "-H", host.host, "pr", "checkout", id })
  if vim.v.shell_error ~= 0 then
    vim.notify("fj pr checkout failed:\n" .. out, vim.log.levels.ERROR)
    return
  end
  vim.cmd("checktime")
  vim.notify("Checked out PR " .. id, vim.log.levels.INFO)
end

-- Render `items` ({number, label}) through telescope-ui-select and check out
-- whichever one gets picked.
local function select_and_checkout(host, items)
  vim.ui.select(items, {
    prompt = "Checkout PR",
    format_item = function(it)
      return it.label
    end,
  }, function(choice)
    if choice then
      checkout(host, tostring(choice.number))
    end
  end)
end

-- List PRs — `gh pr list <extra...>` on GitHub, `fj pr search -s open
-- <extra...>` on Forgejo — let the user pick one, then check it out.
local function pick_and_checkout(host, extra)
  extra = extra or {}
  if host.kind == "github" then
    local args = { "gh", "pr", "list", "--limit", LIST_LIMIT, "--json", "number,title,author" }
    vim.list_extend(args, extra)
    local raw = vim.fn.system(args)
    if vim.v.shell_error ~= 0 then
      vim.notify("gh pr list failed:\n" .. raw, vim.log.levels.ERROR)
      return
    end
    local ok, prs = pcall(vim.json.decode, raw)
    if not ok or type(prs) ~= "table" or #prs == 0 then
      vim.notify("No open PRs found", vim.log.levels.INFO)
      return
    end
    local items = {}
    for _, pr in ipairs(prs) do
      table.insert(items, {
        number = pr.number,
        label = string.format("#%d  %s  (%s)", pr.number, pr.title, pr.author.login),
      })
    end
    select_and_checkout(host, items)
    return
  end

  -- Forgejo: plain-text lines, "#123: title (by author)" — there's no --json
  -- form, and `--all` avoids silently truncating to search's first page.
  local args = { "fj", "-H", host.host, "pr", "search", "-s", "open", "--all" }
  vim.list_extend(args, extra)
  local raw = vim.fn.system(args)
  if vim.v.shell_error ~= 0 then
    vim.notify("fj pr search failed:\n" .. raw, vim.log.levels.ERROR)
    return
  end
  local items = {}
  for _, line in ipairs(vim.split(raw, "\n", { trimempty = true })) do
    local number, title, author = line:match("^#(%d+):%s*(.*)%s+%(by (.-)%)%s*$")
    if number then
      table.insert(items, {
        number = number,
        label = string.format("#%s  %s  (%s)", number, title, author),
      })
    end
  end
  if #items == 0 then
    vim.notify("No open PRs found", vim.log.levels.INFO)
    return
  end
  select_and_checkout(host, items)
end

-- <leader>pc — small menu covering the three ways to reach a PR. Dispatches
-- to GitHub (`gh`) or Forgejo (`fj`) based on the detected review host; the
-- menu itself is identical either way.
function M.checkout_menu()
  local host = detect_host()
  if not host then
    return
  end
  local modes = {
    "My open PRs",
    "Specify PR (number or URL)",
    "All open PRs",
  }
  vim.ui.select(modes, { prompt = "Checkout PR" }, function(choice)
    if choice == modes[1] then
      if host.kind == "github" then
        pick_and_checkout(host, { "--author", "@me" })
      else
        local user = fj_whoami(host.host)
        if user then
          pick_and_checkout(host, { "-c", user })
        end
      end
    elseif choice == modes[2] then
      vim.ui.input({ prompt = "PR number or URL: " }, function(ref)
        checkout(host, ref)
      end)
    elseif choice == modes[3] then
      pick_and_checkout(host, {})
    end
  end)
end

-- <leader>pr — open the PR diff against the repo's default branch. The 3-dot
-- range diffs from the merge-base, matching what GitHub shows on the PR.
function M.review()
  vim.cmd("DiffviewOpen " .. base_ref() .. "...HEAD")
end

-- <leader>pl — Telescope picker of files changed on the branch vs the default
-- branch. Same 3-dot merge-base range as review(), so it lists exactly the
-- PR's files. Preview shows each file's diff; <cr> opens the file for reading.
function M.changed_files()
  local base = base_ref()
  local range = base .. "...HEAD"
  local root = git_root()

  local files = vim.fn.systemlist({ "git", "-C", root, "diff", "--name-only", range })
  if vim.v.shell_error ~= 0 then
    vim.notify("git diff failed:\n" .. table.concat(files, "\n"), vim.log.levels.ERROR)
    return
  end
  files = vim.tbl_filter(function(f)
    return f ~= ""
  end, files)
  if #files == 0 then
    vim.notify("No files changed vs " .. base, vim.log.levels.INFO)
    return
  end

  local pickers = require("telescope.pickers")
  local finders = require("telescope.finders")
  local conf = require("telescope.config").values
  local previewers = require("telescope.previewers")
  local actions = require("telescope.actions")
  local action_state = require("telescope.actions.state")

  pickers
    .new({}, {
      prompt_title = "Changed vs " .. base,
      finder = finders.new_table({ results = files }),
      sorter = conf.generic_sorter({}),
      previewer = previewers.new_termopen_previewer({
        get_command = function(entry)
          return { "git", "-C", root, "-c", "color.ui=always", "diff", range, "--", entry.value }
        end,
      }),
      attach_mappings = function(prompt_bufnr)
        actions.select_default:replace(function()
          local entry = action_state.get_selected_entry()
          actions.close(prompt_bufnr)
          if entry then
            vim.cmd("edit " .. vim.fn.fnameescape(root .. "/" .. entry.value))
          end
        end)
        return true
      end,
    })
    :find()
end

-- <leader>ph — toggle gitsigns' diff base between the branch base and the
-- index, globally. With the branch base active, the gutter signs and the
-- hunk-nav maps (v]/v[) track your committed branch changes instead of
-- staged/unstaged, so you can jump straight to the sections a PR touched.
local base_active = false
function M.toggle_base()
  local gs = require("gitsigns")
  if base_active then
    gs.change_base(nil, true)
    base_active = false
    vim.notify("gitsigns base: index (staged/unstaged)", vim.log.levels.INFO)
  else
    local base = base_ref()
    gs.change_base(base, true)
    base_active = true
    vim.notify("gitsigns base: " .. base .. " (committed branch changes)", vim.log.levels.INFO)
  end
end

-- <leader>pb — leave detached HEAD and return to the branch you were on.
function M.back()
  local out = vim.fn.system({ "git", "switch", "-" })
  if vim.v.shell_error ~= 0 then
    vim.notify("git switch - failed:\n" .. out, vim.log.levels.ERROR)
    return
  end
  vim.cmd("checktime")
  vim.notify("Returned to " .. vim.trim(out), vim.log.levels.INFO)
end

return M
