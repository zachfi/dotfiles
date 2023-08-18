return {
  {
    "VonHeikemen/lsp-zero.nvim",
    branch = "v2.x",
    lazy = true,
    config = function()
      require("lsp-zero.settings").preset({})
    end,
  },

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
          --[[ diagnostics.golangci_lint, ]]
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
        "black",
        "buf",
        "buf-language-server",
        "clangd",
        "clang-format",
        "cueimports",
        "cuelsp",
        "dockerfile-language-server",
        "flake8",
        "gofumpt",
        "goimports",
        "gomodifytags",
        "gopls",
        "gospel",
        "gotestsum",
        "golangci-lint",
        "golangci-lint-langserver",
        "helm-ls",
        "jsonlint",
        "json-lsp",
        "jsonnet-language-server",
        "lua-language-server",
        "markdownlint",
        "markdown-toc",
        "marksman",
        "misspell",
        "stylua",
        "nginx-language-server",
        "prettier",
        "prettierd",
        "python-lsp-server",
        "shfmt",
        "stylua",
        "terraform-ls",
        "tflint",
        "yamlfmt",
        "yaml-language-server",
        --[[ "zk", ]]
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

  {
    "neovim/nvim-lspconfig",
    cmd = "LspInfo",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
      { "hrsh7th/cmp-nvim-lsp" },
      { "williamboman/mason-lspconfig.nvim" },
      {
        "williamboman/mason.nvim",
        build = function()
          pcall(vim.cmd, "MasonUpdate")
        end,
      },
    },
    config = function()
      -- This is where all the LSP shenanigans will live

      local lsp = require("lsp-zero")
      local format = require("plugins.lsp.format")
      local keymaps = require("plugins.lsp.keymaps")
      local illuminate = require("illuminate")

      lsp.on_attach(function(client, bufnr)
        lsp.default_keymaps({ buffer = bufnr })
        format.on_attach(client, bufnr)
        keymaps.lsp_keymaps(bufnr)
        illuminate.on_attach(client)
      end)

      -- (Optional) Configure lua language server for neovim
      require("lspconfig").lua_ls.setup(lsp.nvim_lua_ls())

      require("lspconfig").jsonnet_ls.setup({
        capabilities = vim.lsp.protocol.make_client_capabilities(),
        flags = {
          debounce_text_changes = 150,
        },
        cmd = { "jsonnet-language-server", "--lint" }, -- Linting can be noisy
        settings = {
          formatting = {
            UseImplicitPlus = true, -- Recommended but might conflict with project-level jsonnetfmt settings
          },
        },
      })

      local custom_server_settings = { "gopls" }

      for _, server in pairs(custom_server_settings) do
        local opts = {
          --[[ on_attach = require("user.lsp.handlers").on_attach, ]]
          --[[ capabilities = require("user.lsp.handlers").capabilities, ]]
        }
        local has_custom_opts, server_custom_opts = pcall(require, "user.lsp.settings." .. server)
        if has_custom_opts then
          opts = vim.tbl_deep_extend("force", server_custom_opts, opts)
        end
        lsp.configure(server, opts)
      end

      lsp.setup()
    end,
  },
}
