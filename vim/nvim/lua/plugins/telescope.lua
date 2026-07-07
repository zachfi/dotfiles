return {
  -- Telescope
  {
    "nvim-telescope/telescope.nvim",
    cmd = "Telescope",
    dependencies = {
      { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
      "nvim-telescope/telescope-dap.nvim",
    },
    config = function(_, opts)
      local telescope = require("telescope")
      telescope.setup(opts)
      telescope.load_extension("fzf")
      telescope.load_extension("dap")
    end,
    opts = {
      defaults = {
        sorting_strategy = "ascending",
        prompt_prefix = "  ",
        selection_caret = " ",
        mappings = {
          i = {
            ["<esc>"] = function(...)
              return require("telescope.actions").close(...)
            end,
            ["<C-u>"] = false,
          },
        },
        layout_strategy = "horizontal",

        layout_config = {
          horizontal = {
            width = { 0.8, max = 1200, min = 80 },
            height = 0.6,
          },
          vertical = {
            width = { 0.8, max = 1200, min = 80 },
            height = 0.6,
          },
          center = {
            width = { 0.8, max = 1200, min = 80 },
            height = 0.7,
          },
        },
      },

      pickers = {
        buffers = {
          sort_mru = true,
          previewer = false,
        },
        colorscheme = {
          enable_preview = true,
        },
        find_files = {
          previewer = false,
        },
        lsp_document_symbols = {
          fname_width = 0.5,
          symbol_width = 0.3,
          symbol_type_width = 0.2,
        },
      },
      extensions = {
        fzf = {},
      },
    },
  },
  {
    "nvim-telescope/telescope-symbols.nvim",
  },
  {
    "crispgm/telescope-heading.nvim",
    config = function()
      require("telescope").load_extension("heading")
    end,
  },
  {
    "nvim-telescope/telescope-ui-select.nvim",
    config = function()
      require("telescope").load_extension("ui-select")
    end,
  },
  {
    "Snikimonkd/telescope-git-conflicts.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
    config = function()
      require("telescope").load_extension("conflicts")
    end,
  },
}
