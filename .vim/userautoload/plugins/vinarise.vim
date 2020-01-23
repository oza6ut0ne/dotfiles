autocmd FileType vinarise-bitmapview setl norelativenumber
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
