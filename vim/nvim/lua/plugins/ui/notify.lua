return {
  {
    "rcarriga/nvim-notify",
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
