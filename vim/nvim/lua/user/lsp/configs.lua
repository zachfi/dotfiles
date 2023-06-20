local status_ok, mason = pcall(require, "mason")
if not status_ok then
	return
end

local status_ok_mason_lspconfig, mason_lspconfig = pcall(require, "mason-lspconfig")
if not status_ok_mason_lspconfig then
	return
end

local status_ok_lspconfig, lspconfig = pcall(require, "lspconfig")
if not status_ok_lspconfig then
	return
end

local servers = {
	"arduino_language_server",
	"bashls",
	"bufls",
	"dagger",
	"dockerls",
	"golangci_lint_ls",
	"gopls",
	"helm_ls",
	"html",
	"jsonls",
	"jsonnet_ls",
	"ltex",
	"lua_ls",
	"marksman",
	"neocmake",
	"terraformls",
	"tflint",
	"yamlls",
	"zk"
}

mason.setup({
	ui = {
		icons = {
			package_installed = "✓",
		},
	},
})

mason_lspconfig.setup({
	ensure_installed = servers,
	automatic_installation = true,
})

for _, server in pairs(servers) do
	local opts = {
		on_attach = require("user.lsp.handlers").on_attach,
		capabilities = require("user.lsp.handlers").capabilities,
	}
	local has_custom_opts, server_custom_opts = pcall(require, "user.lsp.settings." .. server)
	if has_custom_opts then
		opts = vim.tbl_deep_extend("force", server_custom_opts, opts)
	end
	lspconfig[server].setup(opts)
end
