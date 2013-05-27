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

