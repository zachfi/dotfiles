return {
  "ap/vim-css-color",
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
