# profile
if test -f $HOME/.profile
    bass source $HOME/.profile
end

if test -f $HOME/.gpg_profile
    bass source $HOME/.gpg_profile
end

# snap
if test -f /etc/profile.d/apps-bin-path.sh
    bass source /etc/profile.d/apps-bin-path.sh
end

# appearance
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

function exists
    which $argv[1] >/dev/null 2>&1
    return $status
end

# aliases
alias ll='ls -alF'
alias lh='ls -alFh'
alias la='ls -A'
alias l='ls -lF'
alias cp='cp -i --reflink=auto'
alias mv='mv -i'
alias rm='rm -i'
alias crontab='crontab -i'

# asdf
if test -d ~/.asdf
    source ~/.asdf/asdf.fish
else if test -d ~/.anyenv
    set -x PATH  "$HOME/.anyenv/bin" $PATH
    anyenv init - fish | grep -v '..env rehash' | source
end

# editor
if exists nvim
    balias vi nvim
    set -x EDITOR nvim
    set -x SUDO_EDITOR 'nvim -R'
else if exists vim
    balias vi vim
    set -x EDITOR vim
    set -x SUDO_EDITOR 'vim -R'
end

# Git templates
if test -d ~/.config/git/templates
    set -x GIT_TEMPLATE_DIR "$HOME/.config/git/templates"
end

if exists exa
    alias el='exa --icons -aalFg'
    alias eb='exa --icons -aalFgB'
    alias ea='exa --icons -alFg'
    alias e='exa --icons -lFg'
end

if exists adb-peco
    alias adb adb-peco
end

if exists zoxide
    zoxide init fish | source
end

if exists direnv
    eval (direnv hook fish)
end

# thefuck
set -x THEFUCK_OVERRIDDEN_ALIASES 'vi'
