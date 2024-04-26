return {
  -- go
  {
    "ray-x/go.nvim",
    dependencies = { -- optional packages
      "ray-x/guihua.lua",
      "neovim/nvim-lspconfig",
      "nvim-treesitter/nvim-treesitter",
    },
    -- https://github.com/ray-x/go.nvim/tree/master?tab=readme-ov-file#configuration
    config = function()
      require("go").setup({
        goimports = 'goimports', -- goimports command, can be gopls[default] or either goimports or golines if need to split long lines
        gofmt = 'gofumpt',       -- gofmt through gopls: alternative is gofumpt, goimports, golines, gofmt, etc

        --[[ max_line_len = 120, ]]
        tag_transform = false,
        test_dir = "",
        comment_placeholder = "   ",
        lsp_cfg = true,       -- false: use your own lspconfig
        lsp_gofumpt = true,   -- true: set default gofmt in gopls format to gofumpt
        lsp_on_attach = true, -- use on_attach from go.nvim
        dap_debug = true,
      })
    end,
    event = { "CmdlineEnter" },
    ft = { "go", "gomod" },
    build = ':lua require("go.install").update_all_sync()', -- if you need to install/update all binaries
  },
}
