-- functions
return {
  {
    "kylechui/nvim-surround",
    version = "*", -- Use for stability; omit to use `main` branch for the latest features
    event = "VeryLazy",
    config = function()
      require("nvim-surround").setup({
        -- Configuration here, or leave empty to use defaults
      })
    end,
  },

  "nvim-lua/popup.nvim",  -- An implementation of the Popup API from vim in Neovim
  "nvim-lua/plenary.nvim", -- Useful lua functions used ny lots of plugins
  {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
      "muniftanjim/nui.nvim",
    },
    opts = {
      filesystem = {
        follow_current_file = { enabled = true },
        filtered_items = {
          hide_dotfiles = false,
        },
      },
      buffers = {
        follow_current_file = { enabled = true },
      },
    },
  },
  --[[ "ahmedkhalf/project.nvim", ]]
  "antoinemadec/FixCursorHold.nvim", -- This is needed to fix lsp doc highlight
  --[[ "preservim/tagbar", ]]

  -- snippets
  --[[ "L3MON4D3/LuaSnip",            --snippet engine ]]
  --[[ "rafamadriz/friendly-snippets", -- a bunch of snippets to use ]]

  -- Git
  "tpope/vim-fugitive",
  "tpope/vim-rhubarb",

  {
    "pwntester/octo.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-telescope/telescope.nvim",
      "nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
    },
    opts = {
      reaction_viewer_hint_icon = "", -- marker for user reactions
      user_icon = "👤", -- user icon
      timeline_marker = "🗨", -- timeline marker
      right_bubble_delimiter = "", -- Bubble delimiter
      left_bubble_delimiter = "", -- Bubble delimiter
      enable_builtin = true,
    },
  },

  {
    "linrongbin16/gitlinker.nvim",
    dependencies = {
      "rcarriga/nvim-notify",
    },
    cmd = "GitLink",
    opts = {
      message = false,
      highlight_duration = 2000,
    },
    config = function()
      -- require("notify").setup()
      vim.notify = require("notify")
      require("gitlinker").setup()
    end,
  },

  -- ZK for notes
  {
    "zk-org/zk-nvim",
    keys = {
      -- see which-key.lua
    },

    config = function()
      local zk = require("zk")
      zk.setup({
        picker = "telescope",
        lsp = {
          config = {
            root_dir = "/home/zach/notes",
          },
        },
      })

      local commands = require("zk.commands")

      local function make_edit_fn(defaults, picker_options)
        return function(options)
          options = vim.tbl_extend("force", defaults, options or {})
          zk.edit(options, picker_options)
        end
      end

      commands.add("ZkOrphans", function(options)
        options = vim.tbl_extend("force", { orphan = true }, options or {})
        zk.edit(options, { title = "Zk Orphans" })
      end)

      commands.add("ZkRecents", make_edit_fn({ createdAfter = "2 weeks ago" }, { title = "Zk Recents" }))
    end,
  },
  {
    "dstein64/vim-startuptime",
    -- lazy-load on a command
    cmd = "StartupTime",
    -- init is called during startup. Configuration for vim plugins typically should be set in an init function
    init = function()
      vim.g.startuptime_tries = 10
    end,
  },
}
