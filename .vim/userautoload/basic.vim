:set clipboard=unnamedplus
:set number
:set relativenumber
:set laststatus=2
:set fileencodings=ucs-bom,utf-8,cp932,default,latin1
:set statusline=%F%m%r%h%w%=[%l/%L][%2.v][%P]%y[%{&ff}][%{&fenc}]
:set list
:set listchars=tab:>-,trail:-,extends:>,precedes:<,nbsp:%
:set whichwrap=b,s,h,l,<,>,[,],~
:set mouse=a
:set hidden

:set shiftwidth=4
:set expandtab
:set tabstop=4
:set softtabstop=4
:set scrolloff=3
:set autoindent
:set smartindent
:set completeopt=menuone,preview,noinsert
:set foldmethod=indent
:set foldlevelstart=99

:set hlsearch
:set incsearch
:set ignorecase
:set smartcase

if has('nvim')
  :set inccommand=nosplit
endif
