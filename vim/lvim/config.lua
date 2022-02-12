-- functions
function FindFilesRelative(opts)
	opts = opts or {}
	local themes = require("telescope.themes")
	local theme_opts = themes.get_dropdown({
		sorting_strategy = "ascending",
		layout_strategy = "center",
		prompt_prefix = ">>> ",
		prompt_title = "~ find relative files ~",
		cwd = require("telescope.utils").buffer_dir(),
		layout_config = {
			center = { preview_cutoff = 1200, height = 0.7, width = 0.8 },
		},
	})
	opts = vim.tbl_deep_extend("force", theme_opts, opts)
	require("telescope.builtin").find_files(opts)
end

function FindFiles(opts)
	opts = opts
		or {
			path_display = {
				-- "smart",
				-- shorten = 3,
				truncate = 3,
			},
			file_ignore_patterns = {
				"vendor/.*",
			},
		}
	local themes = require("telescope.themes")
	local theme_opts = themes.get_dropdown({
		sorting_strategy = "ascending",
		layout_strategy = "center",
		prompt_prefix = ">>> ",
		prompt_title = "~ find files ~",
		layout_config = {
			center = { preview_cutoff = 1200, height = 0.7, width = 0.8 },
		},
	})
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
lvim.keys.normal_mode["<leader>t"] = 'a<c-r>=strftime("%FT%T%z")<CR><Esc>'
lvim.keys.normal_mode["<S-q>"] = "gqap"
-- disable the quick j/k line swap
lvim.keys.insert_mode["<A-j>"] = false
lvim.keys.insert_mode["<A-k>"] = false
lvim.keys.normal_mode["<A-j>"] = false
lvim.keys.visual_block_mode["<A-j>"] = false
lvim.keys.normal_mode["<A-k>"] = false
lvim.keys.visual_block_mode["<A-k>"] = false
lvim.keys.visual_block_mode["J"] = false
lvim.keys.visual_block_mode["K"] = false

-- Zettelkasten
lvim.keys.normal_mode["<leader>zf"] = ":lua require('telekasten').find_notes()<CR>"
lvim.keys.normal_mode["<leader>zd"] = ":lua require('telekasten').find_daily_notes()<CR>"
lvim.keys.normal_mode["<leader>zD"] = ":lua require('telekasten').goto_today()<CR>"
lvim.keys.normal_mode["<leader>zg"] = ":lua require('telekasten').search_notes()<CR>"
lvim.keys.normal_mode["<leader>zz"] = ":lua require('telekasten').follow_link()<CR>"
lvim.keys.normal_mode["<leader>zW"] = ":lua require('telekasten').goto_thisweek()<CR>"
lvim.keys.normal_mode["<leader>zw"] = ":lua require('telekasten').find_weekly_notes()<CR>"
lvim.keys.normal_mode["<leader>zn"] = ":lua require('telekasten').new_note()<CR>"
lvim.keys.normal_mode["<leader>zN"] = ":lua require('telekasten').new_templated_note()<CR>"
lvim.keys.normal_mode["<leader>zy"] = ":lua require('telekasten').yank_notelink()<CR>"
lvim.keys.normal_mode["<leader>zc"] = ":lua require('telekasten').show_calendar()<CR>"
lvim.keys.normal_mode["<leader>zC"] = ":CalendarT<CR>"
lvim.keys.normal_mode["<leader>zi"] = ":lua require('telekasten').paste_img_and_link()<CR>"
lvim.keys.normal_mode["<leader>zt"] = ":lua require('telekasten').toggle_todo()<CR>"
lvim.keys.normal_mode["<leader>zb"] = ":lua require('telekasten').show_backlinks()<CR>"
lvim.keys.normal_mode["<leader>zF"] = ":lua require('telekasten').find_friends()<CR>"
lvim.keys.normal_mode["<leader>za"] = ":lua require('telekasten').show_tags()<CR>"

-- on hesitation, bring up the panel
lvim.keys.normal_mode["<leader>z"] = ":lua require('telekasten').panel()<CR>"

-- unmap a default keymapping
-- lvim.keys.normal_mode["<C-Up>"] = ""
-- edit a default keymapping
-- lvim.keys.normal_mode["<C-q>"] = ":q<cr>"

-- Change Telescope navigation to use j and k for navigation and n and p for history in both input and normal mode.
-- lvim.builtin.telescope.on_config_done = function()

lvim.builtin.cmp.preselect = true

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
	},
}

require("telescope").setup({
	defaults = {
		file_ignore_patterns = { "vendor/.*" },
	},
})

lvim.builtin.terminal.open_mapping = [[<C-\>]]

-- Use which-key to add extra bindings with the leader-key prefix
lvim.builtin.which_key.mappings["/"] = { ":nohls<CR>", "Clear Search" }
lvim.builtin.which_key.mappings["d"] = {
	"<cmd>lua FindFiles()<CR>",
	"Find files from working directory",
}
lvim.builtin.which_key.mappings["f"] = {
	"<cmd>lua FindFilesRelative()<CR>",
	"Find files relative to the current buffer",
}
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
	"bash", -- "c",
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

local lspconfig = require("lspconfig")
lspconfig.gopls.setup({
	cmd = { "gopls", "serve" },
	settings = {
		gopls = {
			-- analyses = {
			--   unusedparams = true,
			-- },
			-- staticcheck = true,
			buildFlags = { "-tags=requires_docker" },
		},
	},
})

local formatters = require("lvim.lsp.null-ls.formatters")
formatters.setup({
	{ exe = "goimports", filetypes = { "go" } },
	{ exe = "stylua", filetypes = { "lua" } },
	{ exe = "black", filetypes = { "python" } },
})

local linters = require("lvim.lsp.null-ls.linters")
linters.setup({
	-- { exe = "golangci_lint", filetypes = { "go" }, },
	-- { exe = "proselint", filetypes = { "markdown" }, },
})

local null_ls = require("null-ls")
null_ls.register(null_ls.builtins.diagnostics.golangci_lint)

-- local dap_install = require "dap-install"
-- dap_install.config("go_delve", {})

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
	{ "folke/trouble.nvim", cmd = "TroubleToggle" },
	{
		"blackCauldron7/surround.nvim",
		config = function()
			require("surround").setup({ mappings_style = "surround" })
		end,
	},
	{
		"pwntester/octo.nvim",
		config = function()
			require("octo").setup()
		end,
	},

	-- syntax
	{ "google/vim-jsonnet" },
	{ "voxpupuli/vim-puppet" },
	{ "ap/vim-css-color" },
	{ "jjo/vim-cue" },

	-- colors
	{ "folke/tokyonight.nvim" },
	{ "rakr/vim-one" },

	-- Zettelkasten for notes
	{ "renerocksai/telekasten.nvim" },
	{ "renerocksai/calendar-vim" },
}

local notes = vim.fn.expand("~/notes")
require("telekasten").setup({
	home = notes,
	-- if true, telekasten will be enabled when opening a note within the configured home
	take_over_my_home = true,

	-- auto-set telekasten filetype: if false, the telekasten filetype will not be used
	--                               and thus the telekasten syntax will not be loaded either
	auto_set_filetype = true,

	dailies = notes .. "/" .. "daily",
	weeklies = notes .. "/" .. "weekly",
	templates = notes .. "/" .. "templates",

	-- image subdir for pasting
	-- subdir name
	-- or nil if pasted images shouldn't go into a special subdir
	image_subdir = "img",

	-- markdown file extension
	extension = ".md",

	-- following a link to a non-existing note will create it
	follow_creates_nonexisting = true,
	dailies_create_nonexisting = true,
	weeklies_create_nonexisting = true,

	-- template for new notes (new_note, follow_link)
	-- set to `nil` or do not specify if you do not want a template
	template_new_note = notes .. "/" .. "templates/new_note.md",

	-- template for newly created daily notes (goto_today)
	-- set to `nil` or do not specify if you do not want a template
	template_new_daily = notes .. "/" .. "templates/daily.md",

	-- template for newly created weekly notes (goto_thisweek)
	-- set to `nil` or do not specify if you do not want a template
	template_new_weekly = notes .. "/" .. "templates/weekly.md",

	-- image link style
	-- wiki:     ![[image name]]
	-- markdown: ![](image_subdir/xxxxx.png)
	image_link_style = "markdown",

	-- integrate with calendar-vim
	plug_into_calendar = true,
	calendar_opts = {
		-- calendar week display mode: 1 .. 'WK01', 2 .. 'WK 1', 3 .. 'KW01', 4 .. 'KW 1', 5 .. '1'
		weeknm = 4,
		-- use monday as first day of week: 1 .. true, 0 .. false
		calendar_monday = 1,
		-- calendar mark: where to put mark for marked days: 'left', 'right', 'left-fit'
		calendar_mark = "left-fit",
	},

	-- telescope actions behavior
	close_after_yanking = false,
	insert_after_inserting = true,

	-- tag notation: '#tag', ':tag:', 'yaml-bare'
	tag_notation = "yaml-bare",

	-- command palette theme: dropdown (window) or ivy (bottom panel)
	command_palette_theme = "ivy",

	-- tag list theme:
	-- get_cursor: small tag list at cursor; ivy and dropdown like above
	show_tags_theme = "ivy",

	-- when linking to a note in subdir/, create a [[subdir/title]] link
	-- instead of a [[title only]] link
	subdirs_in_links = true,

	-- template_handling
	-- What to do when creating a new note via `new_note()` or `follow_link()`
	-- to a non-existing note
	-- - prefer_new_note: use `new_note` template
	-- - smart: if day or week is detected in title, use daily / weekly templates (default)
	-- - always_ask: always ask before creating a note
	template_handling = "smart",

	-- path handling:
	--   this applies to:
	--     - new_note()
	--     - new_templated_note()
	--     - follow_link() to non-existing note
	--
	--   it does NOT apply to:
	--     - goto_today()
	--     - goto_thisweek()
	--
	--   Valid options:
	--     - smart: put daily-looking notes in daily, weekly-looking ones in weekly,
	--              all other ones in home, except for notes/with/subdirs/in/title.
	--              (default)
	--
	--     - prefer_home: put all notes in home except for goto_today(), goto_thisweek()
	--                    except for notes with subdirs/in/title.
	--
	--     - same_as_current: put all new notes in the dir of the current note if
	--                        present or else in home
	--                        except for notes/with/subdirs/in/title.
	new_note_location = "smart",
})

-- Autocommands (https://neovim.io/doc/user/autocmd.html)
lvim.autocommands.custom_groups = {
	{ "BufWinEnter", "*.md", "setlocal wrap linebreak spell filetype=markdown" },
	{
		"BufWinEnter",
		"*.markdown",
		"setlocal wrap linebreak spell filetype=markdown",
	},
	{ "BufWinEnter", "*.tmpl", "setlocal filetype=gotexttmpl" },
	{ "BufWinEnter", "*.tpl", "setlocal filetype=gotexttmpl" },
	{ "BufRead", "$HOME/.mutt/temp*", "setlocal filetype=mail" },
	{ "Filetype", "mail", "setlocal textwidth=72 wrap spell" },
	{ "Filetype", "mail", "setlocal fo+=aw" },
	{
		"Filetype",
		"telekasten",
		"hi tklink guifg=#00dfff|hi tkBrackets guifg=#264F78 |hi tkHighlight guibg=#ff007c guifg=#9d0006 gui=bold",
	},
	{
		"BufWritePre",
		"$HOME/notes/**/*.md",
		"mark a|silent! 1,10s/^modified: [\\d]{4}.*/\\=strftime('modified: %FT%T%z')/|norm!`a",
	},
}
