# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

if [ -f "${HOME}/.gpg_profile" ]; then
     source "${HOME}/.gpg_profile"
fi

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
#shopt -s globstar

# readline
bind -m vi '"\C-e": emacs-editing-mode'
bind -m emacs '"\e\C-j": vi-editing-mode'
bind -m emacs '"\e\C-m": vi-editing-mode'

stty werase undef
bind '\C-w:unix-filename-rubout'

export PROMPT_SHORT_PATH=${PROMPT_SHORT_PATH-1}
export PROMPT_GIT_STATUS=${PROMPT_GIT_STATUS-1}

function exists() {
    command -v "$1" >/dev/null 2>&1
    return $?
}

function is_git_repo() {
    [ "$PROMPT_GIT_STATUS" = "1" ] || return 1
    exists "git" || return 1
    git rev-parse >/dev/null 2>&1
    return $?
}

function is_git_dubious_repo() {
    exists "git" || return 1
    git rev-parse 2>&1 >/dev/null | grep -q 'fatal: detected dubious ownership'
    return $?
}

function git_branch_name() {
    [ "$PROMPT_GIT_STATUS" = "1" ] || return
    exists "git" || return

    local color='\033[01;91m'
    local branch_name=DUBIOUS
    if ! is_git_dubious_repo; then
        is_git_repo || return
        color='\033[01;93m'
        branch_name=$(git symbolic-ref --short HEAD 2>/dev/null) || \
            branch_name=$(git show-ref --head -s --abbrev | head -n 1 2>/dev/null)
    fi

    echo -en "\001${color}\002"
    echo -en "[$branch_name]"
    echo -e "\001\033[00m\002"
}

function git_status() {
    is_git_repo || return
    exists "git" || return

    local is_git_dir=""
    [ "$(git rev-parse --is-inside-git-dir)" = "true" ] && is_git_dir="g"
    [ "$(git rev-parse --is-bare-repository)" = "true" ] && is_git_dir="b"

    local stashed=""
    local untracked=""
    local dirty=""
    local indexed=""
    local rebase=""
    local merge=""
    local bisect=""
    local conflict=""
    local upstream=""
    git rev-parse --verify --quiet refs/stash >/dev/null 2>&1 && stashed='$'
    if [ -z "$is_git_dir" ]; then
        git ls-files --others --exclude-standard --directory --no-empty-directory --error-unmatch -- ':/*' >/dev/null 2>&1 && untracked='?'
        git diff --no-ext-diff --quiet 2>/dev/null || dirty="!"
    fi
    git diff --no-ext-diff --cached --quiet || indexed="+"

    local lr=$(git rev-list --count --left-right "@{upstream}...HEAD" 2> /dev/null)
    case "$lr" in
        "" ) ;;
        0$'\t'0 ) ;;
        0$'\t'* ) upstream='>' ;;  # ahead
        *$'\t'0 ) upstream='<' ;;  # behind
        * ) upstream='><' ;;       # diverged
    esac

    local git_dir="$(git rev-parse --git-dir)"
    [ -d "$git_dir/rebase-merge" -o -d "$git_dir/rebase-apply" ] && rebase="R"
    [ -f "$git_dir/MERGE_HEAD" ] && merge="M"
    [ -f "$git_dir/BISECT_LOG" ] && bisect="B"
    [ "$(git ls-files --unmerged 2>/dev/null)" = "" ] || conflict="C"
    echo "$is_git_dir$stashed$untracked$dirty$indexed$rebase$merge$bisect$conflict$upstream"
}

function colored_pipestatus() {
    local last_status=${PIPESTATUS[@]}
    local color='\033[01;93m'
    [[ "${last_status[@]}" =~ ^0( 0)*$ ]] || color='\033[01;91m'
    echo -en "\001${color}\002"
    echo -en "${last_status[@]}"
    echo -e "\001\033[00m\002"
}

function prompt_pwd() {
    local p=$(dirs +0)
    if [ "$PROMPT_SHORT_PATH" = "1" ]; then
        basename $p
    else
        if [ "$p" = "~" -o "$p" = "/" ]; then
            echo "$p"
        else
            local short_dirname=$(echo "${p%/*}" | sed -E 's@(\.?[^/]{1})[^/]*@\1@g')
            echo "$short_dirname/$(basename $p)"
        fi
    fi
}

function prompt_shell_level() {
    echo -en "\001\033[96m\002"
    if [ -z "$TMUX" ]; then
        [ "$SHLVL" -ge 2 ] && echo -en "${SHLVL}\001\033[92m\002|"
    else
        [ "$SHLVL" -ge 3 ] && echo -en "${SHLVL}\001\033[92m\002|"
    fi
    echo -e "\001\033[00m\002"
}

function prompt_venv() {
    echo "${VENV_PROMPT:+($VENV_PROMPT) }"
}

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color|*-256color) color_prompt=yes;;
esac

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
#force_color_prompt=yes

if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
	# We have color support; assume it's compliant with Ecma-48
	# (ISO/IEC-6429). (Lack of such support is extremely rare, and such
	# a case would tend to support setf rather than setaf.)
	color_prompt=yes
    else
	color_prompt=
    fi
fi

if [ "$color_prompt" = yes ]; then
    PS1='$(prompt_venv)$(colored_pipestatus)${debian_chroot:+($debian_chroot)}\[\033[01;32m\]|$(prompt_shell_level)\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;36m\]$(prompt_pwd)\[\033[00m\]$(git_branch_name)\[\033[01;93m\]$(git_status)\[\033[00m\]\$ '
else
    PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
fi
unset color_prompt force_color_prompt

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
    ;;
*)
    ;;
esac

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    alias dir='dir --color=auto'
    alias vdir='vdir --color=auto'
    alias diff='diff --color=auto'
    alias ip='ip --color'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'

    export LESS_TERMCAP_mb=$'\E[1;31m'     # begin blink
    export LESS_TERMCAP_md=$'\E[1;36m'     # begin bold
    export LESS_TERMCAP_me=$'\E[0m'        # reset bold/blink
    export LESS_TERMCAP_so=$'\E[01;33m'    # begin reverse video
    export LESS_TERMCAP_se=$'\E[0m'        # reset reverse video
    export LESS_TERMCAP_us=$'\E[1;4;32m'   # begin underline
    export LESS_TERMCAP_ue=$'\E[0m'        # reset underline
fi

# colored GCC warnings and errors
#export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

# some more ls aliases
alias ll='ls -alF'
alias lh='ls -alFh'
alias la='ls -A'
alias l='ls -lF'

# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi

if [ -f /usr/share/bash-completion/completions/ssh ]; then
    . /usr/share/bash-completion/completions/ssh
    complete -F _ssh sshg
fi

if [ -f /usr/share/doc/find-the-command/ftc.bash ]; then
    source /usr/share/doc/find-the-command/ftc.bash
fi

alias sudo='sudo '
alias cp='cp -i --reflink=auto'
alias mv='mv -i'
alias rm='rm -i'
alias crontab='crontab -i'

# Nix
if exists nix; then
    export __ETC_PROFILE_NIX_SOURCED=1
fi
if exists nix || exists nix-portable; then
    if [ -r /usr/lib/locale/locale-archive ]; then
        export LOCALE_ARCHIVE=/usr/lib/locale/locale-archive
    fi
    if [ -f ~/.nix-profile/etc/profile.d/hm-session-vars.sh ]; then
        source ~/.nix-profile/etc/profile.d/hm-session-vars.sh
    fi
fi

# asdf
if [ -d ~/.asdf ]; then
    if ! exists asdf; then
        . ~/.asdf/asdf.sh
    fi
    if ! exists _asdf; then
        . ~/.asdf/completions/asdf.bash
    fi
elif [ -d ~/.anyenv ]; then
    if ! exists anyenv; then
        export PATH="$HOME/.anyenv/bin:$PATH"
        eval "$(anyenv init - bash | grep -v '..env rehash')"
    fi
fi

if [ -d "$HOME/.rye/shims" ] && ! exists rye; then
    export PATH="$HOME/.rye/shims:$PATH"
fi

# editor
if exists "nvim"; then
    alias vi='nvim'
    export EDITOR=nvim
    export SUDO_EDITOR='nvim -R'
elif exists "vim"; then
    alias vi='vim'
    export EDITOR=vim
    export SUDO_EDITOR='vim -R'
fi

# Git templates
if [ -d ~/.config/git/templates ]; then
    export GIT_TEMPLATE_DIR="$HOME/.config/git/templates"
fi

# ghq
fzf-ghq() {
    local repo=$(ghq list | fzf --preview "ghq list --full-path --exact {} | xargs eza --color=always -h --long --icons --classify -a -I .git --git --no-permissions --no-user --no-filesize --git-ignore --sort modified --reverse --tree --level 2")
    if [ -n "$repo" ]; then
        repo=$(ghq list --full-path --exact $repo)
        cd ${repo}
    fi
}

if exists "ghq" && exists "eza"; then
    bind -x '"\201": fzf-ghq'
    bind '"\C-]": "\201\C-m"'
fi

if exists "eza"; then
    alias es='eza --icons'
    alias ee='eza --icons -aalgF'
    alias el='eza --icons -aalgF'
    alias eb='eza --icons -aalgBF'
    alias ea='eza --icons -algF'
    alias e='eza --icons -lgF'
fi

if exists "aichat"; then
    _aichat_bash() {
        if [[ -n "$READLINE_LINE" ]]; then
            READLINE_LINE=$(aichat -e "$READLINE_LINE")
            READLINE_POINT=${#READLINE_LINE}
        fi
    }
    bind -x '"\er": _aichat_bash'
fi

CACHE_DIR=${HOME}/.cache/bash

if exists "zoxide"; then
    if [[ ! -r "${CACHE_DIR}/zoxide.bash" ]]; then
        mkdir -p ${CACHE_DIR}
        zoxide init bash > ${CACHE_DIR}/zoxide.bash
    fi
    source ${CACHE_DIR}/zoxide.bash
fi

if exists "direnv"; then
    if [[ ! -r "${CACHE_DIR}/direnv.bash" ]]; then
        mkdir -p ${CACHE_DIR}
        direnv hook bash > ${CACHE_DIR}/direnv.bash
    fi
    source ${CACHE_DIR}/direnv.bash
fi

if exists "thefuck"; then
    if [[ ! -r "${CACHE_DIR}/thefuck.bash" ]]; then
    mkdir -p ${CACHE_DIR}
        thefuck --alias > ${CACHE_DIR}/thefuck.bash
    fi
    source ${CACHE_DIR}/thefuck.bash
fi

function bash_update_caches() {
    mkdir -p ${CACHE_DIR}
    if exists "zoxide"; then
        zoxide init bash > ${CACHE_DIR}/zoxide.bash
    fi

    if exists "direnv"; then
        direnv hook bash > ${CACHE_DIR}/direnv.bash
    fi

    if exists "thefuck"; then
        thefuck --alias > ${CACHE_DIR}/thefuck.bash
    fi
}

# usage: "while :;do funniki;done"
funniki(){ echo -en "\e[1;32m";for((i=0;i<$COLUMNS/2;i++));do r=$(($RANDOM&3));test $r == 0&&echo -n "  "||echo -n $(($r&1))" ";done;echo -e "\e[m";}
:
