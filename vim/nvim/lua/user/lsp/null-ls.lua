local null_ls_status_ok, null_ls = pcall(require, "null-ls")
if not null_ls_status_ok then
	return
end

local formatting = null_ls.builtins.formatting
-- https://github.com/jose-elias-alvarez/null-ls.nvim/tree/main/lua/null-ls/builtins/formatting
-- https://github.com/jose-elias-alvarez/null-ls.nvim/tree/main/lua/null-ls/builtins/diagnostics
local diagnostics = null_ls.builtins.diagnostics
-- https://github.com/jose-elias-alvarez/null-ls.nvim/tree/main/lua/null-ls/builtins/completion
local completion = null_ls.builtins.completion

null_ls.setup({
	debug = false,
	sources = {
		completion.spell,
		diagnostics.flake8,
		diagnostics.gitlint,
		diagnostics.golangci_lint,
		diagnostics.markdownlint,
		diagnostics.shellcheck,
		diagnostics.zsh,
		formatting.black.with({ extra_args = { "--fast" } }),
		formatting.goimports,
		formatting.prettier.with({ extra_args = { "--no-semi", "--single-quote", "--jsx-single-quote" } }),
		formatting.stylua,
		formatting.terraform_fmt,

		-- code_actions
		null_ls.builtins.code_actions.gitsigns,
		null_ls.builtins.code_actions.gitrebase,

		-- hovers
		null_ls.builtins.hover.dictionary,
	},
})
