set -x TERM xterm-256color
set -x fish_greeting

set -x fish_color_autosuggestion white
set -x fish_color_param '0FC' brcyan
set -e fish_color_command

set -x EDITOR nvim
set -x DISPLAY localhost:10.0
set -x PATH "$HOME/bin" $PATH

alias ll='ls -alF'
alias cp='cp -i'
alias mv='mv -i'
alias rm='rm -i'
alias crontab='crontab -i'
balias vi nvim

# anyenv
# set -x PATH  "$HOME/.anyenv/bin" $PATH
# eval (anyenv init - fish)

# pyenv
if which pyenv >/dev/null 2>&1
    set -x PYENV_ROOT "$HOME/.pyenv"
    set -x PATH "$PYENV_ROOT/bin" $PATH
    status --is-interactive; and source (pyenv init -|psub)
end

# goenv
if which goenv >/dev/null 2>&1
    set -x GOENV_ROOT "$HOME/.anyenv/envs/goenv"
    set -x PATH "$HOME/.anyenv/envs/goenv/bin" $PATH 
    set -x PATH "$HOME/.anyenv/envs/goenv/shims" $PATH 
    command goenv rehash 2>/dev/null
end
set -x GOPATH "$HOME/go"
set -x PATH "$GOPATH/bin" $PATH 

# direnv
if which direnv >/dev/null 2>&1
    eval (direnv hook fish)
end

# thefuck
set -x THEFUCK_OVERRIDDEN_ALIASES 'vi'

