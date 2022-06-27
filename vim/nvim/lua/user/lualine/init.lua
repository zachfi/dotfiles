local status_ok, lualine = pcall(require, "lualine")
if not status_ok then
	return
end

local components = require("user.lualine.components")

local hide_in_width = function()
	return vim.fn.winwidth(0) > 80
end

local diagnostics = {
	"diagnostics",
	sources = { "nvim_diagnostic" },
	sections = { "error", "warn" },
	symbols = { error = " ", warn = " " },
	colored = false,
	update_in_insert = false,
	always_visible = true,
}

local diff = {
	"diff",
	colored = true,
	symbols = { added = " ", modified = " ", removed = " " }, -- changes diff symbols
	cond = hide_in_width,
}

local mode = {
	"mode",
	fmt = function(str)
		return "-- " .. str .. " --"
	end,
}

local filetype = {
	"filetype",
	icons_enabled = false,
	icon = nil,
}

local branch = {
	"branch",
	icons_enabled = true,
	icon = "",
}

local location = {
	"location",
	padding = 0,
}

-- Color table for highlights
local colors = {
	bg = "#202328",
	fg = "#bbc2cf",
	yellow = "#ECBE7B",
	cyan = "#008080",
	darkblue = "#081633",
	green = "#98be65",
	orange = "#FF8800",
	violet = "#a9a1e1",
	magenta = "#c678dd",
	blue = "#51afef",
	red = "#ec5f67",
}

-- cool function for progress
local progress = function()
	local current_line = vim.fn.line(".")
	local total_lines = vim.fn.line("$")
	local chars = { "__", "▁▁", "▂▂", "▃▃", "▄▄", "▅▅", "▆▆", "▇▇", "██" }
	local line_ratio = current_line / total_lines
	local index = math.ceil(line_ratio * #chars)
	return chars[index]
end

local spaces = function()
	return "spaces: " .. vim.api.nvim_buf_get_option(0, "shiftwidth")
end

local function lsp_client(msg)
	msg = msg or ""
	local buf_clients = vim.lsp.buf_get_clients()
	if next(buf_clients) == nil then
		if type(msg) == "boolean" or #msg == 0 then
			return ""
		end
		return msg
	end

	local buf_ft = vim.bo.filetype
	local buf_client_names = {}

	-- add client
	for _, client in pairs(buf_clients) do
		if client.name ~= "null-ls" then
			table.insert(buf_client_names, client.name)
		end
	end

	-- add formatter
	local formatters = require("config.lsp.null-ls.formatters")
	local supported_formatters = formatters.list_registered(buf_ft)
	vim.list_extend(buf_client_names, supported_formatters)

	-- add linter
	local linters = require("config.lsp.null-ls.linters")
	local supported_linters = linters.list_registered(buf_ft)
	vim.list_extend(buf_client_names, supported_linters)

	-- add hover
	local hovers = require("config.lsp.null-ls.hovers")
	local supported_hovers = hovers.list_registered(buf_ft)
	vim.list_extend(buf_client_names, supported_hovers)

	return "[" .. table.concat(buf_client_names, ", ") .. "]"
end

lualine.setup({
	options = {
		icons_enabled = true,
		theme = "auto",
		component_separators = { left = "", right = "" },
		section_separators = { left = " ", right = "" },

		disabled_filetypes = { "alpha", "dashboard", "NvimTree", "Outline" },
		always_divide_middle = true,
	},
	sections = {
		lualine_a = {
			components.mode,
		},
		lualine_b = {
			components.branch,
			components.filename,
		},
		lualine_c = {
			components.diff,
		},
		-- lualine_x = { "encoding", "fileformat", "filetype" },
		lualine_x = {
			components.treesitter,
			components.diagnostics,
			components.lsp,
			components.filetype,
		},
		lualine_y = {},
		lualine_z = {
			components.scrollbar,
		},
	},
	tabline = {},
	extensions = {},
})
