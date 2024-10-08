return {
  -- which-key
  {
    "folke/which-key.nvim",
    dependencies = {
      "echasnovski/mini.icons",
    },
    event = "VeryLazy",

    keys = {
      -- mode = { rn", "v" },
      {
        "<leader>/",
        ":nohls<CR>",
        desc = "Clear search",
        nowait = true,
        remap = false,
      },
      {
        "<leader>F",
        "<cmd>Telescope live_grep theme=ivy<cr>",
        desc = "Find Text",
        nowait = true,
        remap = false,
      },
      {
        "<leader>P",
        "<cmd>lua require('telescope').extensions.projects.projects()<cr>",
        desc = "Projects",
        nowait = true,
        remap = false,
      },
      {
        "<leader>b",
        "<cmd>lua require('telescope.builtin').buffers(require('telescope.themes').get_dropdown{previewer = false})<cr>",
        desc = "Buffers",
        nowait = true,
        remap = false,
      },
      { "<leader>c", "<cmd>BufDel<CR>", desc = "Close Buffer", nowait = true, remap = false },
      {
        "<leader>d",
        "<cmd>lua FindFiles()<CR>",
        desc = "Find files from working directory",
        nowait = true,
        remap = false,
      },
      { "<leader>e", group = "NeoTree", nowait = true,         remap = false },
      {
        "<leader>eb",
        "<cmd>Neotree toggle show buffers right<cr>",
        desc = "Buffers",
        nowait = true,
        remap = false,
      },
      {
        "<leader>ee",
        "<cmd>Neotree toggle current reveal_force_cwd<cr>",
        desc = "Explore",
        nowait = true,
        remap = false,
      },
      {
        "<leader>er",
        "<cmd>Neotree toggle reveal<cr>",
        desc = "Explore",
        nowait = true,
        remap = false,
      },
      {
        "<leader>es",
        "<cmd>Neotree toggle float git_status<cr>",
        desc = "Reveal",
        nowait = true,
        remap = false,
      },
      {
        "<leader>f",
        "<cmd>lua FindFilesRelative()<CR>",
        desc = "Find files relative to the current buffer",
        nowait = true,
        remap = false,
      },
      { "<leader>g",  group = "Git",                     nowait = true,            remap = false },
      {
        "<leader>gR",
        "<cmd>lua require 'gitsigns'.reset_buffer()<cr>",
        desc = "Reset Buffer",
        nowait = true,
        remap = false,
      },
      { "<leader>gb", "<cmd>Telescope git_branches<cr>", desc = "Checkout branch", nowait = true, remap = false },
      { "<leader>gc", "<cmd>Telescope git_commits<cr>",  desc = "Checkout commit", nowait = true, remap = false },
      { "<leader>gd", "<cmd>Gitsigns diffthis HEAD<cr>", desc = "Diff",            nowait = true, remap = false },
      { "<leader>gg", "<cmd>lua _LAZYGIT_TOGGLE()<CR>",  desc = "Lazygit",         nowait = true, remap = false },
      {
        "<leader>gj",
        "<cmd>lua require 'gitsigns'.next_hunk()<cr>",
        desc = "Next Hunk",
        nowait = true,
        remap = false,
      },
      {
        "<leader>gk",
        "<cmd>lua require 'gitsigns'.prev_hunk()<cr>",
        desc = "Prev Hunk",
        nowait = true,
        remap = false,
      },
      {
        "<leader>gl",
        "<cmd>lua require 'gitsigns'.blame_line()<cr>",
        desc = "Blame",
        nowait = true,
        remap = false,
      },
      { "<leader>go", "<cmd>Telescope git_status<cr>", desc = "Open changed file", nowait = true, remap = false },
      {
        "<leader>gp",
        "<cmd>lua require 'gitsigns'.preview_hunk()<cr>",
        desc = "Preview Hunk",
        nowait = true,
        remap = false,
      },
      {
        "<leader>gr",
        "<cmd>lua require 'gitsigns'.reset_hunk()<cr>",
        desc = "Reset Hunk",
        nowait = true,
        remap = false,
      },
      {
        "<leader>gs",
        "<cmd>lua require 'gitsigns'.stage_hunk()<cr>",
        desc = "Stage Hunk",
        nowait = true,
        remap = false,
      },
      {
        "<leader>gu",
        "<cmd>lua require 'gitsigns'.undo_stage_hunk()<cr>",
        desc = "Undo Stage Hunk",
        nowait = true,
        remap = false,
      },
      { "<leader>h",  group = "GitHub",                nowait = true,              remap = false },
      {
        "<leader>hI",
        "<cmd>Octo issue browser<cr>",
        desc = "Open issue in browser",
        nowait = true,
        remap = false,
      },
      { "<leader>hP", "<cmd>Octo pr browser<cr>", desc = "Open PR in browser", nowait = true, remap = false },
      { "<leader>hg", "<cmd>Octo gist list<cr>",  desc = "My open issues",     nowait = true, remap = false },
      {
        "<leader>hi",
        "<cmd>Octo search is:open is:issue assignee:zalegrala archived:false<cr>",
        desc = "My open issues",
        nowait = true,
        remap = false,
      },
      {
        "<leader>hp",
        "<cmd>Octo search is:open is:pr author:zalegrala archived:false<cr>",
        desc = "My open PRs",
        nowait = true,
        remap = false,
      },
      { "<leader>i",  group = "Insert Special Chars", nowait = true,           remap = false },
      {
        "<leader>ie",
        "<cmd>Telescope emoji<cr>",
        desc = "Insert Emoji",
        nowait = true,
        remap = false,
      },
      {
        "<leader>ig",
        "<cmd>Telescope glyph<cr>",
        desc = "Insert Glyph",
        nowait = true,
        remap = false,
      },
      { "<leader>l",  group = "LSP",                  nowait = true,           remap = false },
      { "<leader>lI", "<cmd>LspInstallInfo<cr>",      desc = "Installer Info", nowait = true, remap = false },
      {
        "<leader>lS",
        "<cmd>Telescope lsp_dynamic_workspace_symbols<cr>",
        desc = "Workspace Symbols",
        nowait = true,
        remap = false,
      },
      {
        "<leader>la",
        "<cmd>lua vim.lsp.buf.code_action()<cr>",
        desc = "Code Action",
        nowait = true,
        remap = false,
      },
      {
        "<leader>ld",
        "<cmd>Telescope lsp_document_diagnostics<cr>",
        desc = "Document Diagnostics",
        nowait = true,
        remap = false,
      },
      { "<leader>lf", "<cmd>lua vim.lsp.buf.formatting()<cr>", desc = "Format", nowait = true, remap = false },
      { "<leader>li", "<cmd>LspInfo<cr>",                      desc = "Info",   nowait = true, remap = false },
      {
        "<leader>lj",
        "<cmd>lua vim.diagnostic.goto_next()<CR>",
        desc = "Next Diagnostic",
        nowait = true,
        remap = false,
      },
      {
        "<leader>lk",
        "<cmd>lua vim.diagnostic.goto_prev()<cr>",
        desc = "Prev Diagnostic",
        nowait = true,
        remap = false,
      },
      {
        "<leader>ll",
        "<cmd>lua vim.lsp.codelens.run()<cr>",
        desc = "CodeLens Action",
        nowait = true,
        remap = false,
      },
      {
        "<leader>lq",
        "<cmd>lua vim.lsp.diagnostic.set_loclist()<cr>",
        desc = "Quickfix",
        nowait = true,
        remap = false,
      },
      {
        "<leader>lr",
        "<cmd>lua vim.lsp.buf.rename()<cr>",
        desc = "Rename",
        nowait = true,
        remap = false,
      },
      {
        "<leader>ls",
        "<cmd>Telescope lsp_document_symbols<cr>",
        desc = "Document Symbols",
        nowait = true,
        remap = false,
      },
      {
        "<leader>lw",
        "<cmd>Telescope lsp_workspace_diagnostics<cr>",
        desc = "Workspace Diagnostics",
        nowait = true,
        remap = false,
      },
      { "<leader>p", group = "Packer", nowait = true, remap = false },
      {
        "<leader>pS",
        "<cmd>PackerStatus<cr>",
        desc = "Status",
        nowait = true,
        remap = false,
      },
      {
        "<leader>pc",
        "<cmd>PackerCompile<cr>",
        desc = "Compile",
        nowait = true,
        remap = false,
      },
      {
        "<leader>pi",
        "<cmd>PackerInstall<cr>",
        desc = "Install",
        nowait = true,
        remap = false,
      },
      {
        "<leader>ps",
        "<cmd>PackerSync<cr>",
        desc = "Sync",
        nowait = true,
        remap = false,
      },
      {
        "<leader>pu",
        "<cmd>PackerUpdate<cr>",
        desc = "Update",
        nowait = true,
        remap = false,
      },
      {
        "<leader>q",
        "<cmd>q!<CR>",
        desc = "Quit",
        nowait = true,
        remap = false,
      },
      { "<leader>s", group = "Search", nowait = true, remap = false },
      {
        "<leader>sC",
        "<cmd>Telescope commands<cr>",
        desc = "Commands",
        nowait = true,
        remap = false,
      },
      {
        "<leader>sM",
        "<cmd>Telescope man_pages<cr>",
        desc = "Man Pages",
        nowait = true,
        remap = false,
      },
      {
        "<leader>sR",
        "<cmd>Telescope registers<cr>",
        desc = "Registers",
        nowait = true,
        remap = false,
      },
      {
        "<leader>sb",
        "<cmd>Telescope git_branches<cr>",
        desc = "Checkout branch",
        nowait = true,
        remap = false,
      },
      {
        "<leader>sc",
        "<cmd>Telescope colorscheme<cr>",
        desc = "Colorscheme",
        nowait = true,
        remap = false,
      },
      {
        "<leader>sh",
        "<cmd>Telescope help_tags<cr>",
        desc = "Find Help",
        nowait = true,
        remap = false,
      },
      {
        "<leader>sk",
        "<cmd>Telescope keymaps<cr>",
        desc = "Keymaps",
        nowait = true,
        remap = false,
      },
      {
        "<leader>so",
        "<cmd>TodoTelescope<cr>",
        desc = "Commands",
        nowait = true,
        remap = false,
      },
      {
        "<leader>sr",
        "<cmd>Telescope oldfiles<cr>",
        desc = "Open Recent File",
        nowait = true,
        remap = false,
      },
      {
        "<leader>w",
        "<cmd>w!<CR>",
        desc = "Save",
        nowait = true,
        remap = false,
      },
      { "<leader>x",  group = "PDE",   nowait = true, remap = false },
      {
        "<leader>xO",
        "<cmd>Outline<cr>",
        desc = "Outline",
        nowait = true,
        remap = false,
      },
      {
        "<leader>xb",
        "<cmd>Telescope git_branches<cr>",
        desc = "Checkout branch",
        nowait = true,
        remap = false,
      },
      {
        "<leader>xc",
        "<cmd>exec &bg=='light'? 'set bg=dark' : 'set bg=light'<cr>",
        desc = "Trouble",
        nowait = true,
        remap = false,
      },
      { "<leader>xd", group = "Debug", nowait = true, remap = false },
      {
        "<leader>xdB",
        "<cmd>lua require('dap').set_breakpoint(vim.fn.input('Berakpoint condition: '))<CR>",
        desc = "Breakpoint with condition",
        nowait = true,
        remap = false,
      },
      {
        "<leader>xdb",
        "<cmd>lua require('dap').toggle_breakpoint()<CR>",
        desc = "Toggle Breakpoint",
        nowait = true,
        remap = false,
      },
      {
        "<leader>xdc",
        "<cmd>lua require('dap').continue()<CR>",
        desc = "Continue",
        nowait = true,
        remap = false,
      },
      {
        "<leader>xdd",
        "<cmd>lua require('dap').step_into()<CR>",
        desc = "Step into",
        nowait = true,
        remap = false,
      },
      {
        "<leader>xdn",
        "<cmd>lua require('dap').step_over()<CR>",
        desc = "Step over",
        nowait = true,
        remap = false,
      },
      {
        "<leader>xdo",
        "<cmd>lua require('dap').step_out()<CR>",
        desc = "Step out",
        nowait = true,
        remap = false,
      },
      {
        "<leader>xdr",
        "<cmd>lua require('dap').repl_open()<CR>",
        desc = "Repl",
        nowait = true,
        remap = false,
      },
      {
        "<leader>xdt",
        "<cmd>lua require('dap-go').debug_test()<CR>",
        desc = "Test",
        nowait = true,
        remap = false,
      },
      {
        "<leader>xdu",
        "<cmd>lua require('dapui').open()<CR>",
        desc = "UI",
        nowait = true,
        remap = false,
      },
      {
        "<leader>xo",
        "<cmd>TodoTrouble<cr>",
        desc = "Todo",
        nowait = true,
        remap = false,
      },
      {
        "<leader>xr",
        "<cmd>TroubleToggle<cr>",
        desc = "Trouble",
        nowait = true,
        remap = false,
      },
      {
        "<leader>xt",
        "<cmd>Twilight<cr>",
        desc = "Twilight",
        nowait = true,
        remap = false,
      },
    },
  },
}
