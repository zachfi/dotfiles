return {

	-- tokyonight
	{
		"folke/tokyonight.nvim",
		lazy = false,
		opts = { style = "moon" },
		priority = 1000, -- make sure to load this before all the other start plugins
		config = function()
			-- load the colorscheme here
			vim.cmd([[colorscheme tokyonight]])
		end,
	},

	-- catppuccin
	{
		"catppuccin/nvim",
		lazy = true,
		name = "catppuccin",
	},

	{
		"marko-cerovac/material.nvim",
	},

	-- gruvbox
	{
		"ellisonleao/gruvbox.nvim",
	},

	--kanagawa
	{
		"rebelot/kanagawa.nvim",
	},
	--[[ { ]]
	--[[   "olimorris/onedarkpro.nvim", ]]
	--[[ }, ]]
	{
		"navarasu/onedark.nvim",
	},
	{
		"cocopon/iceberg.vim",
	},

	{
		"jacoborus/tender.vim",
	},

	{
		"sainnhe/sonokai",
	},

	{
		"sainnhe/edge",
	},

	{
		"ajmwagar/vim-deus",
	},

	{
		"fenetikm/falcon",
	},

	{
		"bluz71/vim-moonfly-colors",
		branch = "cterm-compat",
	},

	{
		"rakr/vim-one",
	},

	{
		"sainnhe/everforest",
	},

	{
		"EdenEast/nightfox.nvim",
	},

	{ "bluz71/vim-nightfly-colors", as = "nightfly" },

	{
		"tomasr/molokai",
	},

	{
		"ray-x/starry.nvim",
	},

	{
		"craftzdog/solarized-osaka.nvim",
		lazy = false,
		priority = 1000,
		opts = {},
	},

	{
		"NLKNguyen/papercolor-theme",
	},
}
