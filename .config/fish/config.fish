set -x TERM xterm-256color
set -x fish_greeting

set -x fish_color_autosuggestion white
set -x fish_color_param '0FC' brcyan
set -e fish_color_command

set -x PATH "$HOME/bin" $PATH
balias ll 'ls -alF'
balias vi nvim

# anyenv
# set -x PATH  "$HOME/.anyenv/bin" $PATH
# eval (anyenv init - fish)

# pyenv
set -x PYENV_ROOT "$HOME/.pyenv"
set -x PATH "$PYENV_ROOT/bin" $PATH

# goenv
set -x GOENV_ROOT "$HOME/.anyenv/envs/goenv"
set -x PATH "$HOME/.anyenv/envs/goenv/bin" $PATH 
set -x PATH "$HOME/.anyenv/envs/goenv/shims" $PATH 
command goenv rehash 2>/dev/null
set -x GOPATH "$HOME/go"
set -x PATH "$GOPATH/bin" $PATH 

# direnv
# eval (direnv hook fish)

