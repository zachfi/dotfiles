function ToggleTodo(opts)
	-- replace
	--       by -
	-- -     by - [ ]
	-- - [ ] by - [x]
	-- - [x] by -
	-- enter insert mode if opts.i == true
	opts = opts or {}
	local linenr = vim.api.nvim_win_get_cursor(0)[1]
	local curline = vim.api.nvim_buf_get_lines(0, linenr - 1, linenr, false)[1]
	local stripped = vim.trim(curline)
	local repline
	if vim.startswith(stripped, "- ") and not vim.startswith(stripped, "- [") then
		repline = curline:gsub("%- ", "- [ ] ", 1)
	else
		if vim.startswith(stripped, "- [ ]") then
			repline = curline:gsub("%- %[ %]", "- [x]", 1)
		else
			if vim.startswith(stripped, "- [x]") then
				repline = curline:gsub("%- %[x%]", "-", 1)
			else
				repline = curline:gsub("(%S)", "- [ ] %1", 1)
			end
		end
	end
	vim.api.nvim_buf_set_lines(0, linenr - 1, linenr, false, { repline })
	if opts.i then
		vim.api.nvim_feedkeys("A", "m", false)
	end
end

-- Yank a repo-relative "path:line" (or "path:start-end") reference for the
-- current buffer to the system clipboard. Normal mode yanks the cursor line;
-- visual mode yanks the selected range. Handy for pointing at code in chat.
function YankLocalRef()
  local abs = vim.api.nvim_buf_get_name(0)
  if abs == "" then
    vim.notify("YankLocalRef: buffer has no file", vim.log.levels.WARN)
    return
  end

  -- Prefer a path relative to the git root, then cwd, else the absolute path.
  local root = vim.fs.root(0, ".git") or vim.fn.getcwd()
  local path = abs
  local prefix = root .. "/"
  if abs:sub(1, #prefix) == prefix then
    path = abs:sub(#prefix + 1)
  end

  -- Determine the line (or range) from the current mode. A <cmd>/function
  -- keymap does not leave visual mode, so line("v")/line(".") are the live
  -- selection anchor and cursor.
  local mode = vim.fn.mode()
  local ref
  if mode == "v" or mode == "V" or mode == "\22" then
    local a, b = vim.fn.line("v"), vim.fn.line(".")
    if a > b then
      a, b = b, a
    end
    if a == b then
      ref = string.format("%s:%d", path, a)
    else
      ref = string.format("%s:%d-%d", path, a, b)
    end
  else
    ref = string.format("%s:%d", path, vim.fn.line("."))
  end

  vim.fn.setreg("+", ref)
  vim.notify("Yanked " .. ref)
end

-- Telescope find_files scoped to the current buffer's directory
function FindFilesRelative(opts)
  opts = opts or {}
  local themes = require("telescope.themes")
  local theme_opts = themes.get_dropdown({
    sorting_strategy = "ascending",
    prompt_title = "~ find relative files ~",
    cwd = require("telescope.utils").buffer_dir(),
    layout_strategy = "center",
    layout_config = {
      center = {
        width = { 0.7, max = 1200, min = 80 },
        height = 0.6,
      },
    },
  })
  opts = vim.tbl_deep_extend("force", theme_opts, opts)
  require("telescope.builtin").find_files(opts)
end

-- Telescope find_files scoped to the cwd
function FindFiles(opts)
  opts = opts
      or {
        path_display = {
          truncate = 3,
        },
      }
  local themes = require("telescope.themes")
  local theme_opts = themes.get_dropdown({
    sorting_strategy = "ascending",
    prompt_title = "~ find files ~",
    cwd = vim.fn.getcwd(),
    layout_strategy = "center",
    layout_config = {
      center = {
        width = { 0.7, max = 1200, min = 80 },
        height = 0.6,
      },
    },
  })
  opts = vim.tbl_deep_extend("force", theme_opts, opts)
  require("telescope.builtin").find_files(opts)
end
