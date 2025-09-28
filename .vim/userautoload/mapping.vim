nnoremap ; :
nnoremap : ;
xnoremap ; :
xnoremap : ;

inoremap jj <Esc>
nnoremap x  "_x
xnoremap x  "_x
nnoremap c  "_c
xnoremap c  "_c
xnoremap p  P
xnoremap P  p
nnoremap s  :%s//g<Left><Left>
nnoremap S  :%s///g<Left><Left>
xnoremap s  :s//g<Left><Left>
xnoremap S  :s///g<Left><Left>
nnoremap /  /\v
xnoremap /  /\v
nnoremap ?  ?\v
xnoremap ?  ?\v
nnoremap <C-/> /\V
xnoremap <C-/> /\V
nnoremap <C-?> ?\V
xnoremap <C-?> ?\V
nnoremap <silent> <C-l> :<C-u>nohlsearch<CR><C-l>

nnoremap ZZ <Nop>
nnoremap ZQ <Nop>
nnoremap <script><expr> Q empty(reg_recording()) ? '@q' : 'q@q'

nnoremap <expr> j v:count == 0 ? 'gj' : 'j'
xnoremap <expr> j (v:count == 0 && mode() ==# 'v') ? 'gj' : 'j'
nnoremap <expr> k v:count == 0 ? 'gk' : 'k'
xnoremap <expr> k (v:count == 0 && mode() ==# 'v') ? 'gk' : 'k'
nnoremap gj j
xnoremap gj j
nnoremap gk k
xnoremap gk k

cnoremap <C-a> <Home>
cnoremap <C-b> <Left>
cnoremap <C-d> <Del>
cnoremap <C-e> <End>
cnoremap <C-f> <Right>
cnoremap <C-y> <C-r>"
cnoremap <C-p> <Up>
cnoremap <C-n> <Down>

tnoremap <Esc> <C-\><C-n>
tnoremap jj    <C-\><C-n>

if !has('nvim')
  nnoremap Y  y$
  xnoremap <silent> * "vy/\V<C-r>=substitute(escape(@v,'\/'),"\n",'\\n','g')<CR><CR>
  xnoremap <silent> # "vy?\V<C-r>=substitute(escape(@v,'\/'),"\n",'\\n','g')<CR><CR>
endif

let mapleader = "\<Space>\<Space>"
let maplocalleader = ","

augroup mappings
  autocmd!
  autocmd FileType qf nnoremap <buffer> j  j
  autocmd FileType qf nnoremap <buffer> k  k
  autocmd FileType qf nnoremap <buffer> gj gj
  autocmd FileType qf nnoremap <buffer> gk gk
augroup END

"--------------------------------
" QuickRun
"--------------------------------
nnoremap <silent> <Space>r :<C-u>QuickRun<CR>

"--------------------------------
" NERDTree
"--------------------------------
nnoremap <silent> <Space>n :<C-u>NERDTreeToggle<CR>
nnoremap <silent> <Space>N :<C-u>NERDTreeFind<CR>

"--------------------------------
" denite
"--------------------------------
nnoremap [denite] <Nop>
nmap     <Space>d [denite]

nnoremap <silent> [denite]f :<C-u>Denite file/rec<CR>
nnoremap <silent> [denite]F :<C-u>Denite file/rec/git<CR>
nnoremap <silent> [denite]G :<C-u>Denite file/rec/git/untracked<CR>
nnoremap <silent> [denite]b :<C-u>Denite buffer<CR>
nnoremap <silent> [denite]B :<C-u>Denite buffer/all<CR>
nnoremap <silent> [denite]o :<C-u>Denite file/old<CR>
nnoremap <silent> [denite]O :<C-u>Denite outline<CR>
nnoremap <silent> [denite]c :<C-u>Denite command<CR>
nnoremap <silent> [denite]h :<C-u>Denite command_history<CR>
nnoremap <silent> [denite]r :<C-u>Denite register<CR>
nnoremap <silent> [denite]g :<C-u>Denite grep<CR>
nnoremap <silent> [denite]H :<C-u>Denite help<CR>

if exists('g:vscode')
  nnoremap <silent> u     :<C-u>call VSCodeNotify('undo')<CR>
  nnoremap <silent> <C-r> :<C-u>call VSCodeNotify('redo')<CR>
endif
