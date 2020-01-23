:syntax enable

if has('nvim')
  set termguicolors
  set pumblend=10
  set winblend=10
  colorscheme default

  hi NonText ctermfg=12 guifg=#729fcf
  hi Pmenu ctermfg=0 ctermbg=13 guifg=#000000 guibg=#ad7fa8
  hi NormalFloat ctermfg=159 ctermbg=60 guifg=#00ffff guibg=#5e5aa0 
  hi PmenuSel ctermfg=242 ctermbg=0 guifg=#6c6c6c guibg=#2e3436
else
  colorscheme ronkai
endif
