
" Set the leader
let mapleader = ';'

noremap <Leader>s :update<CR>
noremap <Leader>v :vsplit<CR>
noremap <Leader>c :close<CR>
noremap <Leader>e :Explore<CR>

" Date/Time Stamp
map <leader>t a<c-r>=strftime("%Y-%m-%d %H:%M:%S")<CR><Esc>

" Replace DNS ZONE SOA
nnoremap <F8> /\<\d\{10}\><CR>ce<C-r>=strftime("%Y%m%d00")<CR><Esc>:echo @"<CR>

" Clear search highlights
noremap <silent><leader>/ :nohls<CR>

" select all
"map <leader>a ggVG

" Disable Ruler
nnoremap <F7> :set nonumber!<CR>

" reflow paragraph with Q in normal and visual mode
nnoremap Q gqap
vnoremap Q gq

" Make Y behave like other capitals
map Y y$

" sane movement with wrap turned on
nnoremap j gj
nnoremap k gk
vnoremap j gj
vnoremap k gk

" Disable arrow keys for hjkl training
"inoremap  <Up>     <NOP>
"inoremap  <Down>   <NOP>
"inoremap  <Left>   <NOP>
"inoremap  <Right>  <NOP>
noremap   <Up>     <NOP>
noremap   <Down>   <NOP>
noremap   <Left>   <NOP>
noremap   <Right>  <NOP>

" Reselect visual block after indent/outdent
vnoremap < <gv
vnoremap > >gv

" Easy split navigation
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

" Better Command line Editing
"cnoremap <C-j> <t_kd>
"cnoremap <C-k> <t_ku>
cnoremap <C-a> <Home>
cnoremap <C-e> <End>

" Align characters
vnoremap <Leader>> :Align =><CR>
vnoremap <Leader>= :Align =<CR>

" Toggle listing invisible characters
nmap <leader>l :set list!<CR>

"---------------------------------------------------
"----- various encryption and decryption stuff -----
"
"
"---------------------------------------------------
"
"----- gnupg encryption and decryption
"---- encrypt and sign the message then armor it too
" map <leader>e :%!/bin/sh -c 'gpg -se -a 2>/dev/tty'
"---- just encrypt and armor the message
" map <leader>E :%!/bin/sh -c 'gpg -e -a 2>/dev/tty'
"---- decrypt
" map <leader>d :/^-----BEG/,/^-----END/!/bin/sh -c 'gpg -d 2>/dev/tty'
"----- sign
" map <leader>s :,$! /bin/sh -c 'gpg --clearsign 2>/dev/tty'

inoremap <expr> <C-n> pumvisible() ? '<C-n>' :
  \ '<C-n><C-r>=pumvisible() ? "\<lt>Down>" : ""<CR>'

inoremap <expr> <M-,> pumvisible() ? '<C-n>' :
  \ '<C-x><C-o><C-n><C-p><C-r>=pumvisible() ? "\<lt>Down>" : ""<CR>'


"
" Tabs
"nnoremap <silent><CSI>] :tabnext<CR>
"nnoremap <silent><CSI>[ :tabprevious<CR>
"nnoremap <silent><S-n> :tabnext<CR>
"nnoremap <silent><S-p> :tabprevious<CR>
nnoremap <C-n> :tabnext<CR>
nnoremap <C-p> :tabprevious<CR>
nnoremap <C-t> :tabnew<CR>
nnoremap <C-k> :tabclose<CR>

" ----------
"  FuzzyFinder
" ----------

if v:version >= 703
  noremap <Leader>f :FufFileWithCurrentBufferDir<CR>
  noremap <Leader>F :FufFile<CR>
  noremap <Leader>v :FufCoverageFile<CR>
  noremap <Leader>b :FufBuffer<CR>
  noremap <Leader>c :FufDirWithFullCwd<CR>
  noremap <Leader>u :FufRenewCache<CR>
  noremap <Leader>w :bdelete<CR>
  noremap <F1> :FufHelp<CR>
endif

