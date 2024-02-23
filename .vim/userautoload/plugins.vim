let s:parent = fnamemodify(resolve(expand('<sfile>:p')), ':h')
if !filereadable(s:parent . '/plugins.enabled')
  finish
endif

let g:dein#auto_recache = 1

" Directory for dein.vim.
let s:dein_dir = expand('~/.cache/dein')
" Directory for dein.vim repository.
let s:dein_repo_dir = s:dein_dir . '/repos/github.com/Shougo/dein.vim'

" Install dein.vim if not installed.
if &runtimepath !~# '/dein.vim'
  if !isdirectory(s:dein_repo_dir)
    execute '!git clone https://github.com/Shougo/dein.vim' s:dein_repo_dir
  endif
  execute 'set runtimepath^=' . substitute(
        \ fnamemodify(s:dein_repo_dir, ':p') , '[/\\]$', '', '')
endif

" Load TOMLs.
if dein#load_state(s:dein_dir)
  call dein#begin(s:dein_dir)

  let g:rc_dir    = expand('~/.vim/rc')
  let s:toml      = g:rc_dir . '/dein.toml'
  let s:lazy_toml = g:rc_dir . '/dein_lazy.toml'

  call dein#load_toml(s:toml,      {'lazy': 0})
  call dein#load_toml(s:lazy_toml, {'lazy': 1})

  call dein#end()
  call dein#save_state()
endif

" Install plugins if not installed.
if dein#check_install()
  call dein#install()
endif

if exists('g:vscode')
  finish
endif

runtime! userautoload/plugins/*.vim
