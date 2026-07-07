-- Completion: blink.cmp
--
-- Keymap cheat-sheet (insert mode, while the menu is relevant):
--   <C-y>      accept the selected item          (nvim-cmp muscle memory)
--   <C-n>      select next item / open menu
--   <C-p>      select previous item
--   <Tab>      accept snippet if active, else accept selected item; jumps snippet stops
--   <CR>       accept
--   <C-space>  open menu / toggle documentation popup
--   <C-k>      toggle signature help
--   <C-e>      hide the menu
--
-- Source priority lives in `sources.providers.<name>.score_offset` below, NOT
-- in the order of `sources.default`. In blink every enabled source is queried
-- and ranked together as one pool; score_offset biases a source up/down. This
-- is the equivalent of nvim-cmp's source order + comparators.

return {

  {
    "saghen/blink.cmp",
    dependencies = {
      "L3MON4D3/LuaSnip",
    },

    -- use a release tag to download pre-built binaries
    version = "1.*",
    -- AND/OR build from source, requires nightly: https://rust-lang.github.io/rustup/concepts/channels.html#working-with-nightly-rust
    -- build = 'cargo build --release',

    ---@module 'blink.cmp'
    ---@type blink.cmp.Config
    opts = {
      -- Custom keymap (preset = "none" means nothing is bound unless listed here).
      -- See :h blink-cmp-config-keymap. Cheat-sheet is at the top of this file.
      keymap = {
        preset = "none",
        ["<C-y>"] = { "select_and_accept", "fallback" },
        ["<C-n>"] = { "select_next", "fallback" },
        ["<C-p>"] = { "select_prev", "fallback" },
        ["<Tab>"] = {
          function(cmp)
            if cmp.snippet_active() then
              return cmp.accept()
            else
              return cmp.select_and_accept()
            end
          end,
          "snippet_forward",
          "fallback",
        },
        ["<C-space>"] = { "show", "show_documentation", "hide_documentation" },
        ["<C-k>"] = { "show_signature", "hide_signature", "fallback" },
        ["<C-e>"] = { "hide", "fallback" },
        ["<CR>"] = { "accept", "fallback" },
      },

      appearance = {
        -- 'mono' (default) for 'Nerd Font Mono' or 'normal' for 'Nerd Font'
        -- Adjusts spacing to ensure icons are aligned
        nerd_font_variant = "mono",
      },

      signature = { enabled = true },

      cmdline = { enabled = false },

      snippets = { preset = "luasnip" },

      -- Menu feel — flip any of these to taste as muscle memory develops:
      list = {
        selection = {
          preselect = true,   -- highlight the first item so <CR>/<C-y> accepts it immediately
          auto_insert = true, -- as you <C-n>/<C-p>, preview that item's text in the buffer
        },
      },

      sources = {
        -- Enabled sources (order here does NOT set priority — see score_offset).
        default = {
          "lsp",
          "path",
          "snippets",
          "buffer",
        },

        -- Priority per source. Higher score_offset floats a source's items up.
        -- This is where you'd have used source order / comparators in nvim-cmp.
        providers = {
          lsp = { score_offset = 100 },     -- LSP results win
          snippets = { score_offset = 80 },
          path = { score_offset = 60 },
          buffer = {
            score_offset = 20,              -- buffer words rank lowest
            min_keyword_length = 4,         -- ...and only after 4 chars (nvim-cmp keyword_length)
          },
        },
      },

      completion = {
        keyword = {
          range = "prefix", -- match the word before the cursor ("full" = whole word)
        },

        ghost_text = {
          enabled = true, -- inline grey preview of the top item; set false if distracting
        },

        documentation = {
          auto_show = true,
          auto_show_delay = 500,
        },

        trigger = {
          prefetch_on_insert = true,
          show_on_insert = false,
          show_on_backspace = true,
          show_on_backspace_in_keyword = true,
          show_on_trigger_character = true,
          -- show_on_blocked_trigger_characters = { " ", "\n", "\t" },
          show_on_blocked_trigger_characters = function(ctx)
            if vim.bo.filetype == "markdown" then
              return { " ", "\n", "\t", ".", "/", "(", "[" }
            end
            return { " ", "\n", "\t" }
          end,
        },

        menu = {

          draw = {
            treesitter = { "lsp" },

            columns = {
              { "kind_icon" },
              { "label",      "label_description", gap = 1 },
              { "source_name" },
            },
            padding = { 0, 1 }, -- padding only on right side
            components = {
              kind_icon = {
                text = function(ctx)
                  return " " .. ctx.kind_icon .. ctx.icon_gap .. " "
                end,
              },
              source_name = {
                width = { max = 30 },
                text = function(ctx)
                  return "[" .. ctx.source_name .. "]"
                end,
                highlight = "BlinkCmpSource",
              },
            },
          },
        },
      },

      -- (Default) Rust fuzzy matcher for typo resistance and significantly better performance.
      -- Use implementation = "lua" or "prefer_rust" if the prebuilt binary is unavailable.
      -- fuzzy = { implementation = "lua" },
    },
    opts_extend = { "sources.default" },
  },
}
