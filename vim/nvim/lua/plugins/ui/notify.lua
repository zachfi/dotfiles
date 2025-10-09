return {
  {
    "rcarriga/nvim-notify",
    opts = {
      timeout = 5555,
      render = "compact",
      stages = "static",
    },
    init = function()
      vim.notify = require("notify")
    end,
  },
}
