if exists('g:vscode')
  finish
endif

function! s:ft_rust_script() abort
  setfiletype rust
  let b:quickrun_config = {'exec' : 'rust-script %o %s -- %a'}
endfunction

augroup filetypes
  autocmd! BufRead,BufNewFile .gitconfig.local  setfiletype gitconfig
  autocmd! BufRead,BufNewFile *.ers  call s:ft_rust_script()
augroup END

augroup binary
  autocmd!
  autocmd BufReadPost * if &binary | silent %!xxd -g 1
  autocmd BufReadPost * set ft=xxd | endif
  autocmd BufWritePre * if &binary | execute '%!xxd -r' | endif
  autocmd BufWritePost * if &binary | silent %!xxd -g 1
  autocmd BufWritePost * set nomod | endif
augroup END

augroup misc
  autocmd!
  autocmd QuickFixCmdPost *grep* cwindow
  autocmd FileType vim  setl tabstop=2
  autocmd FileType lua  setl tabstop=2
  autocmd FileType nix  setl tabstop=2
  autocmd FileType json setl tabstop=2
  autocmd FileType toml setl tabstop=2
  autocmd FileType yaml setl tabstop=2
  autocmd FileType html setl tabstop=2
  autocmd FileType css  setl tabstop=2
  autocmd FileType javascript      setl tabstop=2
  autocmd FileType typescript      setl tabstop=2
  autocmd FileType javascriptreact setl tabstop=2
  autocmd FileType typescriptreact setl tabstop=2
augroup END
