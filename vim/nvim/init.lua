vim.opt.runtimepath:append(",~/.config/nvim")

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end

vim.opt.rtp:prepend(lazypath)

-- Unless you are still migrating, remove the deprecated commands from v1.x
vim.cmd([[ let g:neo_tree_remove_legacy_commands = 1 ]])

require("config")

require("lazy").setup({
  spec = {
    { import = "plugins" },
    { import = "plugins.ui" },
    { import = "plugins.lang" },
    --[[ { import = "plugins.notes" }, ]]
    --[[ { import = "plugins.ai" }, ]]
    { import = "pde" },
  },
  --[[ defaults = { lazy = true, version = nil }, ]]
  --[[ install = { missing = true, colorscheme = { "tokyonight", "gruvbox" } }, ]]
  --[[ dev = { patterns = jit.os:find "Windows" and {} or { "alpha2phi" } }, ]]
  --[[ checker = { enabled = true }, ]]
  --[[ performance = { ]]
  --[[   cache = { ]]
  --[[     enabled = true, ]]
  --[[   }, ]]
  --[[   rtp = { ]]
  --[[     disabled_plugins = { ]]
  --[[       "gzip", ]]
  --[[       "matchit", ]]
  --[[       "matchparen", ]]
  --[[       "tarPlugin", ]]
  --[[       "tohtml", ]]
  --[[       "tutor", ]]
  --[[       "zipPlugin", ]]
  --[[       -- "netrwPlugin", ]]
  --[[     }, ]]
  --[[ }, ]]
  --[[ }, ]]
})

require("user.autocommands")
require("user.functions")
require("user.telescope")
