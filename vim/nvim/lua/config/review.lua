-- PR review flow: check out a pull request into a detached HEAD and read the
-- diff with diffview. Kept self-contained so the whole flow can be moved or
-- reverted as a unit. Keymaps live under <leader>p ("Review") in which-key.lua.
local M = {}

-- KNOB: ref that `pr` diffs against. Resolved per-repo from origin/HEAD
-- (usually origin/main); this constant is only the fallback. Change it if a
-- repo you review defaults to something else.
local REVIEW_BASE = "origin/main"

-- KNOB: how many PRs the list-based pickers fetch.
local LIST_LIMIT = "50"

-- Resolve the repo's default branch, falling back to REVIEW_BASE.
local function base_ref()
  local out = vim.fn.systemlist("git symbolic-ref --short refs/remotes/origin/HEAD")
  if vim.v.shell_error == 0 and out[1] and out[1] ~= "" then
    return out[1]
  end
  return REVIEW_BASE
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
