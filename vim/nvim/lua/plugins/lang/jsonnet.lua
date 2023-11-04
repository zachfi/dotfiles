return {
  -- Syntax
  --[[ "google/vim-jsonnet", ]]
  {
    "Duologic/nvim-jsonnet",
    config = function()
      require("nvim-jsonnet").setup({
        jsonnet_bin = "tk",
        jsonnet_args = { "eval" },
        use_tanka_if_possible = true,
      })
    end,
  },
}
