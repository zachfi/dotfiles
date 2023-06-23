return {
  "nvim-lua/popup.nvim",  -- An implementation of the Popup API from vim in Neovim
  "nvim-lua/plenary.nvim", -- Useful lua functions used ny lots of plugins
  {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v2.x",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
      "MunifTanjim/nui.nvim",
    },
    opts = {
      filesystem = {
        follow_current_file = true,
      },
      buffers = {
        follow_current_file = true,
      },
    },
  },
  --[[ "ahmedkhalf/project.nvim", ]]
  "antoinemadec/FixCursorHold.nvim", -- This is needed to fix lsp doc highlight
  --[[ "preservim/tagbar", ]]

  {
    "folke/trouble.nvim",
    dependencies = {
      "nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
    },
    opts = { use_diagnostic_signs = true },
  },

  -- snippets
  "L3MON4D3/LuaSnip",            --snippet engine
  "rafamadriz/friendly-snippets", -- a bunch of snippets to use

  -- Debug
  "folke/lua-dev.nvim",
  "mfussenegger/nvim-dap",
  "theHamsta/nvim-dap-virtual-text",
  "rcarriga/nvim-dap-ui",

  -- Telescope
  "nvim-telescope/telescope.nvim",

  -- Git
  "tpope/vim-fugitive",
  "tpope/vim-rhubarb",

  -- Github
  "github/copilot.vim",
  {
    "pwntester/octo.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-telescope/telescope.nvim",
      "nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
    },
    opts = {
      reaction_viewer_hint_icon = "", -- marker for user reactions
      user_icon = "👤",           -- user icon
      timeline_marker = "🗨",     -- timeline marker
      right_bubble_delimiter = "", -- Bubble delimiter
      left_bubble_delimiter = "", -- Bubble delimiter
    },
  },

  -- ZK for notes
  {
    "mickael-menu/zk-nvim",
    keys = {
      { "<leader>zd", ':lua require("zk.commands").get("ZkNew")({ dir = "journal/daily" })<CR>' },
      { "<leader>zw", ':lua require("zk.commands").get("ZkNew")({ dir = "journal/weekly" })<CR>' },
      { "<leader>zt", ":ZkTags<CR>" },
      { "<leader>zo", ":ZkOrphans<CR>" },
      { "<leader>zr", ":ZkRecents<CR>" },
      { "<leader>za", ":ZkNotes<CR>" },
      { "<leader>zn", ":ZkNew<CR>" },
      { "<leader>zi", ":ZkIndex<CR>" },
      { "<leader>zl", ":ZkLinks<CR>" },
      { "<leader>zc", ":ZkCd<CR>" },
      { "<leader>zq", ":lua ToggleTodo()<CR>" },
      { "<leader>zs", ":!make -C ~/notes update<CR>" },
    },

    config = function()
      local zk = require("zk")
      zk.setup({
        {
          picker = "telescope",

          lsp = {
            config = {
              root_dir = "/home/zach/notes",
            },
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
