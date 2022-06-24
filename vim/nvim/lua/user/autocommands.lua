vim.cmd([[
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
    autocmd BufWritePre $HOME/notes/**/*.md mark a|silent! 1,10s/^modified: \\d\\d\\d\\d.*/\\=strftime('modified: %FT%T%z')/|norm!`a
  augroup end

  augroup _go
    autocmd!
    autocmd BufWinEnter *.tmpl setlocal filetype=gotexttmpl
    autocmd BufWinEnter *.tpl setlocal filetype=gotexttmpl
    autocmd FileType gitcommit setlocal spell
  augroup end

  augroup _notes
    autocmd!
    autocmd FileType telekasten hi tklink guifg=#00dfff|hi tkBrackets guifg=#264F78 |hi tkHighlight guibg=#ff007c guifg=#9d0006 gui=bold
  augroup end

  augroup _auto_resize
    autocmd!
    autocmd VimResized * tabdo wincmd = 
  augroup end

  augroup _alpha
    autocmd!
    autocmd User AlphaReady set showtabline=0 | autocmd BufUnload <buffer> set showtabline=2
  augroup end

  augroup _lsp
    autocmd!
    autocmd BufWritePre * lua vim.lsp.buf.formatting()
  augroup end
]])
