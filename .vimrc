if &compatible
  set nocompatible
endif

if &shell =~# 'fish$'
  set shell=bash
endif

filetype off

let g:python_host_prog=$PYENV_ROOT.'/versions/neovim-2/bin/python'
let g:python3_host_prog=$PYENV_ROOT.'/versions/neovim-3/bin/python'
runtime! userautoload/**/*.vim

filetype plugin indent on

