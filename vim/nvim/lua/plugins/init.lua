return {
	"nvim-lua/popup.nvim", -- An implementation of the Popup API from vim in Neovim
	"nvim-lua/plenary.nvim", -- Useful lua functions used ny lots of plugins
	"windwp/nvim-autopairs", -- Autopairs, integrates with both cmp and treesitter
	"numToStr/Comment.nvim", -- Easily comment stuff
	"nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
	"MunifTanjim/nui.nvim",
	{
		"nvim-neo-tree/neo-tree.nvim",
		branch = "v2.x",
		dependencies = {
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
	"rcarriga/nvim-notify",
	"preservim/tagbar",

	{
		"folke/todo-comments.nvim",
		dependencies = {
			"nvim-lua/plenary.nvim",
		},
		cmd = { "TodoTrouble", "TodoTelescope" },
		event = { "BufReadPost", "BufNewFile" },
		config = true,
  -- stylua: ignore
  keys = {
    { "]t", function() require("todo-comments").jump_next() end, desc = "Next todo comment" },
    { "[t", function() require("todo-comments").jump_prev() end, desc = "Previous todo comment" },
    { "<leader>xt", "<cmd>TodoTrouble<cr>", desc = "Todo (Trouble)" },
    { "<leader>xT", "<cmd>TodoTrouble keywords=TODO,FIX,FIXME<cr>", desc = "Todo/Fix/Fixme (Trouble)" },
    { "<leader>st", "<cmd>TodoTelescope<cr>", desc = "Todo" },
    { "<leader>sT", "<cmd>TodoTelescope keywords=TODO,FIX,FIXME<cr>", desc = "Todo/Fix/Fixme" },
  },
	},

	{
		"folke/trouble.nvim",
		dependencies = {
			"nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
		},
		opts = { use_diagnostic_signs = true },
	},

	-- colorschemes
	"ellisonleao/gruvbox.nvim",
	"rebelot/kanagawa.nvim
",
	{
		"folke/tokyonight.nvim",
		lazy = false, -- make sure we load this during startup if it is your main colorscheme
		priority = 1000, -- make sure to load this before all the other start plugins
		config = function()
			-- load the colorscheme here
			vim.cmd([[colorscheme tokyonight]])
		end,
		opts = { style = "moon" },
	},
	"LunarVim/onedarker",
  "olimorris/onedarkpro.nvim"
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
	{
		"catppuccin/nvim",
		lazy = true,
		name = "catppuccin",
	},

	-- cmp plugins
	{
		"hrsh7th/nvim-cmp",
		version = false, -- last release is way too old
		event = "InsertEnter",
		dependencies = {
			"hrsh7th/cmp-nvim-lsp",
			"hrsh7th/cmp-buffer",
			"hrsh7th/cmp-path",
			"saadparwaiz1/cmp_luasnip",
			"hrsh7th/cmp-nvim-lsp",
			"hrsh7th/cmp-nvim-lua",
			"hrsh7th/cmp-nvim-lsp-signature-help",
		},
		opts = function()
			local cmp = require("cmp")
			return {
				completion = {
					completeopt = "menu,menuone,noinsert",
				},
				snippet = {
					expand = function(args)
						require("luasnip").lsp_expand(args.body)
					end,
				},
				mapping = cmp.mapping.preset.insert({
					["<C-n>"] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Select }), -- Or Insert instead of Select
					["<C-p>"] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Select }),
					["<C-b>"] = cmp.mapping.scroll_docs(-3),
					["<C-f>"] = cmp.mapping.scroll_docs(3),
					["<C-Space>"] = cmp.mapping.complete(),
					["<C-e>"] = cmp.mapping.abort(),
					["<CR>"] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
					["<S-CR>"] = cmp.mapping.confirm({
						behavior = cmp.ConfirmBehavior.Replace,
						select = true,
					}), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
				}),
				sources = cmp.config.sources({
					{ name = "nvim_lsp" },
					{ name = "luasnip" },
					{ name = "buffer" },
					{ name = "path" },
					{ name = "git" },
					{ name = "nvim_lsp_signature_help" },
				}),
				formatting = {
					format = function(entry, item)
						local icons = require("user.config").icons.kinds
						if icons[item.kind] then
							item.kind = icons[item.kind] .. item.kind
						end
						item.menu = ({
							nvim_lsp = "[LSP]",
							nvim_lua = "[NvimLua]",
							luasnip = "[Snippet]",
							buffer = "[Buffer]",
							path = "[Path]",
							git = "[Git]",
							nvim_lsp_signature_help = "[LSP Signature]",
						})[entry.source.name]
						return item
					end,
				},
				experimental = {
					ghost_text = {
						hl_group = "LspCodeLens",
					},
				},
			}
		end,
	},
	{
		"petertriho/cmp-git",
		dependencies = {
			"nvim-lua/plenary.nvim",
		},
	},
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
	"mfussenegger/nvim-dap",
	"theHamsta/nvim-dap-virtual-text",
	"rcarriga/nvim-dap-ui",

	-- Telescope
	"nvim-telescope/telescope.nvim",

	-- Treesitter
	{
		"nvim-treesitter/nvim-treesitter",
		run = ":TSUpdate",
	},
	"JoosepAlviste/nvim-ts-context-commentstring",

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
			user_icon = "👤", -- user icon
			timeline_marker = "🗨", -- timeline marker
			right_bubble_delimiter = "", -- Bubble delimiter
			left_bubble_delimiter = "", -- Bubble delimiter
		},
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
