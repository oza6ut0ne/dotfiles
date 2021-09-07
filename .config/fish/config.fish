# profile
if test -f $HOME/.profile
    bass source $HOME/.profile
end

# snap
if test -f /etc/profile.d/apps-bin-path.sh
    bass source /etc/profile.d/apps-bin-path.sh
end

# appearance
set -x TERM screen-256color
set -g fish_greeting
set -g theme_short_path yes

set -g fish_color_autosuggestion white
set -g fish_color_param '0FC' brcyan
set -g fish_color_command normal
set -g fish_color_quote yellow
set -g fish_color_operator bryellow
set -g fish_color_redirection 00afff

alias ls='ls --color=auto'
alias dir='dir --color=auto'
alias vdir='vdir --color=auto'
alias diff='diff --color=auto'
alias ip='ip --color'

alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'

set -x LESS_TERMCAP_mb (printf '\e[1;31m')     # begin blink
set -x LESS_TERMCAP_md (printf '\e[1;36m')     # begin bold
set -x LESS_TERMCAP_me (printf '\e[0m')        # reset bold/blink
set -x LESS_TERMCAP_so (printf '\e[01;33m')    # begin reverse video
set -x LESS_TERMCAP_se (printf '\e[0m')        # reset reverse video
set -x LESS_TERMCAP_us (printf '\e[1;4;32m')   # begin underline
set -x LESS_TERMCAP_ue (printf '\e[0m')        # reset underline

# editor
set -x EDITOR nvim
set -x SUDO_EDITOR 'nvim -R'

# aliases
alias ll='ls -alF'
alias cp='cp -i'
alias mv='mv -i'
alias rm='rm -i'
alias crontab='crontab -i'
balias vi nvim

if which adb-peco >/dev/null 2>&1
    alias adb adb-peco
end

set -x PATH "$HOME/go/bin" $PATH

# anyenv
set -x PATH  "$HOME/.anyenv/bin" $PATH
anyenv init - fish | grep -v '..env rehash' | source

# Git templates
if test -d ~/.gittemplates
    set -x GIT_TEMPLATE_DIR "$HOME/.gittemplates"
end

# zoxide
if which zoxide >/dev/null 2>&1
    zoxide init fish | source
end

# direnv
if which direnv >/dev/null 2>&1
    eval (direnv hook fish)
end

# thefuck
set -x THEFUCK_OVERRIDDEN_ALIASES 'vi'
