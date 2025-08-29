return {

  -- snippets

  -- {
  --   "L3MON4D3/LuaSnip",
  --   -- follow latest release.
  --   version = "v2.*", -- Replace <CurrentMajor> by the latest released major (first number of latest release)
  --   -- install jsregexp (optional!).
  --   build = "make install_jsregexp",
  -- },

  -- cmp plugins
  {
    "hrsh7th/nvim-cmp",
    version = false, -- last release is way too old
    event = "InsertEnter",
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
      -- "saadparwaiz1/cmp_luasnip",
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-nvim-lua",
      "hrsh7th/cmp-nvim-lsp-signature-help",
      "petertriho/cmp-git",
    },
    opts = function()
      local cmp = require("cmp")
      return {
        completion = {
          completeopt = "menu,menuone,noinsert",
        },
        -- snippet = {
        --   expand = function(args)
        --     require("luasnip").lsp_expand(args.body)
        --   end,
        -- },
        mapping = cmp.mapping.preset.insert({
          ["<C-n>"] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Select }), -- Or Insert instead of Select
          ["<C-p>"] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Select }),
          ["<C-b>"] = cmp.mapping.scroll_docs(-3),
          ["<C-f>"] = cmp.mapping.scroll_docs(3),
          ["<C-Space>"] = cmp.mapping.complete(),
          ["<C-e>"] = cmp.mapping.abort(),
          ["<CR>"] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
          ["<S-CR>"] = cmp.mapping.confirm({
            behavior = cmp.ConfirmBehavior.Replace,
            select = true,
          }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
        }),
        sources = cmp.config.sources({
          { name = "copilot" },
          { name = "nvim_lsp" },
        }, {
          { name = "buffer",                 keyword_length = 4 },
          { name = "nvim_lua" },
          -- { name = "luasnip" },
          { name = "path" },
          { name = "git" },
          { name = "nvim_lsp_signature_help" },
        }),
        window = {
          completion = cmp.config.window.bordered(),
          documentation = cmp.config.window.bordered(),
        },
        formatting = {
          format = function(entry, item)
            local icons = require("config.icons").kinds
            if icons[item.kind] then
              item.kind = icons[item.kind] .. item.kind
            end
            item.menu = ({
              copilot = "[Copilot]",
              nvim_lsp = "[LSP]",
              nvim_lua = "[NvimLua]",
              -- luasnip = "[Snippet]",
              buffer = "[Buffer]",
              path = "[Path]",
              git = "[Git]",
              nvim_lsp_signature_help = "[LSP Signature]",
            })[entry.source.name]
            return item
          end,
        },
        experimental = {
          --[[ ghost_text = { ]]
          --[[ 	hl_group = "LspCodeLens", ]]
          --[[ }, ]]
          native_menu = false,
          ghost_text = true,
        },

        sorting = {
          comparators = {
            cmp.config.compare.offset,
            cmp.config.compare.exact,
            cmp.config.compare.score,
            cmp.config.compare.recently_used,
            cmp.config.compare.locality,
            cmp.config.compare.kind,
            cmp.config.compare.sort_text,
            cmp.config.compare.length,
            cmp.config.compare.order,
          },
        },
      }
    end,
  },

  -- auto pairs
  {
    "windwp/nvim-autopairs", -- Autopairs, integrates with both cmp and treesitter
    opts = {
      check_ts = true,
      ts_config = {
        lua = { "string", "source" },
        javascript = { "string", "template_string" },
        java = false,
      },
      disable_filetype = { "TelescopePrompt", "spectre_panel" },
      fast_wrap = {
        map = "<M-e>",
        chars = { "{", "[", "(", '"', "'" },
        pattern = string.gsub([[ [%'%"%)%>%]%)%}%,] ]], "%s+", ""),
        offset = 0, -- Offset from pattern match
        end_key = "$",
        keys = "qwertyuiopzxcvbnmasdfghjkl",
        check_comma = true,
        highlight = "PmenuSel",
        highlight_grey = "LineNr",
      },
    },
  },

  -- comments
  {
    "numToStr/Comment.nvim", -- Easily comment stuff
    opts = {},
  },
  {
    "hedyhli/outline.nvim",
    config = function()
      local icons = {
        Function = "󰊕",
        Method = "󰡱",
      }

      require("outline").setup({
        symbols = {
          icon_fetcher = function(k)
            return icons[k] or false
          end,

          -- icons = {
          --   File = { icon = "󰈔", hl = "Identifier" },
          --   Module = { icon = "󰆧", hl = "Include" },
          --   Namespace = { icon = "󰅪", hl = "Include" },
          --   Package = { icon = "󰏗", hl = "Include" },
          --   Class = { icon = "𝓒", hl = "Type" },
          --   Method = { icon = "ƒ", hl = "Function" }, -- another one
          --   Property = { icon = "", hl = "Identifier" },
          --   Field = { icon = "󰆨", hl = "Identifier" },
          --   Constructor = { icon = "", hl = "Special" },
          --   Enum = { icon = "ℰ", hl = "Type" },
          --   Interface = { icon = "󰜰", hl = "Type" },
          --   Function = { icon = "", hl = "Function" }, -- the only override from default
          --   Variable = { icon = "", hl = "Constant" },
          --   Constant = { icon = "", hl = "Constant" },
          --   String = { icon = "𝓐", hl = "String" },
          --   Number = { icon = "#", hl = "Number" },
          --   Boolean = { icon = "⊨", hl = "Boolean" },
          --   Array = { icon = "󰅪", hl = "Constant" },
          --   Object = { icon = "⦿", hl = "Type" },
          --   Key = { icon = "🔐", hl = "Type" },
          --   Null = { icon = "NULL", hl = "Type" },
          --   EnumMember = { icon = "", hl = "Identifier" },
          --   Struct = { icon = "𝓢", hl = "Structure" },
          --   Event = { icon = "🗲", hl = "Type" },
          --   Operator = { icon = "+", hl = "Identifier" },
          --   TypeParameter = { icon = "𝙏", hl = "Identifier" },
          --   Component = { icon = "󰅴", hl = "Function" },
          --   Fragment = { icon = "󰅴", hl = "Constant" },
          --   TypeAlias = { icon = " ", hl = "Type" },
          --   Parameter = { icon = " ", hl = "Identifier" },
          --   StaticMethod = { icon = " ", hl = "Function" },
          --   Macro = { icon = " ", hl = "Function" },
          -- },
        },
      })
    end,
  },

  -- nvim-lint to run a linter on save
  {
    "mfussenegger/nvim-lint",
    config = function(_, _)
      require("lint").linters_by_ft = {
        proto = { "buf_lint" },
        python = { "flake8" },
        go = { "golangcilint", "codespell" },
        sh = { "shellcheck" },
        markdown = { "vale" },
      }
    end,
  },

  -- conform to format files on save
  {
    "stevearc/conform.nvim",
    -- optional = true,
    opts = {
      formatters_by_ft = {
        sh = { "shfmt" },
        yaml = { "yamlfmt" },
        lua = { "stylua" },
        markdown = { "prettier" },
      },

      format_on_save = {
        -- These options will be passed to conform.format()
        timeout_ms = 700,
        lsp_fallback = true,
      },
    },
  },
  { "sindrets/diffview.nvim" },
}
