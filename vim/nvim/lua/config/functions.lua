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
