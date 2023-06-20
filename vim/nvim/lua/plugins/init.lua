return {
	"nvim-lua/popup.nvim", -- An implementation of the Popup API from vim in Neovim
	"nvim-lua/plenary.nvim", -- Useful lua functions used ny lots of plugins
	{
		"nvim-neo-tree/neo-tree.nvim",
		branch = "v2.x",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
			"MunifTanjim/nui.nvim",
		},
	},
	--[[ "ahmedkhalf/project.nvim", ]]
	"antoinemadec/FixCursorHold.nvim", -- This is needed to fix lsp doc highlight
	--[[ "preservim/tagbar", ]]

	{
		"folke/trouble.nvim",
		dependencies = {
			"nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
		},
		opts = { use_diagnostic_signs = true },
	},

	-- snippets
	"L3MON4D3/LuaSnip", --snippet engine
	"rafamadriz/friendly-snippets", -- a bunch of snippets to use

	-- Debug
	"folke/lua-dev.nvim",
	"mfussenegger/nvim-dap",
	"theHamsta/nvim-dap-virtual-text",
	"rcarriga/nvim-dap-ui",

	-- Telescope
	"nvim-telescope/telescope.nvim",

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

	-- ZK for notes
	{
		"mickael-menu/zk-nvim",
		opts = {
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
		config = function(_, opts)
			local zk = require("zk")
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
		end,
	},

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
