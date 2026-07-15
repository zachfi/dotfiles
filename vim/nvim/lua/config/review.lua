-- PR review flow: check out a pull request into a detached HEAD and read the
-- diff with diffview. Kept self-contained so the whole flow can be moved or
-- reverted as a unit. Keymaps live under <leader>p ("Review") in which-key.lua.
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

-- Resolve the ref that reviews diff against. Prefers PREFERRED_REMOTE (the
-- canonical repo in a fork workflow), then origin, then REVIEW_BASE. This is
-- what makes the range match the PR when origin is a fork.
local function base_ref()
  if has_remote(PREFERRED_REMOTE) then
    local head = remote_head(PREFERRED_REMOTE)
    if head then
      return head
    end
  end
  return remote_head("origin") or REVIEW_BASE
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

-- Run `gh pr checkout <ref> --detach` and report the result.
local function checkout(ref)
  ref = vim.trim(ref or "")
  if ref == "" then
    return
  end
  vim.notify("Checking out PR " .. ref .. " …", vim.log.levels.INFO)
  local out = vim.fn.system({ "gh", "pr", "checkout", ref, "--detach" })
  if vim.v.shell_error ~= 0 then
    vim.notify("gh pr checkout failed:\n" .. out, vim.log.levels.ERROR)
    return
  end
  vim.cmd("checktime") -- refresh open buffers to the checked-out revision
  vim.notify("Checked out PR " .. ref .. " (detached)", vim.log.levels.INFO)
end

-- List PRs with `gh pr list <extra...>`, let the user pick one, then check it
-- out. Picking renders through telescope-ui-select.
local function pick_and_checkout(extra)
  local args = { "gh", "pr", "list", "--limit", LIST_LIMIT, "--json", "number,title,author" }
  vim.list_extend(args, extra or {})
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
  vim.ui.select(items, {
    prompt = "Checkout PR",
    format_item = function(it)
      return it.label
    end,
  }, function(choice)
    if choice then
      checkout(tostring(choice.number))
    end
  end)
end

-- <leader>pc — small menu covering the three ways to reach a PR.
function M.checkout_menu()
  local modes = {
    "My open PRs",
    "Specify PR (number or URL)",
    "All open PRs",
  }
  vim.ui.select(modes, { prompt = "Checkout PR" }, function(choice)
    if choice == modes[1] then
      pick_and_checkout({ "--author", "@me" })
    elseif choice == modes[2] then
      vim.ui.input({ prompt = "PR number or URL: " }, checkout)
    elseif choice == modes[3] then
      pick_and_checkout({})
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
