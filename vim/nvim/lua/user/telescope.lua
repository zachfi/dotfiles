-- functions
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
