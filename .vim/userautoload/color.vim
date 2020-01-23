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

"--------------------------------
" vinarise.vim
"--------------------------------
autocmd FileType vinarise-bitmapview call s:vinarise_bitmapview_bz()
function! s:vinarise_bitmapview_bz() abort
  hi vinarise_BitmapviewCntrl1 guifg=#00ffff guibg=#00ffff ctermfg=cyan ctermbg=cyan
  hi vinarise_BitmapviewCntrl2 guifg=#00ffff guibg=#00ffff ctermfg=cyan ctermbg=cyan
  hi vinarise_BitmapviewCntrl3 guifg=#00ffff guibg=#00ffff ctermfg=cyan ctermbg=cyan
  hi vinarise_BitmapviewCntrl4 guifg=#00ffff guibg=#00ffff ctermfg=cyan ctermbg=cyan
  hi vinarise_BitmapviewAscii1 guifg=#ff0000 guibg=#ff0000 ctermfg=red ctermbg=red
  hi vinarise_BitmapviewAscii2 guifg=#ff0000 guibg=#ff0000 ctermfg=red ctermbg=red
  hi vinarise_BitmapviewAscii3 guifg=#ff0000 guibg=#ff0000 ctermfg=red ctermbg=red
  hi vinarise_BitmapviewAscii4 guifg=#ff0000 guibg=#ff0000 ctermfg=red ctermbg=red
  hi vinarise_BitmapviewEscape1 guifg=#000000 guibg=#000000 ctermfg=black ctermbg=black
  hi vinarise_BitmapviewEscape2 guifg=#000000 guibg=#000000 ctermfg=black ctermbg=black
  hi vinarise_BitmapviewEscape3 guifg=#000000 guibg=#000000 ctermfg=black ctermbg=black
  hi vinarise_BitmapviewEscape4 guifg=#000000 guibg=#000000 ctermfg=black ctermbg=black

  hi vinarise_BitmapviewNewLine guifg=#00ffff guibg=#00ffff ctermfg=cyan ctermbg=cyan
  hi vinarise_BitmapviewTab guifg=#00ffff guibg=#00ffff ctermfg=cyan ctermbg=cyan
  hi vinarise_BitmapviewNull guifg=#ffffff guibg=#ffffff ctermfg=white ctermbg=white
  hi vinarise_BitmapviewFF guifg=#000000 guibg=#000000 ctermfg=black ctermbg=black
endfunction

