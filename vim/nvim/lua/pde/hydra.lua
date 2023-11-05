local function gitsigns_menu()
	local gitsigns = require("gitsigns")

	local hint = [[
 _J_: Next hunk   _s_: Stage Hunk        _d_: Show Deleted   _b_: Blame Line
 _K_: Prev hunk   _u_: Undo Last Stage   _p_: Preview Hunk   _B_: Blame Show Full
 ^ ^              _S_: Stage Buffer      ^ ^                 _/_: Show Base File
 ^
 ^ ^              _<Enter>_: Neogit              _q_: Exit
]]

	return {
		name = "Git",
		hint = hint,
		config = {
			color = "pink",
			invoke_on_body = true,
			hint = {
				border = "rounded",
				position = "bottom",
			},
			on_enter = function()
				vim.cmd("mkview")
				vim.cmd("silent! %foldopen!")
				vim.bo.modifiable = false
				gitsigns.toggle_signs(true)
				gitsigns.toggle_linehl(true)
			end,
			on_exit = function()
				local cursor_pos = vim.api.nvim_win_get_cursor(0)
				vim.cmd("loadview")
				vim.api.nvim_win_set_cursor(0, cursor_pos)
				vim.cmd("normal zv")
				gitsigns.toggle_signs(false)
				gitsigns.toggle_linehl(false)
				gitsigns.toggle_deleted(false)
			end,
		},
		body = "<A-g>",
		heads = {
			{
				"J",
				function()
					if vim.wo.diff then
						return "]c"
					end
					vim.schedule(function()
						gitsigns.next_hunk()
					end)
					return "<Ignore>"
				end,
				{ expr = true, desc = "Next Hunk" },
			},
			{
				"K",
				function()
					if vim.wo.diff then
						return "[c"
					end
					vim.schedule(function()
						gitsigns.prev_hunk()
					end)
					return "<Ignore>"
				end,
				{ expr = true, desc = "Prev Hunk" },
			},
			{ "s", ":Gitsigns stage_hunk<CR>", { silent = true, desc = "Stage Hunk" } },
			{ "u", gitsigns.undo_stage_hunk, { desc = "Undo Last Stage" } },
			{ "S", gitsigns.stage_buffer, { desc = "Stage Buffer" } },
			{ "p", gitsigns.preview_hunk, { desc = "Preview Hunk" } },
			{ "d", gitsigns.toggle_deleted, { nowait = true, desc = "Toggle Deleted" } },
			{ "b", gitsigns.blame_line, { desc = "Blame" } },
			{
				"B",
				function()
					gitsigns.blame_line({ full = true })
				end,
				{ desc = "Blame Show Full" },
			},
			{ "/", gitsigns.show, { exit = true, desc = "Show Base File" } }, -- show the base of the file
			{ "<Enter>", "<Cmd>Neogit<CR>", { exit = true, desc = "Neogit" } },
			{ "q", nil, { exit = true, nowait = true, desc = "Exit" } },
		},
	}
end

local function dap_menu()
	local dap = require("dap")
	local dapui = require("dapui")
	local dap_widgets = require("dap.ui.widgets")

	local hint = [[
 _t_: Toggle Breakpoint             _R_: Run to Cursor
 _s_: Start                         _E_: Evaluate Input
 _c_: Continue                      _C_: Conditional Breakpoint
 _b_: Step Back                     _U_: Toggle UI
 _d_: Disconnect                    _S_: Scopes
 _e_: Evaluate                      _X_: Close
 _g_: Get Session                   _i_: Step Into
 _h_: Hover Variables               _o_: Step Over
 _r_: Toggle REPL                   _u_: Step Out
 _x_: Terminate                     _p_: Pause
 ^ ^               _q_: Quit
]]

	return {
		name = "Debug",
		hint = hint,
		config = {
			color = "pink",
			invoke_on_body = true,
			hint = {
				border = "rounded",
				position = "middle-right",
			},
		},
		mode = "n",
		body = "<A-d>",
    -- stylua: ignore
    heads = {
      { "C", function() dap.set_breakpoint(vim.fn.input "[Condition] > ") end, desc = "Conditional Breakpoint", },
      { "E", function() dapui.eval(vim.fn.input "[Expression] > ") end,        desc = "Evaluate Input", },
      { "R", function() dap.run_to_cursor() end,                               desc = "Run to Cursor", },
      { "S", function() dap_widgets.scopes() end,                              desc = "Scopes", },
      { "U", function() dapui.toggle() end,                                    desc = "Toggle UI", },
      { "X", function() dap.close() end,                                       desc = "Quit", },
      { "b", function() dap.step_back() end,                                   desc = "Step Back", },
      { "c", function() dap.continue() end,                                    desc = "Continue", },
      { "d", function() dap.disconnect() end,                                  desc = "Disconnect", },
      {
        "e",
        function() dapui.eval() end,
        mode = { "n", "v" },
        desc =
        "Evaluate",
      },
      { "g", function() dap.session() end,           desc = "Get Session", },
      { "h", function() dap_widgets.hover() end,     desc = "Hover Variables", },
      { "i", function() dap.step_into() end,         desc = "Step Into", },
      { "o", function() dap.step_over() end,         desc = "Step Over", },
      { "p", function() dap.pause.toggle() end,      desc = "Pause", },
      { "r", function() dap.repl.toggle() end,       desc = "Toggle REPL", },
      { "s", function() dap.continue() end,          desc = "Start", },
      { "t", function() dap.toggle_breakpoint() end, desc = "Toggle Breakpoint", },
      { "u", function() dap.step_out() end,          desc = "Step Out", },
      { "x", function() dap.terminate() end,         desc = "Terminate", },
      { "q", nil, {
        exit = true,
        nowait = true,
        desc = "Exit"
      } },
    },
	}
end

local function options_menu()
	local hint = [[
  ^ ^        Options
  ^
  _v_ %{ve} virtual edit
  _i_ %{list} invisible characters
  _s_ %{spell} spell
  _w_ %{wrap} wrap
  _c_ %{cul} cursor line
  _n_ %{nu} number
  _r_ %{rnu} relative number
  ^
       ^^^^                _<Esc>_
]]

	return {
		name = "Options",
		hint = hint,
		config = {
			color = "amaranth",
			invoke_on_body = true,
			hint = {
				border = "rounded",
				position = "middle",
			},
		},
		mode = { "n", "x" },
		body = "<leader>o",
		heads = {
			{
				"n",
				function()
					if vim.o.number == true then
						vim.o.number = false
					else
						vim.o.number = true
					end
				end,
				{ desc = "number" },
			},
			{
				"r",
				function()
					if vim.o.relativenumber == true then
						vim.o.relativenumber = false
					else
						vim.o.number = true
						vim.o.relativenumber = true
					end
				end,
				{ desc = "relativenumber" },
			},
			{
				"v",
				function()
					if vim.o.virtualedit == "all" then
						vim.o.virtualedit = "block"
					else
						vim.o.virtualedit = "all"
					end
				end,
				{ desc = "virtualedit" },
			},
			{
				"i",
				function()
					if vim.o.list == true then
						vim.o.list = false
					else
						vim.o.list = true
					end
				end,
				{ desc = "show invisible" },
			},
			{
				"s",
				function()
					if vim.o.spell == true then
						vim.o.spell = false
					else
						vim.o.spell = true
					end
				end,
				{ exit = true, desc = "spell" },
			},
			{
				"w",
				function()
					if vim.o.wrap ~= true then
						vim.o.wrap = true
						-- Dealing with word wrap:
						-- If cursor is inside very long line in the file than wraps
						-- around several rows on the screen, then 'j' key moves you to
						-- the next line in the file, but not to the next row on the
						-- screen under your previous position as in other editors. These
						-- bindings fixes this.
						vim.keymap.set("n", "k", function()
							return vim.v.count > 0 and "k" or "gk"
						end, { expr = true, desc = "k or gk" })
						vim.keymap.set("n", "j", function()
							return vim.v.count > 0 and "j" or "gj"
						end, { expr = true, desc = "j or gj" })
					else
						vim.o.wrap = false
						vim.keymap.del("n", "k")
						vim.keymap.del("n", "j")
					end
				end,
				{ desc = "wrap" },
			},
			{
				"c",
				function()
					if vim.o.cursorline == true then
						vim.o.cursorline = false
					else
						vim.o.cursorline = true
					end
				end,
				{ desc = "cursor line" },
			},
			{ "<Esc>", nil, { exit = true } },
		},
	}
end

local function telescope_menu()
	local hint = [[
                 _f_: files       _m_: marks
   🭇🬭🬭🬭🬭🬭🬭🬭🬭🬼    _o_: old files   _g_: live grep
  🭉🭁🭠🭘    🭣🭕🭌🬾   _p_: projects    _/_: search in file
  🭅█ ▁     █🭐
  ██🬿      🭊██   _r_: resume      _u_: undotree
 🭋█🬝🮄🮄🮄🮄🮄🮄🮄🮄🬆█🭀  _h_: vim help    _c_: execute command
 🭤🭒🬺🬹🬱🬭🬭🬭🬭🬵🬹🬹🭝🭙  _k_: keymaps     _;_: commands history
                 _O_: options     _?_: search history
 ^
                 _<Enter>_: Telescope           _<Esc>_
]]

	local cmd = require("hydra.keymap-util").cmd

	return {
		name = "Telescope",
		hint = hint,
		config = {
			color = "teal",
			invoke_on_body = true,
			hint = {
				position = "middle",
				border = "rounded",
			},
		},
		mode = "n",
		body = "<A-t>",
		heads = {
			{ "f", cmd("Telescope find_files") },
			{ "g", cmd("Telecope live_grep") },
			{ "o", cmd("Telescope oldfiles"), { desc = "recently opened files" } },
			{ "h", cmd("Telescope help_tags"), { desc = "vim help" } },
			{ "m", cmd("MarksListBuf"), { desc = "marks" } },
			{ "k", cmd("Telescope keymaps") },
			{ "O", cmd("Telescope vim_options") },
			{ "r", cmd("Telescope resume") },
			{ "p", cmd("Telescope projects"), { desc = "projects" } },
			{ "/", cmd("Telescope current_buffer_fuzzy_find"), { desc = "search in file" } },
			{ "?", cmd("Telescope search_history"), { desc = "search history" } },
			{ ";", cmd("Telescope command_history"), { desc = "command-line history" } },
			{ "c", cmd("Telescope commands"), { desc = "execute command" } },
			{ "u", cmd("silent! %foldopen! | UndotreeToggle"), { desc = "undotree" } },
			{ "<Enter>", cmd("Telescope"), { exit = true, desc = "list all pickers" } },
			{ "<Esc>", nil, { exit = true, nowait = true } },
		},
	}
end

local function github_menu()
	local hint = [[
  ^ ^        Options
  ^
  _g_ gist list
  _i_ my issues
  _I_ issue browser
  _p_ my PRs
  _P_ PR browser

  ^^^^^                _<Esc>_
]]

	local cmd = require("hydra.keymap-util").cmd

	return {
		name = "GitHub",
		hint = hint,
		config = {
			color = "teal",
			invoke_on_body = true,
			hint = {
				position = "middle",
				border = "rounded",
			},
		},
		mode = "n",
		body = "<A-h>",
		heads = {
			{ "g", cmd("Octo gist list") },
			{ "i", cmd("Octo search is:open is:issue assignee:zalegrala archived:false") },
			{ "I", cmd("Octo issue browser") },
			{ "p", cmd("Octo search is:open is:pr author:zalegrala archived:false") },
			{ "P", cmd("Octo pr browser") },
			{
				"<Esc>",
				nil,
				{ exit = true, nowait = true },
			},
		},
	}
end

local function pde_menu()
	local hint = [[
  ^ ^        Options
  ^
  _t_ Twilight
  _o_ Go package outline
  _d_ Todo trouble
  _r_ Trouble toggle


  ^^^^^                _<Esc>_
]]

	local cmd = require("hydra.keymap-util").cmd

	return {
		name = "GitHub",
		hint = hint,
		config = {
			color = "teal",
			invoke_on_body = true,
			hint = {
				position = "middle-right",
				border = "rounded",
			},
		},
		mode = "n",
		body = "<A-p>",
		heads = {
			{ "t", cmd("Twilight") },
			{ "o", cmd("GoPkgOutline") },
			{ "d", cmd("TodoTrouble") },
			{ "r", cmd("TroubleToggle") },
			{
				"<Esc>",
				nil,
				{ exit = true, nowait = true },
			},
		},
	}
end

return {
	{
		"anuvyklack/hydra.nvim",
		event = "VeryLazy",
		config = function(_, _)
			local Hydra = require("hydra")
			Hydra(gitsigns_menu())
			Hydra(dap_menu())
			Hydra(options_menu())
			Hydra(telescope_menu())
			Hydra(github_menu())
			Hydra(pde_menu())
		end,
	},
}
