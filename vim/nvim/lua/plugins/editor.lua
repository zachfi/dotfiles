return {

	-- which-key
	{
		"folke/which-key.nvim",
		event = "VeryLazy",
		opts = {
			plugins = {
				marks = true, -- shows a list of your marks on ' and `
				registers = true, -- shows your registers on " in NORMAL or <C-r> in INSERT mode
				spelling = {
					enabled = true, -- enabling this will show WhichKey when pressing z= to select spelling suggestions
					suggestions = 20, -- how many suggestions should be shown in the list?
				},
				-- the presets plugin, adds help for a bunch of default keybindings in Neovim
				-- No actual key bindings are created
				presets = {
					operators = false, -- adds help for operators like d, y, ... and registers them for motion / text object completion
					motions = true, -- adds help for motions
					text_objects = true, -- help for text objects triggered after entering an operator
					windows = true, -- default bindings on <c-w>
					nav = true, -- misc bindings to work with windows
					z = true, -- bindings for folds, spelling and others prefixed with z
					g = true, -- bindings for prefixed with g
				},
			},
			-- add operators that will trigger motion and text object completion
			-- to enable all native operators, set the preset / operators plugin above
			-- operators = { gc = "Comments" },
			key_labels = {
				-- override the label used to display some keys. It doesn't effect WK in any other way.
				-- For example:
				-- ["<space>"] = "SPC",
				-- ["<cr>"] = "RET",
				-- ["<tab>"] = "TAB",
			},
			icons = {
				breadcrumb = "»", -- symbol used in the command line area that shows your active key combo
				separator = "➜", -- symbol used between a key and it's label
				group = "+", -- symbol prepended to a group
			},
			popup_mappings = {
				scroll_down = "<c-d>", -- binding to scroll down inside the popup
				scroll_up = "<c-u>", -- binding to scroll up inside the popup
			},
			window = {
				border = "rounded", -- none, single, double, shadow
				position = "bottom", -- bottom, top
				margin = { 1, 0, 1, 0 }, -- extra window margin [top, right, bottom, left]
				padding = { 2, 2, 2, 2 }, -- extra window padding [top, right, bottom, left]
				winblend = 0,
			},
			layout = {
				height = { min = 4, max = 25 }, -- min and max height of the columns
				width = { min = 20, max = 50 }, -- min and max width of the columns
				spacing = 3, -- spacing between columns
				align = "left", -- align columns left, center or right
			},
			ignore_missing = true, -- enable this to hide mappings for which you didn't specify a label
			hidden = { "<silent>", "<cmd>", "<Cmd>", "<CR>", "call", "lua", "^:", "^ " }, -- hide mapping boilerplate
			show_help = true, -- show help message on the command line when the popup is visible
			triggers = "auto", -- automatically setup triggers
			-- triggers = {"<leader>"} -- or specify a list manually
			triggers_blacklist = {
				-- list of mode / prefixes that should never be hooked by WhichKey
				-- this is mostly relevant for key maps that start with a native binding
				-- most people should not need to change this
				i = { "j", "k" },
				v = { "j", "k" },
			},

			defaults = {
				mode = { "n", "v" },
				prefix = "<leader>",
				buffer = nil, -- Global mappings. Specify a buffer number for buffer local mappings
				silent = true, -- use `silent` when creating keymaps
				noremap = true, -- use `noremap` when creating keymaps
				nowait = true, -- use `nowait` when creating keymaps

				-- ["g"] = { name = "+goto" },
				-- ["gz"] = { name = "+surround" },
				-- ["]"] = { name = "+next" },
				-- ["["] = { name = "+prev" },
				-- ["<leader><tab>"] = { name = "+tabs" },
				-- ["<leader>b"] = { name = "+buffer" },
				-- ["<leader>c"] = { name = "+code" },
				-- ["<leader>f"] = { name = "+file/find" },
				-- ["<leader>g"] = { name = "+git" },
				-- ["<leader>gh"] = { name = "+hunks" },
				-- ["<leader>q"] = { name = "+quit/session" },
				-- ["<leader>s"] = { name = "+search" },
				-- ["<leader>u"] = { name = "+ui" },
				-- ["<leader>w"] = { name = "+windows" },
				-- ["<leader>x"] = { name = "+diagnostics/quickfix" },

				["/"] = { ":nohls<CR>", "Clear search" },

				["a"] = { "<cmd>Alpha<cr>", "Alpha" },
				["b"] = {
					"<cmd>lua require('telescope.builtin').buffers(require('telescope.themes').get_dropdown{previewer = false})<cr>",
					"Buffers",
				},
				-- ["e"] = { "<cmd>Neotree<cr>", "File Explorer" },
				e = {
					name = "NeoTree",
					e = { "<cmd>Neotree toggle current reveal_force_cwd<cr>", "Explore" },
					r = { "<cmd>Neotree toggle reveal<cr>", "Explore" },
					b = { "<cmd>Neotree toggle show buffers right<cr>", "Buffers" },
					s = { "<cmd>Neotree toggle float git_status<cr>", "Reveal" },
				},
				["w"] = { "<cmd>w!<CR>", "Save" },
				["q"] = { "<cmd>q!<CR>", "Quit" },
				["c"] = { "<cmd>Bdelete!<CR>", "Close Buffer" },
				["F"] = { "<cmd>Telescope live_grep theme=ivy<cr>", "Find Text" },
				["P"] = { "<cmd>lua require('telescope').extensions.projects.projects()<cr>", "Projects" },

				["d"] = { "<cmd>lua FindFiles()<CR>", "Find files from working directory" },
				["f"] = { "<cmd>lua FindFilesRelative()<CR>", "Find files relative to the current buffer" },

				p = {
					name = "Packer",
					c = { "<cmd>PackerCompile<cr>", "Compile" },
					i = { "<cmd>PackerInstall<cr>", "Install" },
					s = { "<cmd>PackerSync<cr>", "Sync" },
					S = { "<cmd>PackerStatus<cr>", "Status" },
					u = { "<cmd>PackerUpdate<cr>", "Update" },
				},

				g = {
					name = "Git",
					g = { "<cmd>lua _LAZYGIT_TOGGLE()<CR>", "Lazygit" },
					j = { "<cmd>lua require 'gitsigns'.next_hunk()<cr>", "Next Hunk" },
					k = { "<cmd>lua require 'gitsigns'.prev_hunk()<cr>", "Prev Hunk" },
					l = { "<cmd>lua require 'gitsigns'.blame_line()<cr>", "Blame" },
					p = { "<cmd>lua require 'gitsigns'.preview_hunk()<cr>", "Preview Hunk" },
					r = { "<cmd>lua require 'gitsigns'.reset_hunk()<cr>", "Reset Hunk" },
					R = { "<cmd>lua require 'gitsigns'.reset_buffer()<cr>", "Reset Buffer" },
					s = { "<cmd>lua require 'gitsigns'.stage_hunk()<cr>", "Stage Hunk" },
					u = {
						"<cmd>lua require 'gitsigns'.undo_stage_hunk()<cr>",
						"Undo Stage Hunk",
					},
					o = { "<cmd>Telescope git_status<cr>", "Open changed file" },
					b = { "<cmd>Telescope git_branches<cr>", "Checkout branch" },
					c = { "<cmd>Telescope git_commits<cr>", "Checkout commit" },
					d = {
						"<cmd>Gitsigns diffthis HEAD<cr>",
						"Diff",
					},
				},

				h = {
					name = "GitHub",
					i = { "<cmd>Octo search is:open is:issue assignee:zalegrala archived:false<cr>", "My open issues" },
					I = { "<cmd>Octo issue browser<cr>", "Open issue in browser" },
					p = { "<cmd>Octo search is:open is:pr author:zalegrala archived:false<cr>", "My open PRs" },
					P = { "<cmd>Octo pr browser<cr>", "Open PR in browser" },
				},

				l = {
					name = "LSP",
					a = { "<cmd>lua vim.lsp.buf.code_action()<cr>", "Code Action" },
					d = {
						"<cmd>Telescope lsp_document_diagnostics<cr>",
						"Document Diagnostics",
					},
					w = {
						"<cmd>Telescope lsp_workspace_diagnostics<cr>",
						"Workspace Diagnostics",
					},
					f = { "<cmd>lua vim.lsp.buf.formatting()<cr>", "Format" },
					i = { "<cmd>LspInfo<cr>", "Info" },
					I = { "<cmd>LspInstallInfo<cr>", "Installer Info" },
					j = {
						"<cmd>lua vim.diagnostic.goto_next()<CR>",
						"Next Diagnostic",
					},
					k = {
						"<cmd>lua vim.diagnostic.goto_prev()<cr>",
						"Prev Diagnostic",
					},
					l = { "<cmd>lua vim.lsp.codelens.run()<cr>", "CodeLens Action" },
					q = { "<cmd>lua vim.lsp.diagnostic.set_loclist()<cr>", "Quickfix" },
					r = { "<cmd>lua vim.lsp.buf.rename()<cr>", "Rename" },
					s = { "<cmd>Telescope lsp_document_symbols<cr>", "Document Symbols" },
					S = {
						"<cmd>Telescope lsp_dynamic_workspace_symbols<cr>",
						"Workspace Symbols",
					},
				},
				s = {
					name = "Search",
					b = { "<cmd>Telescope git_branches<cr>", "Checkout branch" },
					c = { "<cmd>Telescope colorscheme<cr>", "Colorscheme" },
					h = { "<cmd>Telescope help_tags<cr>", "Find Help" },
					M = { "<cmd>Telescope man_pages<cr>", "Man Pages" },
					r = { "<cmd>Telescope oldfiles<cr>", "Open Recent File" },
					R = { "<cmd>Telescope registers<cr>", "Registers" },
					k = { "<cmd>Telescope keymaps<cr>", "Keymaps" },
					C = { "<cmd>Telescope commands<cr>", "Commands" },
				},

				t = {
					name = "Terminal",
					n = { "<cmd>lua _NODE_TOGGLE()<cr>", "Node" },
					u = { "<cmd>lua _NCDU_TOGGLE()<cr>", "NCDU" },
					t = { "<cmd>lua _HTOP_TOGGLE()<cr>", "Htop" },
					p = { "<cmd>lua _PYTHON_TOGGLE()<cr>", "Python" },
					f = { "<cmd>ToggleTerm direction=float<cr>", "Float" },
					h = { "<cmd>ToggleTerm size=10 direction=horizontal<cr>", "Horizontal" },
					v = { "<cmd>ToggleTerm size=80 direction=vertical<cr>", "Vertical" },
				},
			},
		},
		config = function(_, opts)
			local wk = require("which-key")
			wk.setup(opts)
			wk.register(opts.defaults)
		end,
	},

	-- git signs
	{
		"lewis6991/gitsigns.nvim",
		event = { "BufReadPre", "BufNewFile" },
		opts = {
			signs = {
				add = { text = "▎" },
				change = { text = "▎" },
				delete = { text = "" },
				topdelete = { text = "" },
				changedelete = { text = "▎" },
				untracked = { text = "▎" },
			},
			on_attach = function(buffer)
				local gs = package.loaded.gitsigns

				local function map(mode, l, r, desc)
					vim.keymap.set(mode, l, r, { buffer = buffer, desc = desc })
				end

        -- stylua: ignore start
        map("n", "]h", gs.next_hunk, "Next Hunk")
        map("n", "[h", gs.prev_hunk, "Prev Hunk")
        map({ "n", "v" }, "<leader>ghs", ":Gitsigns stage_hunk<CR>", "Stage Hunk")
        map({ "n", "v" }, "<leader>ghr", ":Gitsigns reset_hunk<CR>", "Reset Hunk")
        map("n", "<leader>ghS", gs.stage_buffer, "Stage Buffer")
        map("n", "<leader>ghu", gs.undo_stage_hunk, "Undo Stage Hunk")
        map("n", "<leader>ghR", gs.reset_buffer, "Reset Buffer")
        map("n", "<leader>ghp", gs.preview_hunk, "Preview Hunk")
        map("n", "<leader>ghb", function() gs.blame_line({ full = true }) end, "Blame Line")
        map("n", "<leader>ghd", gs.diffthis, "Diff This")
        map("n", "<leader>ghD", function() gs.diffthis("~") end, "Diff This ~")
        map({ "o", "x" }, "ih", ":<C-U>Gitsigns select_hunk<CR>", "GitSigns Select Hunk")
			end,

			signcolumn = true, -- Toggle with `:Gitsigns toggle_signs`
			numhl = true, -- Toggle with `:Gitsigns toggle_numhl`
			linehl = true, -- Toggle with `:Gitsigns toggle_linehl`
			word_diff = true, -- Toggle with `:Gitsigns toggle_word_diff`
			watch_gitdir = {
				interval = 1000,
				follow_files = true,
			},
			attach_to_untracked = true,
			current_line_blame = true, -- Toggle with `:Gitsigns toggle_current_line_blame`
			current_line_blame_opts = {
				virt_text = true,
				virt_text_pos = "eol", -- 'eol' | 'overlay' | 'right_align'
				delay = 1000,
				ignore_whitespace = false,
			},
			current_line_blame_formatter_opts = {
				relative_time = true,
			},
			sign_priority = 6,
			update_debounce = 100,
			status_formatter = nil, -- Use default
			max_file_length = 40000,
			preview_config = {
				-- Options passed to nvim_open_win
				border = "single",
				style = "minimal",
				relative = "cursor",
				row = 0,
				col = 1,
			},
			yadm = {
				enable = false,
			},
		},
	},

	-- references
	{
		"RRethy/vim-illuminate",
		event = { "BufReadPost", "BufNewFile" },
		opts = { delay = 200 },
		config = function(_, opts)
			require("illuminate").configure(opts)

			local function map(key, dir, buffer)
				vim.keymap.set("n", key, function()
					require("illuminate")["goto_" .. dir .. "_reference"](false)
				end, { desc = dir:sub(1, 1):upper() .. dir:sub(2) .. " Reference", buffer = buffer })
			end

			map("]]", "next")
			map("[[", "prev")

			-- also set it after loading ftplugins, since a lot overwrite [[ and ]]
			vim.api.nvim_create_autocmd("FileType", {
				callback = function()
					local buffer = vim.api.nvim_get_current_buf()
					map("]]", "next", buffer)
					map("[[", "prev", buffer)
				end,
			})
		end,
		keys = {
			{ "]]", desc = "Next Reference" },
			{ "[[", desc = "Prev Reference" },
		},
	},

	-- better diagnostics list and others
	{
		"folke/trouble.nvim",
		cmd = { "TroubleToggle", "Trouble" },
		opts = { use_diagnostic_signs = true },
		keys = {
			{ "<leader>xx", "<cmd>TroubleToggle document_diagnostics<cr>", desc = "Document Diagnostics (Trouble)" },
			{ "<leader>xX", "<cmd>TroubleToggle workspace_diagnostics<cr>", desc = "Workspace Diagnostics (Trouble)" },
			{ "<leader>xL", "<cmd>TroubleToggle loclist<cr>", desc = "Location List (Trouble)" },
			{ "<leader>xQ", "<cmd>TroubleToggle quickfix<cr>", desc = "Quickfix List (Trouble)" },
			{
				"[q",
				function()
					if require("trouble").is_open() then
						require("trouble").previous({ skip_groups = true, jump = true })
					else
						vim.cmd.cprev()
					end
				end,
				desc = "Previous trouble/quickfix item",
			},
			{
				"]q",
				function()
					if require("trouble").is_open() then
						require("trouble").next({ skip_groups = true, jump = true })
					else
						vim.cmd.cnext()
					end
				end,
				desc = "Next trouble/quickfix item",
			},
		},
	},

	-- todo comments
	{
		"folke/todo-comments.nvim",
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
}
