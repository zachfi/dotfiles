return {
  -- Github
  {
    "github/copilot.vim",
    lazy = false, -- Load immediately
    config = function()
      -- Disable Copilot's default Tab mapping
      vim.g.copilot_no_tab_map = 1
      vim.g.copilot_settings = { selectedCompletionModel = "gpt-4o-copilot" }
      vim.g.copilot_integration_id = "vscode-chat"

      -- Map <M-l> (Alt + L) to accept Copilot suggestions
      -- vim.keymap.set("i", "<M-l>", 'copilot#Accept("<CR>")', {
      --   expr = true,
      --   silent = true,
      --   replace_keycodes = false,
      --   desc = "Accept Copilot suggestion",
      -- })
    end,
  },

  -- {
  --   "zbirenbaum/copilot.lua",
  --   cmd = "Copilot",
  --   event = "InsertEnter",
  --   config = function()
  --     require("copilot").setup({
  --       suggestion = { enabled = false },
  --       panel = { enabled = false },
  --       auto_trigger = true,
  --     })
  --   end,
  -- },
  --
  -- {
  --   "zbirenbaum/copilot-cmp",
  --   config = function()
  --     require("copilot_cmp").setup()
  --   end,
  -- },

  { "AndreM222/copilot-lualine" },

  {
    "CopilotC-Nvim/CopilotChat.nvim",
    dependencies = {
      { "github/copilot.vim" },                    -- or zbirenbaum/copilot.lua
      { "nvim-lua/plenary.nvim", branch = "master" }, -- for curl, log and async functions
    },
    build = "make tiktoken",                       -- Only on MacOS or Linux
    opts = {
      -- See Configuration section for options
    },
    -- config = function()
    --   require("fzf-lua").register_ui_select()
    -- end,
    -- See Commands section for default commands if you want to lazy load on them
  },
}
