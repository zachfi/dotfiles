return {
  {
    -- Replaces ap/vim-css-color (unmaintained since Oct 2024). That plugin
    -- hooked a per-buffer CursorMoved autocmd to an unguarded s:parse_screen()
    -- reading b:css_color_pat; in review/diff/preview buffers whose syntax is
    -- swapped in place, the autocmd fired before init set that var, throwing
    -- E121 (undefined b:css_color_pat) then E116 (bad substitute() args).
    -- nvim-highlight-colors is Lua, maintained, and handles those buffers.
    "brenoprata10/nvim-highlight-colors",
    config = function()
      require("nvim-highlight-colors").setup({
        render = "virtual",
        virtual_symbol = "█", -- full block: max area to read the color reliably
      })
    end,
  },
  "jjo/vim-cue",
  "mustache/vim-mustache-handlebars",
  "towolf/vim-helm",
  {
    "iamcco/markdown-preview.nvim",
    build = function()
      vim.fn["mkdp#util#install"]()
    end,
  },
  "grafana/vim-alloy",
}
