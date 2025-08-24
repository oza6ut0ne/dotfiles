" local syntax file - set colors on a per-machine basis:
" vim: tw=0 ts=4 sw=4
" Vim color file
" Maintainer:	Ron Aaron <ron@ronware.org>
" Last Change:	2013 May 24

set background=dark
hi clear
if exists("syntax_on")
  syntax reset
endif
let g:colors_name = "ronkai"

if has("gui_running")
  hi Normal		guifg=#94f13a guibg=black
else
  hi Normal ctermfg=10 guifg=#94f13a
endif

hi SignColumn ctermfg=14 ctermbg=242 guifg=cyan guibg=#6c6c6c

hi ShowMarksHL ctermfg=cyan ctermbg=lightblue cterm=bold guifg=cyan guibg=lightblue gui=bold
hi clear Visual
hi Visual		term=reverse cterm=reverse gui=reverse
hi DiffAdd    	cterm=bold ctermbg=23
hi DiffDelete 	cterm=bold ctermbg=52
hi DiffChange 	cterm=bold ctermbg=18
hi DiffText   	cterm=bold ctermbg=red

hi Constant ctermfg=208 guifg=#ff8700
hi Pmenu		ctermfg=159 ctermbg=60 guifg=#00ffff guibg=#5e5aa0

hi ALEVirtualTextError        ctermfg=1 guifg=Red
hi ALEVirtualTextWarning      ctermfg=3 guifg=Orange
hi ALEVirtualTextInfo         ctermfg=4 guifg=LightBlue
hi ALEVirtualTextStyleError   ctermfg=7 guifg=LightGrey
hi ALEVirtualTextStyleWarning ctermfg=7 guifg=LightGrey
