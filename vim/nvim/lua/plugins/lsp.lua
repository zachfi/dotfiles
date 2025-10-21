return {
	{
		"VonHeikemen/lsp-zero.nvim",
		branch = "v3.x",
		lazy = true,
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
				"black",
				"buf",
				-- "buf-language-server", -- dead
				-- "clangd",
				-- "clang-format",
				"cbfmt",
				"cueimports",
				"cuelsp",
				"codespell",
				"delve",
				"dockerfile-language-server",
				"flake8",
				"gofumpt",
				"goimports",
				"golangci-lint",
				--[[ "golangci-lint-langserver", ]]
				"gomodifytags",
				"gopls",
				"gospel",
				"gotestsum",
				"helm-ls",
				"jsonlint",
				"json-lsp",
				"harper-ls",
				"jsonnet-language-server",
				"lua-language-server",
				"markdownlint",
				"markdown-toc",
				"marksman",
				"misspell",
				"nginx-language-server",
				"prettier",
				"prettierd",
				"python-lsp-server",
				-- "semgrep",
				"shellcheck",
				"shfmt",
				"stylua",
				"stylua",
				"terraform-ls",
				"tflint",
				"vale",
				"yamlfmt",
				"yaml-language-server",
				-- "zk",
			},
		},

		-- @param opts MasonSettings | {ensure_installed: string[]}
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

	{
		"neovim/nvim-lspconfig",
		cmd = "LspInfo",
		event = { "BufReadPre", "BufNewFile" },
		dependencies = {
			{ "hrsh7th/cmp-nvim-lsp" },
			{ "williamboman/mason-lspconfig.nvim" },
			{ "williamboman/mason.nvim" },
			{ "VonHeikemen/lsp-zero.nvim" },
		},

		opts = {
			servers = {
				vale_ls = {},
				harper_ls = {
					settings = {
						["harper-ls"] = {
							linters = {
								SpellCheck = false, -- Spelling done by codespell, which is better at it.
								SentenceCapitalization = false, -- There are abundant reasons to start with lowercase, specially in go.
							},
						},
					},
				},
			},
		},

		config = function()
			-- This is where all the LSP shenanigans will live

			vim.lsp.enable({
				"jsonnet_ls",
				"marskman",
				"lua_ls",
			})

			local custom_server_settings = {
				"gopls",
			}

			vim.lsp.config("*", {
				on_attach = function(client)
					client.server_capabilities.semanticTokensProvider = nil
				end,
			})

			for _, server in pairs(custom_server_settings) do
				local opts = {}
				local has_custom_opts, server_custom_opts = pcall(require, "user.lsp.settings." .. server)
				if has_custom_opts then
					opts = vim.tbl_deep_extend("force", server_custom_opts, opts)
				end
				vim.lsp.config(server, opts)
				vim.lsp.enable(server)
			end

			vim.api.nvim_create_autocmd("LspAttach", {
				group = vim.api.nvim_create_augroup("my.lsp", {}),
				callback = function(args)
					local client = assert(vim.lsp.get_client_by_id(args.data.client_id))
					if client:supports_method("textDocument/implementation") then
						-- Create a keymap for vim.lsp.buf.implementation ...
					end
					-- Enable auto-completion. Note: Use CTRL-Y to select an item. |complete_CTRL-Y|
					if client:supports_method("textDocument/completion") then
						-- Optional: trigger autocompletion on EVERY keypress. May be slow!
						-- local chars = {}; for i = 32, 126 do table.insert(chars, string.char(i)) end
						-- client.server_capabilities.completionProvider.triggerCharacters = chars
						vim.lsp.completion.enable(true, client.id, args.buf, { autotrigger = true })
					end
					-- Auto-format ("lint") on save.
					-- Usually not needed if server supports "textDocument/willSaveWaitUntil".
					if
						not client:supports_method("textDocument/willSaveWaitUntil")
						and client:supports_method("textDocument/formatting")
					then
						vim.api.nvim_create_autocmd("BufWritePre", {
							group = vim.api.nvim_create_augroup("my.lsp", { clear = false }),
							buffer = args.buf,

							callback = function()
								if client.name == "gopls" then
									local go = require("go.format")

									go.gofmt()
									go.goimports()
								else
									vim.lsp.buf.format({ bufnr = args.buf, id = client.id, timeout_ms = 1000 })
								end
							end,
						})
					end
				end,
			})
		end,
	},
}
