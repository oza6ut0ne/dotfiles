if &compatible
  set nocompatible
endif

if &shell =~# 'fish$'
  set shell=bash
endif

let g:python_host_prog=$PYENV_ROOT.'/versions/neovim-2/bin/python'
let g:python3_host_prog=$PYENV_ROOT.'/versions/neovim-3/bin/python'
runtime! userautoload/*.vim
nnoremap ; :
nnoremap : ;

:syntax enable
:colorscheme ronkai
:set hlsearch
:set number
:set mouse=a
:set tabstop=4
:set shiftwidth=4
:set softtabstop=4
:set expandtab
:set autoindent
:set smartindent
:set laststatus=1

