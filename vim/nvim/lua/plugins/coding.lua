return {

  -- snippets

  -- {
  --   "L3MON4D3/LuaSnip",
  --   -- follow latest release.
  --   version = "v2.*", -- Replace <CurrentMajor> by the latest released major (first number of latest release)
  --   -- install jsregexp (optional!).
  --   build = "make install_jsregexp",
  -- },

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
