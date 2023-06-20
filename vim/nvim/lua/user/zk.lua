local zk = require("zk")

zk.setup({
  -- can be "telescope", "fzf" or "select" (`vim.ui.select`)
  -- it's recommended to use "telescope" or "fzf"
  picker = "telescope",

  lsp = {
    -- `config` is passed to `vim.lsp.start_client(config)`
    config = {
      cmd = { "zk", "lsp" },
      name = "zk",
      -- on_attach = ...
      --[[ on_attach = require("user.lsp.handlers").on_attach, ]]
      -- etc, see `:h vim.lsp.start_client()`
      root_dir = "/home/zach/notes",
    },

    -- automatically attach buffers in a zk notebook that match the given filetypes
    auto_attach = {
      enabled = true,
      filetypes = { "markdown" },
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
