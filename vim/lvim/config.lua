-- functions
function find_files_relative(opts)
  opts = opts or {}
  local utils = require "telescope.themes"
  local themes = require "telescope.themes"
  local theme_opts = themes.get_dropdown {
    sorting_strategy = "ascending",
    layout_strategy = "bottom_pane",
    prompt_prefix = ">> ",
    prompt_title = "~ relative files ~",
    cwd = require("telescope.utils").buffer_dir(),
  }
  opts = vim.tbl_deep_extend("force", theme_opts, opts)
  require("telescope.builtin").find_files(opts)
end

-- general
lvim.log.level = "warn"
lvim.format_on_save = true
lvim.colorscheme = "onedarker"

vim.opt.guifont = "Hack:h12"
vim.opt.wrap = true
vim.opt.showtabline = 1
vim.opt.list = true
vim.opt.listchars:append("tab:»·")
vim.opt.listchars:append("trail:·")

-- keymappings [view all the defaults by pressing <leader>Lk]
lvim.leader = ";"
-- add your own keymapping
lvim.keys.normal_mode["<C-s>"] = ":w<cr>"
lvim.keys.normal_mode["<C-n>"] = ":tabnext<cr>"
lvim.keys.normal_mode["<C-p>"] = ":tabprev<cr>"
lvim.keys.normal_mode["<C-t>"] = ":tabnew<cr>"
-- unmap a default keymapping
-- lvim.keys.normal_mode["<C-Up>"] = ""
-- edit a default keymapping
-- lvim.keys.normal_mode["<C-q>"] = ":q<cr>"

-- Change Telescope navigation to use j and k for navigation and n and p for history in both input and normal mode.
-- lvim.builtin.telescope.on_config_done = function()

local actions = require("telescope.actions")
lvim.builtin.telescope.defaults.mappings = {
  i = {
      ["<esc>"] = actions.close,
      ["<C-u>"] = false,
      ["<C-j>"] = actions.move_selection_next,
      ["<C-k>"] = actions.move_selection_previous,
      ["<C-n>"] = actions.cycle_history_next,
      ["<C-p>"] = actions.cycle_history_prev,
  },
  n = {
      ["<C-j>"] = actions.move_selection_next,
      ["<C-p>"] = actions.move_selection_previous,
  }
}

lvim.builtin.terminal.open_mapping = [[<C-\>]]

-- Use which-key to add extra bindings with the leader-key prefix
lvim.builtin.which_key.mappings["/"] = { ":nohls<CR>", "Clear Search" }
lvim.builtin.which_key.mappings["d"] = { "<cmd>Telescope find_files<CR>", "Find File" }
lvim.builtin.which_key.mappings["f"] = { "<cmd>lua find_files_relative()<CR>", "Find Relative File" }
-- lvim.builtin.which_key.mappings["t"] = {
--   name = "+Trouble",
--   r = { "<cmd>Trouble lsp_references<cr>", "References" },
--   f = { "<cmd>Trouble lsp_definitions<cr>", "Definitions" },
--   d = { "<cmd>Trouble lsp_document_diagnostics<cr>", "Diagnostics" },
--   q = { "<cmd>Trouble quickfix<cr>", "QuickFix" },
--   l = { "<cmd>Trouble loclist<cr>", "LocationList" },
--   w = { "<cmd>Trouble lsp_workspace_diagnostics<cr>", "Diagnostics" },
-- }

-- TODO: User Config for predefined plugins
-- After changing plugin config exit and reopen LunarVim, Run :PackerInstall :PackerCompile
lvim.builtin.dashboard.active = true
lvim.builtin.terminal.active = true
lvim.builtin.nvimtree.setup.view.side = "left"
lvim.builtin.nvimtree.show_icons.git = 0
-- lvim.builtin.nvimtree.setup.view.width = 45

-- if you don't want all the parsers change this to a table of the ones you want
lvim.builtin.treesitter.ensure_installed = {
  "bash",
  -- "c",
  -- "javascript",
  "json",
  "lua",
  "go",
  "python",
  -- "typescript",
  -- "css",
  -- "rust",
  -- "java",
  "yaml",
}

lvim.builtin.treesitter.ignore_install = { "haskell" }
lvim.builtin.treesitter.highlight.enabled = true

-- generic LSP settings
lvim.lsp.automatic_servers_installation = true
-- you can set a custom on_attach function that will be used for all the language servers
-- See <https://github.com/neovim/nvim-lspconfig#keybindings-and-completion>
-- lvim.lsp.on_attach_callback = function(client, bufnr)
--   local function buf_set_option(...)
--     vim.api.nvim_buf_set_option(bufnr, ...)
--   end
--   --Enable completion triggered by <c-x><c-o>
--   buf_set_option("omnifunc", "v:lua.vim.lsp.omnifunc")
-- end
-- you can overwrite the null_ls setup table (useful for setting the root_dir function)
-- lvim.lsp.null_ls.setup = {
--   root_dir = require("lspconfig").util.root_pattern("Makefile", ".git", "node_modules"),
-- }
-- or if you need something more advanced
-- lvim.lsp.null_ls.setup.root_dir = function(fname)
--   if vim.bo.filetype == "javascript" then
--     return require("lspconfig/util").root_pattern("Makefile", ".git", "node_modules")(fname)
--       or require("lspconfig/util").path.dirname(fname)
--   elseif vim.bo.filetype == "php" then
--     return require("lspconfig/util").root_pattern("Makefile", ".git", "composer.json")(fname) or vim.fn.getcwd()
--   else
--     return require("lspconfig/util").root_pattern("Makefile", ".git")(fname) or require("lspconfig/util").path.dirname(fname)
--   end
-- end

-- https://github.com/neovim/nvim-lspconfig/blob/master/CONFIG.md#sumneko_lua
local sumneko_root_path = '/home/zach/src/lua-language-server'
local sumneko_binary = sumneko_root_path.."/bin/Linux/lua-language-server"

require'lspconfig'.sumneko_lua.setup {
  cmd = {sumneko_binary, "-E", sumneko_root_path .. "/main.lua"};
}

-- set a formatter if you want to override the default lsp one (if it exists)
-- lvim.lang.python.formatters = {
--   {
--     exe = "black",
--   }
-- }
-- set an additional linter
-- lvim.lang.python.linters = {
--   {
--     exe = "flake8",
--   }
-- }

-- Additional Plugins
lvim.plugins = {
  {"google/vim-jsonnet"},
--     {"folke/tokyonight.nvim"},
--     {
--       "folke/trouble.nvim",
--       cmd = "TroubleToggle",
--     },
}

-- Autocommands (https://neovim.io/doc/user/autocmd.html)
lvim.autocommands.custom_groups = {
  { "BufWinEnter", "*.md", "setlocal wrap linebreak spell filetype=markdown" },
  { "BufWinEnter", "*.markdown", "setlocal wrap linebreak spell filetype=markdown" },
  { "BufWinEnter", "*.tmpl", "setlocal filetype=gotexttmpl" },
  { "BufRead", "$HOME/.mutt/temp*", "setlocal filetype=mail" },
  { "Filetype", "mail", "setlocal textwidth=72 wrap spell" },
  { "Filetype", "mail", "setlocal fo+=aw" },
}

