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

require("lazy").setup({
	"folke/which-key.nvim",

	"wbthomason/packer.nvim", -- Have packer manage itself
	"nvim-lua/popup.nvim", -- An implementation of the Popup API from vim in Neovim
	"nvim-lua/plenary.nvim", -- Useful lua functions used ny lots of plugins
	"windwp/nvim-autopairs", -- Autopairs, integrates with both cmp and treesitter
	"numToStr/Comment.nvim", -- Easily comment stuff
	"kyazdani42/nvim-web-devicons",
	{
		"nvim-neo-tree/neo-tree.nvim",
		branch = "v2.x",
		requires = {
			"nvim-lua/plenary.nvim",
			"nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
			"MunifTanjim/nui.nvim",
		},
	},
	"akinsho/bufferline.nvim",
	"moll/vim-bbye",
	"nvim-lualine/lualine.nvim",
	"akinsho/toggleterm.nvim",
	"ahmedkhalf/project.nvim",
	"lewis6991/impatient.nvim",
	"lukas-reineke/indent-blankline.nvim",
	--[[ "goolord/alpha-nvim") ]]
	"antoinemadec/FixCursorHold.nvim", -- This is needed to fix lsp doc highlight
	"folke/which-key.nvim",
	"rcarriga/nvim-notify",
	{ "majutsushi/tagbar" },

	-- Lua
	{
		"folke/trouble.nvim",
		requires = "kyazdani42/nvim-web-devicons",
		config = function()
			require("trouble").setup({
				use_diagnostic_signs = true,
			})
		end,
	},

	-- colorschemes
	"ellisonleao/gruvbox.nvim",
	"folke/tokyonight.nvim",
	"LunarVim/onedarker",
	"cocopon/iceberg.vim",
	"jacoborus/tender.vim",
	"sainnhe/sonokai",
	"sainnhe/edge",
	"ajmwagar/vim-deus",
	"fenetikm/falcon",
	{ "bluz71/vim-moonfly-colors", branch = "cterm-compat" },
	"rakr/vim-one",
	"sainnhe/everforest",
	"EdenEast/nightfox.nvim",
	{
		"sonph/onehalf",
		rtp = "vim",
		-- config = function()
		-- 	vim.cmd([[colorscheme onehalfdark]])
		-- end,
		-- event = "VimEnter",
	},
	{ "bluz71/vim-nightfly-colors", as = "nightfly" },

	"tomasr/molokai",
	"ray-x/starry.nvim",

	-- cmp plugins
	"hrsh7th/nvim-cmp", -- The completion plugin
	"hrsh7th/cmp-buffer", -- buffer completions
	"hrsh7th/cmp-path", -- path completions
	"hrsh7th/cmp-cmdline", -- cmdline completions
	"saadparwaiz1/cmp_luasnip", -- snippet completions
	"hrsh7th/cmp-nvim-lsp",
	"hrsh7th/cmp-nvim-lua",
	"hrsh7th/cmp-nvim-lsp-signature-help",
	{ "petertriho/cmp-git", requires = "nvim-lua/plenary.nvim" },
	"ray-x/go.nvim",
	"ray-x/guihua.lua", -- recommended if need floating window support

	-- snippets
	"L3MON4D3/LuaSnip", --snippet engine
	"rafamadriz/friendly-snippets", -- a bunch of snippets to use

	-- LSP
	"neovim/nvim-lspconfig",
	"williamboman/mason.nvim",
	"williamboman/mason-lspconfig.nvim",
	"tamago324/nlsp-settings.nvim", -- language server settings defined in json for
	"jose-elias-alvarez/null-ls.nvim", -- for formatters and linters
	"folke/lua-dev.nvim",
	"RRethy/vim-illuminate",
	"mfussenegger/nvim-dap",

	-- Telescope
	"nvim-telescope/telescope.nvim",

	-- Treesitter
	{
		"nvim-treesitter/nvim-treesitter",
		run = ":TSUpdate",
	},
	"JoosepAlviste/nvim-ts-context-commentstring",

	-- Git
	"lewis6991/gitsigns.nvim",
	"tpope/vim-fugitive",
	"tpope/vim-rhubarb",

	-- Github
	"github/copilot.vim",
	{
		"pwntester/octo.nvim",
		requires = {
			"nvim-lua/plenary.nvim",
			"nvim-telescope/telescope.nvim",
			"kyazdani42/nvim-web-devicons",
		},
		config = function()
			require("octo").setup({
				reaction_viewer_hint_icon = "", -- marker for user reactions
				user_icon = "👤", -- user icon
				timeline_marker = "🗨", -- timeline marker
				right_bubble_delimiter = "", -- Bubble delimiter
				left_bubble_delimiter = "", -- Bubble delimiter
			})
		end,
	},

	-- Syntax
	"google/vim-jsonnet",
	"ap/vim-css-color",
	"jjo/vim-cue",
	"mustache/vim-mustache-handlebars",
	"towolf/vim-helm",
	{
		"iamcco/markdown-preview.nvim",
		run = function()
			vim.fn["mkdp#util#install"]()
		end,
	},

	-- ZK for notes
	"mickael-menu/zk-nvim",
})
