return {
{
  "jose-elias-alvarez/null-ls.nvim",
  event = { "BufReadPre", "BufNewFile" },
  dependencies = { "mason.nvim" },
  opts = function()
    local null_ls = require("null-ls")
    -- https://github.com/jose-elias-alvarez/null-ls.nvim/tree/main/lua/null-ls/builtins/formatting
    local formatting = null_ls.builtins.formatting
    -- https://github.com/jose-elias-alvarez/null-ls.nvim/tree/main/lua/null-ls/builtins/diagnostics
    local diagnostics = null_ls.builtins.diagnostics
    -- https://github.com/jose-elias-alvarez/null-ls.nvim/tree/main/lua/null-ls/builtins/completion
    local completion = null_ls.builtins.completion
    return {
      root_dir = require("null-ls.utils").root_pattern(".null-ls-root", ".neoconf.json", "Makefile", ".git"),
      sources = {

		completion.spell,
		diagnostics.buf,
		diagnostics.flake8,
		diagnostics.golangci_lint,
		diagnostics.protoc_gen_lint,
		diagnostics.protolint,
		diagnostics.shellcheck,
		diagnostics.zsh,
		formatting.black.with({ extra_args = { "--fast" } }),
		formatting.buf,
		formatting.goimports,
		formatting.gofumpt,
		formatting.prettier.with({ extra_args = { "--no-semi", "--single-quote", "--jsx-single-quote" } }),
		formatting.stylua,
		formatting.shfmt,
		formatting.terraform_fmt,

		-- code_actions
		null_ls.builtins.code_actions.gitsigns,
		null_ls.builtins.code_actions.gitrebase,

		-- hovers
		null_ls.builtins.hover.dictionary,

      },
    }
  end,
},


	{ "williamboman/mason-lspconfig.nvim" },
	{

		"williamboman/mason.nvim",
		cmd = "Mason",
		-- keys = { { "<leader>cm", "<cmd>Mason<cr>", desc = "Mason" } },
		opts = {
      ui = {
        icons = {
          package_installed = "✓",
        },
      },
			ensure_installed = {
        "arduino-language-server",
        "bash-language-server",
        "buf",
        "buf-language-server",
				"clangd",
				"clang-format",
        "cueimports",
        "cuelsp",
        "dockerfile-language-server",
        "gofumpt",
        "goimports",
        "golangci-lint-langserver",
        "gomodifytags",
        "gopls",
        "gospel",
        "gotestsum",
       	"helm-ls",
        "jsonlint",
        "json-lsp",
        "jsonnet-language-server",
      	"ltex-ls",
      	"luaformatter",
      	"lua-language-server",
      	"markdownlint",
      	"markdown-toc",
      	"marksman",
      	"misspell",
      	"nginx-language-server",
      	"prettierd",
				"shfmt",
				"stylua",
      	"terraform-ls",
       	"tflint",
      	"yamlfmt",
        "yaml-language-server",
        "zk",
			},
		},

		---@param opts MasonSettings | {ensure_installed: string[]}
		config = function(_, opts)
			require("mason").setup(opts)
			local mr = require("mason-registry")
			local function ensure_installed()
				for _, tool in ipairs(opts.ensure_installed) do
					local p = mr.get_package(tool)
					if not p:is_installed() then
						p:install()
					end
				end
			end
			if mr.refresh then
				mr.refresh(ensure_installed)
			else
				ensure_installed()
			end
		end,
	},
}
