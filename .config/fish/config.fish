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
set -x PATH  "$HOME/.anyenv/bin" $PATH
anyenv init - | grep -v '..env rehash' | source

set -x PATH "$HOME/go/bin" $PATH

# direnv
if which direnv >/dev/null 2>&1
    eval (direnv hook fish)
end

# thefuck
set -x THEFUCK_OVERRIDDEN_ALIASES 'vi'

