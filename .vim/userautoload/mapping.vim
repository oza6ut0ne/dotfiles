nnoremap ; :
nnoremap : ;

inoremap jj <Esc>

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
