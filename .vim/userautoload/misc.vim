if exists('g:vscode')
  finish
endif

augroup misc
  autocmd!
  autocmd QuickFixCmdPost *grep* cwindow
  autocmd FileType vim  setl tabstop=2
  autocmd FileType toml setl tabstop=2
  autocmd FileType yaml setl tabstop=2
augroup END
