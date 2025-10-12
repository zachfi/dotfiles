-- functions
function FindFilesRelative(opts)
	opts = opts or {}
	local themes = require("telescope.themes")
	local theme_opts = themes.get_dropdown({
		sorting_strategy = "ascending",
		layout_strategy = "center",
		prompt_prefix = "  ",
		prompt_title = "~ find relative files ~",
		cwd = require("telescope.utils").buffer_dir(),
		layout_config = {
			center = { preview_cutoff = 1200, height = 0.5, width = 0.6 },
		},
	})
	opts = vim.tbl_deep_extend("force", theme_opts, opts)
	require("telescope.builtin").find_files(opts)
end

function FindFiles(opts)
	opts = opts
		or {
			path_display = {
				-- "smart",
				-- shorten = 3,
				truncate = 3,
			},
			-- file_ignore_patterns = {
			-- 	"vendor/.*",
			-- },
		}
	local themes = require("telescope.themes")
	local theme_opts = themes.get_ivy({
		sorting_strategy = "ascending",
		layout_strategy = "center",
		prompt_prefix = "  ",
		prompt_title = "~ find files ~",
		cwd = vim.fn.getcwd(),
		layout_config = {
			center = { preview_cutoff = 1200, height = 0.5, width = 0.6 },
		},
	})
	opts = vim.tbl_deep_extend("force", theme_opts, opts)
	require("telescope.builtin").find_files(opts)
end
