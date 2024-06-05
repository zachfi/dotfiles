vim.cmd([[
  autocmd BufWritePre $HOME/notes/**/*.md mark a|silent! 1,10s/^modified: \d\d\d\d.*/\=strftime('modified: %FT%T%z')/|norm!`a

  autocmd BufWritePre (InsertLeave?) <buffer> lua vim.lsp.buf.formatting_sync(nil,500)

  augroup _general_settings
    autocmd!
    autocmd FileType qf,help,man,lspinfo nnoremap <silent> <buffer> q :close<CR>
    autocmd TextYankPost * silent!lua require('vim.highlight').on_yank({higroup = 'Visual', timeout = 200})
    autocmd BufWinEnter * :set formatoptions-=cro
    autocmd FileType qf set nobuflisted
  augroup end

  augroup _git
    autocmd!
    autocmd FileType gitcommit setlocal wrap
    autocmd FileType gitcommit setlocal spell
  augroup end

  augroup _markdown
    autocmd!
    autocmd FileType markdown setlocal wrap
    autocmd FileType markdown setlocal spell
    autocmd FileType markdown setlocal linebreak
    autocmd BufWritePre $HOME/notes/**/*.md mark a|silent! 1,10s/^modified: \d\d\d\d.*/\=strftime('modified: %FT%T%z')/|norm!`a
  augroup end

  augroup _tmpl
    autocmd!
    autocmd BufWinEnter *.tmpl setlocal filetype=mustache
    autocmd BufWinEnter *.tpl setlocal filetype=mustache
  augroup end

  augroup _alloy
    autocmd!
    autocmd BufWinEnter *.river setlocal filetype=alloy
    autocmd BufWinEnter *.flow setlocal filetype=alloy
  augroup end

  " augroup _notes
  "   autocmd!
  "   autocmd FileType markdown hi tklink guifg=#00dfff|hi tkBrackets guifg=#264F78 |hi tkHighlight guibg=#ff007c guifg=#9d0006 gui=bold
  "   autocmd BufWritePre markdown mark a| 1,10s/^modified: \d\d\d\d.*/\=strftime('modified: %FT%T%z')/|norm!`a
  " augroup end

  augroup _auto_resize
    autocmd!
    autocmd VimResized * tabdo wincmd =
  augroup end

  augroup _alpha
    autocmd!
    autocmd User AlphaReady set showtabline=0 | autocmd BufUnload <buffer> set showtabline=2
  augroup end

  augroup _tilt
    autocmd!
    autocmd BufRead Tiltfile setf=tiltfile
  augroup end
]])

vim.api.nvim_create_autocmd("CursorHold", {
  callback = function()
    local opts = {
      focusable = false,
      close_events = { "BufLeave", "CursorMoved", "InsertEnter", "FocusLost" },
      border = "rounded",
      source = "always",
      prefix = " ",
      scope = "cursor",
    }
    vim.diagnostic.open_float(nil, opts)
  end,
})

vim.api.nvim_create_autocmd({ "BufWritePost" }, {
  callback = function()
    -- try_lint without arguments runs the linters defined in `linters_by_ft`
    -- for the current filetype
    require("lint").try_lint()

    -- You can call `try_lint` with a linter name or a list of names to always
    -- run specific linters, independent of the `linters_by_ft` configuration
    -- require("lint").try_lint("cspell")
  end,
})
