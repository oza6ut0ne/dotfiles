nnoremap ; :
nnoremap : ;
xnoremap ; :
xnoremap : ;

inoremap jj <Esc>
nnoremap x  "_x
xnoremap x  "_x
" nnoremap c  "_c
" xnoremap c  "_c
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

nnoremap <space>y "+y
xnoremap <space>y "+y
nnoremap <space>Y "+y$
nnoremap <space>p "+p
nnoremap <space>P "+P
xnoremap <space>p "+P
xnoremap <space>P "+p
nnoremap <space><space>p "0p
nnoremap <space><space>P "0P
xnoremap <space><space>p "0P
xnoremap <space><space>P "0p
nnoremap <space><space>]p "0]p
nnoremap <space><space>]P "0]P
xnoremap <space><space>]p "0]P
xnoremap <space><space>]P "0]p

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

nnoremap <Plug>(H) <Nop>
nnoremap <Plug>(L) <Nop>
nnoremap H H<Plug>(H)
nnoremap L L<Plug>(L)
nnoremap <Plug>(H)H <PageUp>H<Plug>(H)
nnoremap <Plug>(L)L <PageDown>Lzb<Plug>(L)

nnoremap <Plug>(tabmode) <Nop>
nnoremap <silent> <Plug>(tabmode)<C-n> <Cmd>tabnext<CR><Plug>(tabmode)
nnoremap <silent> <Plug>(tabmode)<C-p> <Cmd>tabprevious<CR><Plug>(tabmode)
nnoremap <silent> <C-w>t <Cmd>tabnew<CR>
nnoremap <silent> <C-w>d <Cmd>tabclose<CR>
nnoremap <silent> <C-w><C-t> <Cmd>tabnew<CR>
nnoremap <silent> <C-w><C-d> <Cmd>tabclose<CR>
nnoremap <silent> <C-w><C-n> <Cmd>tabnext<CR><Plug>(tabmode)
nnoremap <silent> <C-w><C-p> <Cmd>tabprevious<CR><Plug>(tabmode)
nnoremap <silent> <C-w>1 <Cmd>silent! tabnext 1<CR>
nnoremap <silent> <C-w>2 <Cmd>silent! tabnext 2<CR>
nnoremap <silent> <C-w>3 <Cmd>silent! tabnext 3<CR>
nnoremap <silent> <C-w>4 <Cmd>silent! tabnext 4<CR>
nnoremap <silent> <C-w>5 <Cmd>silent! tabnext 5<CR>
nnoremap <silent> <C-w>6 <Cmd>silent! tabnext 6<CR>
nnoremap <silent> <C-w>7 <Cmd>silent! tabnext 7<CR>
nnoremap <silent> <C-w>8 <Cmd>silent! tabnext 8<CR>
nnoremap <silent> <C-w>9 <Cmd>silent! tabnext 9<CR>
nnoremap <silent> <C-w>0 <C-w>g<TAB>
nnoremap <silent> <C-w><C-1> <Cmd>silent! tabnext 1<CR>
nnoremap <silent> <C-w><C-2> <Cmd>silent! tabnext 2<CR>
nnoremap <silent> <C-w><C-3> <Cmd>silent! tabnext 3<CR>
nnoremap <silent> <C-w><C-4> <Cmd>silent! tabnext 4<CR>
nnoremap <silent> <C-w><C-5> <Cmd>silent! tabnext 5<CR>
nnoremap <silent> <C-w><C-6> <Cmd>silent! tabnext 6<CR>
nnoremap <silent> <C-w><C-7> <Cmd>silent! tabnext 7<CR>
nnoremap <silent> <C-w><C-8> <Cmd>silent! tabnext 8<CR>
nnoremap <silent> <C-w><C-9> <Cmd>silent! tabnext 9<CR>
nnoremap <silent> <C-w><C-0> <C-w>g<TAB>

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
