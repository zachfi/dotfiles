return {
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

	-- go
	"ray-x/go.nvim",
	"ray-x/guihua.lua", -- recommended if need floating window support
}
