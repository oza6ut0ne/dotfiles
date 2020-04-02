set -x TERM screen-256color
set -x fish_greeting

set -x fish_color_autosuggestion white
set -x fish_color_param '0FC' brcyan
set -x fish_color_command normal

set -x EDITOR nvim
set -x SUDO_EDITOR 'nvim -R'
set -x PATH "$HOME/bin" $PATH

alias ll='ls -alF'
alias cp='cp -i'
alias mv='mv -i'
alias rm='rm -i'
alias crontab='crontab -i'
alias vi nvim

# anyenv
set -x PATH  "$HOME/.anyenv/bin" $PATH
anyenv init - fish | grep -v '..env rehash' | source

set -x PATH "$HOME/go/bin" $PATH

# direnv
if which direnv >/dev/null 2>&1
    eval (direnv hook fish)
end

# thefuck
set -x THEFUCK_OVERRIDDEN_ALIASES 'vi'

# snap
if test -f /etc/profile.d/apps-bin-path.sh
    bass source /etc/profile.d/apps-bin-path.sh
end
