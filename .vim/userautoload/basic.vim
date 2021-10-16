set clipboard=unnamedplus
set number
set relativenumber
set laststatus=2
set fileencodings=ucs-bom,utf-8,cp932,euc-jp,default,latin1
set list
set listchars=tab:>-,trail:-,extends:>,precedes:<,nbsp:%
set whichwrap=b,s,h,l,<,>,[,],~
set mouse=a
set hidden

set expandtab
set tabstop=4
set shiftwidth=0
set softtabstop=-1
set scrolloff=3
set autoindent
set smartindent
set completeopt=menuone,preview,noinsert
set foldmethod=indent
set foldlevelstart=99

set hlsearch
set incsearch
set ignorecase
set smartcase

set splitbelow
set splitright

function! SkkStatus() abort
  return exists('*eskk#statusline') ? eskk#statusline() : ''
endfunction

set statusline=%F%m%r%h%w%=
  \%{SkkStatus()}[%l/%L][%2.v][%P]%y[%{&ts}][%{&ff}][%{&fenc}]

if exists('+diffopt')
  set diffopt+=algorithm:histogram,indent-heuristic
endif

if has('nvim')
  set inccommand=nosplit
endif
