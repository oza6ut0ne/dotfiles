if exists('g:vscode')
  finish
endif

augroup filetypes
  autocmd! BufRead,BufNewFile .gitconfig.local  setfiletype gitconfig
  autocmd! BufRead,BufNewFile .tmux.conf.local  setfiletype tmux
  autocmd! BufRead,BufNewFile *.ers  setfiletype rust
augroup END

augroup misc
  autocmd!
  autocmd QuickFixCmdPost *grep* cwindow
  autocmd FileType vim  setl tabstop=2
  autocmd FileType toml setl tabstop=2
  autocmd FileType yaml setl tabstop=2
augroup END
