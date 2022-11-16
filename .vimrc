if &compatible
  set nocompatible
endif

if &shell =~# 'fish$'
  set shell=bash
endif

filetype off

let g:loaded_python_provider = 0
if !has('win32')
  let g:python3_host_prog='/usr/bin/python3'
endif

runtime! userautoload/*.vim

let s:local_vimrc = fnamemodify('~/.vimrc.local', ':p')
if filereadable(s:local_vimrc)
  execute 'source' s:local_vimrc
endif

filetype plugin indent on
