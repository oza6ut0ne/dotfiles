nnoremap ; :
nnoremap : ;
xnoremap ; :
xnoremap : ;

inoremap jj <Esc>
nnoremap x  "_x
nnoremap s  :%s//g<Left><Left>
nnoremap S  :%s///g<Left><Left>
xnoremap s  :s//g<Left><Left>
xnoremap S  :s///g<Left><Left>
nnoremap <silent> <C-l> :<C-u>nohlsearch<CR><C-l>

nnoremap ZZ <Nop>
nnoremap ZQ <Nop>
nnoremap Q  <Nop>

cnoremap <C-a> <Home>
cnoremap <C-b> <Left>
cnoremap <C-d> <Del>
cnoremap <C-e> <End>
cnoremap <C-f> <Right>
cnoremap <C-y> <C-r>*

let mapleader = "\<Space>\<Space>"

"--------------------------------
" NERDTree
"--------------------------------
nnoremap <silent> <Space>n :<C-u>NERDTreeToggle<CR>

"--------------------------------
" denite
"--------------------------------
nnoremap [denite] <Nop>
nmap     <Space>d [denite]

nnoremap <silent> [denite]f :<C-u>Denite file/rec<CR>
nnoremap <silent> [denite]b :<C-u>Denite buffer<CR>
nnoremap <silent> [denite]o :<C-u>Denite file/old<CR>
nnoremap <silent> [denite]c :<C-u>Denite command<CR>
nnoremap <silent> [denite]h :<C-u>Denite command_history<CR>
nnoremap <silent> [denite]r :<C-u>Denite register<CR>
nnoremap <silent> [denite]g :<C-u>Denite grep<CR>
nnoremap <silent> [denite]H :<C-u>Denite help<CR>
