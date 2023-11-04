return {
	-- indent guides for Neovim
	{
		"lukas-reineke/indent-blankline.nvim",
		event = { "BufReadPost", "BufNewFile" },
		main = "ibl",
		opts = {
			indent = { char = "│" },
			scope = {
				show_start = false,
				show_end = false,
			},
			-- char = "▏",
			--[[ char = "│", ]]
			--[[ filetype_exclude = { "help", "alpha", "dashboard", "neo-tree", "Trouble", "lazy" }, ]]
			--[[ show_trailing_blankline_indent = false, ]]
			--[[ show_current_context = false, ]]
		},
	},
}
