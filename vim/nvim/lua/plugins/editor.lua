return {
  -- references
  {
    "RRethy/vim-illuminate",
  },

  -- buffer remove
  { "ojroques/nvim-bufdel" },

  -- color
  {
    "uga-rosa/ccc.nvim",
    opts = {
      highlighter = {
        auto_enable = true,
        lsp = true,
      },
    },
  },

  -- better diagnostics list and others
  {
    "folke/trouble.nvim",
    dependencies = {
      "nvim-tree/nvim-web-devicons",
    },
    cmd = "Trouble",
    keys = {
      -- see which-key.lua
    },
    opts = {
      modes = {
        symbols = {
          win = {
            size = 0.3, -- 30% of the window
          },
        },
        diagnostics_buffer = {
          mode = "diagnostics", -- inherit from diagnostics mode
          filter = { buf = 0 }, -- filter diagnostics to the current buffer
        },

        cascade = {
          mode = "diagnostics", -- inherit from diagnostics mode
          filter = function(items)
            local severity = vim.diagnostic.severity.HINT
            for _, item in ipairs(items) do
              severity = math.min(severity, item.severity)
            end
            return vim.tbl_filter(function(item)
              return item.severity == severity
            end, items)
          end,
        },
      },
    }, -- for default options, refer to the configuration section for custom setup.
  },

  -- todo comments
  {
    "folke/todo-comments.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
    },

    cmd = { "TodoTrouble", "TodoTelescope" },
    event = { "BufReadPost", "BufNewFile" },
    -- config = true,
    -- stylua: ignore
    -- keys = {
    --   -- see which-key.lua
    -- },
    lazy = false,

    opts = {

      highlight = {
        pattern = {
          [[.*<(KEYWORDS)\s*:]], -- pattern or table of patterns, used for highlighting (vim regex)
          [[.*<(KEYWORDS)\s*-]], -- pattern or table of patterns, used for highlighting (vim regex)
        },
      },

      -- default except for the vendor ignore
      search = {
        command = "rg",
        args = {
          "--color=never",
          "--no-heading",
          "--with-filename",
          "--line-number",
          "--column",
          -- "--glob='!vendor*'",
        },
        -- regex that will be used to match keywords.
        -- don't replace the (KEYWORDS) placeholder
        -- pattern = [[\b(KEYWORDS)(:| -)]], -- ripgrep regex
        pattern = [[\b(KEYWORDS):]], -- ripgrep regex
        -- pattern = [[\b(KEYWORDS)\b]], -- match without the extra colon. You'll likely get false positives
      },
    },
  },
  {
    "lervag/vimtex",
    lazy = false, -- we don't want to lazy load VimTeX
    -- tag = "v2.15", -- uncomment to pin to a specific release
    init = function()
      -- VimTeX configuration goes here
    end,
  },
}
