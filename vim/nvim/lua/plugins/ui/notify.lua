return {
  {
    "rcarriga/nvim-notify",
    keys = {
      -- see which-key.lua
    },
    opts = {
      timeout = 3000,
      render = "compact",
      stages = "static",
    },
    init = function()
      vim.notify = require("notify")
    end,
  },
}
