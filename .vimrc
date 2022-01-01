if &compatible
  set nocompatible
endif

if &shell =~# 'fish$'
  set shell=bash
endif

filetype off

let g:python_host_prog=$PYENV_ROOT.'/versions/neovim-2/bin/python'
let g:python3_host_prog=$PYENV_ROOT.'/versions/neovim-3/bin/python'
runtime! userautoload/*.vim

let s:local_vimrc = fnamemodify('~/.vimrc.local', ':p')
if filereadable(s:local_vimrc)
  execute 'source' s:local_vimrc
endif

filetype plugin indent on
