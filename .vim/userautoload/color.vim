syntax enable

function! s:override_color_settings() abort
  hi NonText ctermfg=12 guifg=#729fcf
  hi Pmenu ctermfg=0 ctermbg=13 guifg=#000000 guibg=#ad7fa8
  hi NormalFloat ctermfg=159 ctermbg=60 guifg=#00ffff guibg=#5e5aa0
  hi PmenuSel ctermfg=242 ctermbg=0 guifg=#6c6c6c guibg=#2e3436
  hi CocMenuSel ctermfg=159 ctermbg=0 guifg=#00ffff guibg=#2e3436

  hi! link CocFloating NormalFloat

  hi! link ALEVirtualTextError DiagnosticVirtualTextError
  hi! link ALEVirtualTextWarning DiagnosticVirtualTextWarn
  hi! link ALEVirtualTextInfo DiagnosticVirtualTextInfo
  hi! link ALEVirtualTextStyleError DiagnosticVirtualTextHint
  hi! link ALEVirtualTextStyleWarning DiagnosticVirtualTextHint
endfunction

if has('termguicolors')
  set termguicolors
endif

autocmd ColorScheme * call s:override_color_settings()

if has('nvim')
  set pumblend=10
  set winblend=10

  autocmd ColorScheme default hi Normal ctermfg=10 guifg=#94f13a
  colorscheme default
else
  if &term !~ 'xterm'
    let &t_8f = "\<Esc>[38:2:%lu:%lu:%lum"
    let &t_8b = "\<Esc>[48:2:%lu:%lu:%lum"
  endif

  colorscheme ronkai
endif
