return {
  -- which-key
  {
    "folke/which-key.nvim",
    dependencies = {
      "echasnovski/mini.icons",
    },
    event = "VeryLazy",

    opts = {
      preset = "helix",
      icons = {
        separator = " │ ",
        group = " ",

        ["<leader>e"] = { name = " neotree" },

        -- builtin = {
        --   ["?"] = "󰊽", -- question mark
        --   ["!"] = "󰊾", -- exclamation mark
        --   ["$"] = "󰊿", -- dollar sign
        --   ["#"] = "󰋀", -- hash sign
        --   ["%"] = "󰋁", -- percent sign
        --   ["&"] = "󰋂", -- ampersand
        --   ["*"] = "󰋃", -- asterisk
        -- },
      },
      spec = {
        { "<leader>d", icon = { icon = "", hl = "WhichKeyIconBlue" } },
        { "<leader>e", icon = { icon = "", hl = "WhichKeyIconGreen" }, group = "NeoTree" },
        { "<leader>f", icon = { icon = "", hl = "WhichKeyIconBlue" } },
        { "<leader>g", icon = { icon = "󰘭", hl = "WhichKeyIconOrange" }, group = "Code" },
        { "<leader>l", icon = { icon = "", hl = "WhichKeyIconGreen" }, group = "LSP" },
        { "<leader>x", icon = { icon = "", hl = "WhichKeyIconYellow" }, group = "PDE" },
      },

      -- defaults = {
      --   -- NOTE: this is the old spec, but I might want to use some of these later
      --   -- ["z"] = { name = "+fold" },
      --   -- ["]"] = { name = "+next" },
      --   -- ["["] = { name = "+prev" },
      --   -- ["<leader>b"] = { name = " buffers" },
      --   -- ["<leader>c"] = { name = " code" },
      --   -- ["<leader>f"] = { name = " file/find" },
      --   -- ["<leader>g"] = { name = "󰘭 git" },
      --   -- ["<leader>i"] = { name = "󰛢 Grapple" },
      --   -- ["<leader>j"] = { name = " Flash" },
      --   -- ["<leader>m"] = { name = "󱃲 Visual Multi" },
      --   -- ["<leader>n"] = { name = " Neorg" },
      --   -- ["<leader>p"] = { name = " Packages" },
      --   -- ["<leader>s"] = { name = "󰦅 Search" },
      --   -- ["<leader>u"] = { name = "󰨇 Ui/Ux" },
      --   -- ["<leader>w"] = { name = " Windows" },
      --   -- ["<leader>x"] = { name = "󱁤 Diagnostics/Quickfix" },
      --   -- ["<leader>t"] = { name = " Terminal" },
      --   -- ["<leader>k"] = { name = "󰺿 Telekasten" },
      --   -- ["<leader>z"] = { name = "󰩈 Quit" },
      -- },
    },
    -- config = function(_, opts)
    --   local wk = require("which-key")
    --   wk.setup(opts)
    --   wk.register(opts.defaults)
    -- end,

    keys = {
      -- mode = { rn", "v" },
      { "<leader>/", ":nohls<CR>",      desc = "Clear search", nowait = true, remap = false },
      {
        "<leader>F",
        "<cmd>Telescope live_grep theme=ivy<cr>",
        desc = "Find Text",
        nowait = true,
        remap = false,
      },
      {
        "<leader>b",
        -- "<cmd>lua require('telescope.builtin').buffers(require('telescope.themes').get_dropdown{previewer = false})<cr>",
        "<cmd>Telescope buffers theme=ivy<cr>",
        desc = "Buffers",
        nowait = true,
        remap = false,
      },
      { "<leader>c", "<cmd>BufDel<CR>", desc = "Close Buffer", nowait = true, remap = false },
      {
        "<leader>d",
        "<cmd>lua FindFiles()<CR>",
        desc = "Find relative to the working directory",
        nowait = true,
        remap = false,
      },
      -- NeoTree
      { "<leader>e",  name = "neotree",                 group = "NeoTree", color = "orange" },
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
      { "<leader>er", "<cmd>Neotree toggle reveal<cr>", desc = "Explore",  nowait = true,   remap = false },
      {
        "<leader>es",
        "<cmd>Neotree toggle float git_status<cr>",
        desc = "Reveal",
        nowait = true,
        remap = false,
      },
      --

      {
        "<leader>f",
        "<cmd>lua FindFilesRelative()<CR>",
        desc = "Find relative to the current buffer",
        nowait = true,
        remap = false,
      },

      -- TODO: Git or Go?
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
      { "<leader>i", group = "Insert Special Chars", nowait = true, remap = false },
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

      -- LSP
      { "<leader>l", group = "LSP",                  nowait = true, remap = false },
      {
        "<leader>la",
        "<cmd>lua vim.lsp.buf.code_action()<cr>",
        desc = "Code Action",
        nowait = true,
        remap = false,
      },
      {
        "<leader>ld",
        "<cmd>Telescope diagnostics<cr>",
        desc = "Diagnostics",
        nowait = true,
        remap = false,
      },
      --
      { "<leader>lc", group = "LSP Calls",                 nowait = true,   remap = false },
      {
        "<leader>lci",
        "<cmd>Telescope lsp_incoming_calls<cr>",
        desc = "Incoming Calls",
        nowait = true,
        remap = false,
      },
      {
        "<leader>lco",
        "<cmd>Telescope lsp_outgoing_calls<cr>",
        desc = "Outgoing Calls",
        nowait = true,
        remap = false,
      },
      --
      {
        "<leader>lgd",
        "<cmd>Telescope lsp_definitions<cr>",
        desc = "Go to Definition",
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
        "<leader>li",
        "<cmd>Telescope lsp_implementations<cr>",
        desc = "Implementations",
        nowait = true,
        remap = false,
      },
      {
        "<leader>lr",
        "<cmd>Telescope lsp_references<cr>",
        desc = "References",
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
      { "<leader>lR", "<cmd>lua vim.lsp.buf.rename()<cr>", desc = "Rename", nowait = true, remap = false },
      --
      {
        "<leader>q",
        "<cmd>Telescope quickfix<CR>",
        desc = "Quit",
        nowait = true,
        remap = false,
      },
      { "<leader>s",  group = "Search",               nowait = true,      remap = false },
      { "<leader>sC", "<cmd>Telescope commands<cr>",  desc = "Commands",  nowait = true, remap = false },
      { "<leader>sM", "<cmd>Telescope man_pages<cr>", desc = "Man Pages", nowait = true, remap = false },
      { "<leader>sR", "<cmd>Telescope registers<cr>", desc = "Registers", nowait = true, remap = false },
      {
        "<leader>sb",
        "<cmd>Telescope git_branches<cr>",
        desc = "Checkout branch",
        nowait = true,
        remap = false,
      },
      { "<leader>sc", "<cmd>Telescope colorscheme<cr>", desc = "Colorscheme",      nowait = true, remap = false },
      { "<leader>sh", "<cmd>Telescope help_tags<cr>",   desc = "Find Help",        nowait = true, remap = false },
      { "<leader>sk", "<cmd>Telescope keymaps<cr>",     desc = "Keymaps",          nowait = true, remap = false },
      { "<leader>so", "<cmd>TodoTelescope<cr>",         desc = "Commands",         nowait = true, remap = false },
      { "<leader>sr", "<cmd>Telescope oldfiles<cr>",    desc = "Open Recent File", nowait = true, remap = false },

      --
      {
        "<leader>t",
        'a<c-r>=strftime("%FT%T%z")<CR><Esc>',
        desc = "Timestamp",
        nowait = true,
        remap = false,
      },

      --
      -- PDE
      --
      { "<leader>x",  group = "PDE",      nowait = true,    remap = false },
      { "<leader>xO", "<cmd>Outline<cr>", desc = "Outline", nowait = true, remap = false },
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
      { "<leader>xd",  group = "Debug",                           nowait = true, remap = false },
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
      { "<leader>xdr", "<cmd>lua require('dap').repl_open()<CR>", desc = "Repl", nowait = true, remap = false },
      {
        "<leader>xdt",
        "<cmd>lua require('dap-go').debug_test()<CR>",
        desc = "Test",
        nowait = true,
        remap = false,
      },
      {
        "<leader>xdl",
        "<cmd>lua require('dap-go').debug_last()<CR>",
        desc = "Test",
        nowait = true,
        remap = false,
      },
      { "<leader>xdu", "<cmd>lua require('dapui').open()<CR>", desc = "UI",       nowait = true, remap = false },
      { "<leader>xo",  "<cmd>TodoTrouble<cr>",                 desc = "Todo",     nowait = true, remap = false },
      { "<leader>xr",  "<cmd>TroubleToggle<cr>",               desc = "Trouble",  nowait = true, remap = false },
      { "<leader>xt",  "<cmd>Twilight<cr>",                    desc = "Twilight", nowait = true, remap = false },

      -- TODO: clean up conflicting keymaps -- moved from trouble.nvim config
      {
        "<leader>xx",
        "<cmd>Trouble diagnostics toggle<cr>",
        desc = "Diagnostics (Trouble)",
      },
      {
        "<leader>xX",
        "<cmd>Trouble diagnostics toggle filter.buf=0<cr>",
        desc = "Buffer Diagnostics (Trouble)",
      },
      {
        "<leader>xs",
        "<cmd>Trouble symbols toggle focus=false<cr>",
        desc = "Symbols (Trouble)",
      },
      {
        "<leader>xl",
        "<cmd>Trouble lsp toggle focus=false win.position=right<cr>",
        desc = "LSP Definitions / references / ... (Trouble)",
      },
      {
        "<leader>xL",
        "<cmd>Trouble loclist toggle<cr>",
        desc = "Location List (Trouble)",
      },
      {
        "<leader>xQ",
        "<cmd>Trouble qflist toggle<cr>",
        desc = "Quickfix List (Trouble)",
      },
    },
  },
}
