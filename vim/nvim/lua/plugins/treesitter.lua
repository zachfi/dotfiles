return {
  -- Treesitter
  -- NOTE: uses the `main` branch. The old `master` branch is frozen and does
  -- NOT support Neovim 0.12+ (it crashes on markdown injection parsing, e.g.
  -- the Shift+K godoc hover float). `main` requires Neovim 0.12.0+.
  {
    "nvim-treesitter/nvim-treesitter",
    branch = "main",
    lazy = false, -- the main branch does not support lazy-loading
    build = ":TSUpdate",
    config = function()
      -- Parsers to keep installed. On the main branch there is no
      -- `ensure_installed` option; install explicitly instead.
      local ensure_installed = {
        "bash",
        "c",
        "go",
        "gomod",
        "hcl",
        "json",
        "jsonnet",
        "latex",
        "lua",
        "make",
        "markdown",
        "markdown_inline", -- required for markdown code-fence highlighting (godoc float)
        "python",
        "ssh_config",
        "vim",
        "yaml",
      }
      require("nvim-treesitter").install(ensure_installed)

      -- Highlighting is no longer a module; enable it per-buffer. pcall guards
      -- filetypes that have no installed parser.
      vim.api.nvim_create_autocmd("FileType", {
        callback = function(args)
          pcall(vim.treesitter.start, args.buf)
        end,
      })
    end,
  },
}
