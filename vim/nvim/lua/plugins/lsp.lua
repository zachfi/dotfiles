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
    config = function()
      -- This is where all the LSP shenanigans will live

      local lsp = require("lsp-zero")
      local format = require("plugins.lsp.format")
      local keymaps = require("plugins.lsp.keymaps")
      -- local illuminate = require("illuminate")
      local lspconfig = require("lspconfig")

      lsp.on_attach(function(client, bufnr)
        lsp.default_keymaps({ buffer = bufnr })
        format.on_attach(client, bufnr)
        keymaps.lsp_keymaps(bufnr)
        -- illuminate.on_attach(client)
      end)

      -- (Optional) Configure lua language server for neovim
      lspconfig.lua_ls.setup(lsp.nvim_lua_ls())

      lspconfig.jsonnet_ls.setup({
        capabilities = vim.lsp.protocol.make_client_capabilities(),
        flags = {
          debounce_text_changes = 150,
        },
        --[[ cmd = { "jsonnet-language-server", "--lint" }, -- Linting can be noisy ]]
        cmd = { "jsonnet-language-server" }, -- Linting can be noisy
        settings = {
          formatting = {
            UseImplicitPlus = true, -- Recommended but might conflict with project-level jsonnetfmt settings
          },
        },
      })

      require("mason-lspconfig").setup({
        -- handlers = {
        --   --- this first function is the "default handler"
        --   --- it applies to every language server without a "custom handler"
        --   function(server_name)
        --     require("lspconfig")[server_name].setup({})
        --   end,
        --
        --   --- this is the "custom handler" for `example_server`
        --   --- in your own config you should replace `example_server`
        --   --- with the name of a language server you have installed
        --   gopls = function()
        --     --- in this function you can setup
        --     --- the language server however you want.
        --     --- in this example we just use lspconfig
        --     lspconfig.gopls.setup(require("user.lsp.settings.gopls"))
        --   end,
        -- },
      })

      -- lspconfig.gopls.setup(require("user.lsp.settings.gopls"))
      -- lspconfig.gopls.setup(require("go.lsp").config())

      --[[ lspconfig.clangd.setup({ ]]
      --[[ 	capabilities = vim.lsp.protocol.make_client_capabilities(), ]]
      --[[ 	cmd = { "clangd", "--offset-encoding=utf-16" }, ]]
      --[[ }) ]]

      local custom_server_settings = {
        "gopls",
      }

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
