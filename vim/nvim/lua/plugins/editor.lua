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
      },
    }, -- for default options, refer to the configuration section for custom setup.
  },

  -- todo comments
  {
    "folke/todo-comments.nvim",
    cmd = { "TodoTrouble", "TodoTelescope" },
    event = { "BufReadPost", "BufNewFile" },
    config = true,
    -- stylua: ignore
    keys = {
      -- see which-key.lua
    },

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
          "--glob='!vendor*'",
        },
        -- regex that will be used to match keywords.
        -- don't replace the (KEYWORDS) placeholder
        pattern = [[\b(KEYWORDS)(:| -)]], -- ripgrep regex
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
