# zmodload zsh/zprof && zprof

if [[ "${ZDOTDIR#*'devbox'}" != "$ZDOTDIR" ]]; then
    source ${HOME}/.zshenv
fi

ZSH_DIR=${ZDOTDIR:-${HOME}/.zsh}

function source {
    ensure_zcompiled $1
    builtin source $@
}

function ensure_zcompiled {
    local compiled="$1.zwc"
    if [[ $1 == ${HOME}/* && ! -r "$compiled" || "$1" -nt "$compiled" ]]; then
        echo "\033[1;36mCompiling\033[m $1"
        zcompile $1
    fi
}
ensure_zcompiled ${ZSH_DIR}/.zshrc

if [ -f ${HOME}/.gpg_profile ]; then
    source ${HOME}/.gpg_profile
fi

bindkey -e
bindkey \^U backward-kill-line

HISTFILE=${HOME}/.local/share/zsh/.zsh_history
HISTSIZE=20000
SAVEHIST=20000

setopt HIST_IGNORE_DUPS
setopt HIST_IGNORE_ALL_DUPS
setopt HIST_IGNORE_SPACE
setopt HIST_FIND_NO_DUPS
setopt HIST_REDUCE_BLANKS
setopt HIST_NO_STORE
setopt HIST_VERIFY
setopt SHARE_HISTORY

setopt prompt_subst
setopt AUTO_CD
setopt AUTO_PUSHD
setopt PUSHD_TO_HOME
setopt PUSHD_IGNORE_DUPS

autoload -Uz is-at-least && if is-at-least 5.8; then
    setopt CD_SILENT
fi

setopt LONG_LIST_JOBS
setopt NO_BG_NICE
setopt INTERACTIVE_COMMENTS
setopt CORRECT

zmodload zsh/parameter

WORDCHARS=${WORDCHARS//[\/#]}

export PROMPT_ONELINE=${PROMPT_ONELINE-1}
export PROMPT_SHORT_PATH=${PROMPT_SHORT_PATH-1}
export PROMPT_GIT_STATUS=${PROMPT_GIT_STATUS-1}

if [[ -S /dev/incus/sock ]] || [[ -S /dev/lxd/sock ]]; then
    if [[ -f /dev/.lxc-boot-id ]]; then
        export PROMPT_HOST_LABEL=${PROMPT_HOST_LABEL-C}
    else
        export PROMPT_HOST_LABEL=${PROMPT_HOST_LABEL-VM}
    fi
else
    export PROMPT_HOST_LABEL=${PROMPT_HOST_LABEL-}
fi

function zsh_update_completions() {
    compinit -d ${HOME}/.cache/zsh/.zcompdump
}

function exists() {
    which "$1" >/dev/null 2>&1
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

    local color='%{\e[01;91m%}'
    local branch_name=DUBIOUS
    if ! is_git_dubious_repo; then
        is_git_repo || return
        color='%{\e[01;93m%}'
        branch_name=$(git symbolic-ref --short HEAD 2>/dev/null) || \
            branch_name=$(git show-ref --head -s --abbrev | head -n 1 2>/dev/null)
    fi

    echo -en "${color}"
    echo -en "[$branch_name]"
    echo -e "%{\e[00m%}"
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
    local last_status="${pipestatus[@]}"
    local color='%{\e[01;93m%}'
    [[ "${last_status[@]}" =~ ^0( 0)*$ ]] || color='%{\e[01;91m%}'
    echo -en "${color}"
    echo -en "${last_status[@]}"
    echo -e "%{\e[00m%}"
}

function prompt_pwd() {
    local p=${${PWD:/~/\~}/#~\//\~/}
    if [ "$PROMPT_SHORT_PATH" = "1" ]; then
        basename $p
    else
        echo "${(@j[/]M)${(@s[/]M)p##*/}##(.|)?}$p:t"
    fi
}

function prompt_jobs() {
    local num_jobs="${#jobstates[@]}"
    if [ "$num_jobs" -gt 0 ]; then
        echo "%{\e[38;2;214;172;255m%}${num_jobs}%{\e[92m%}|%{\e[00m%}"
    fi
}

function prompt_shell_level() {
    if [ -z "$TMUX" ]; then
        [ "$SHLVL" -ge 2 ] && echo "%{\e[38;2;164;255;255m%}${SHLVL}%{\e[92m%}|%{\e[00m%}"
    else
        [ "$SHLVL" -ge 3 ] && echo "%{\e[38;2;164;255;255m%}${SHLVL}%{\e[92m%}|%{\e[00m%}"
    fi
}

function prompt_host_label() {
    echo -en "%{\e[01;91m%}"
    echo -n "${PROMPT_HOST_LABEL:+<$PROMPT_HOST_LABEL>}"
    echo -e "%{\e[00m%}"
}

function prompt_venv() {
    echo "${VENV_PROMPT:+($VENV_PROMPT) }"
}

function prompt_newline_hook() {
    if [ "$PROMPT_ONELINE" = "1" ]; then
        prompt_newline=""
    else
        prompt_newline=$'\n'
        echo
    fi
}

function prompt() {
  case "$1" in
    oneline) [[ -v 2 ]] && PROMPT_ONELINE="$2"    || echo $PROMPT_ONELINE;;
    short)   [[ -v 2 ]] && PROMPT_SHORT_PATH="$2" || echo $PROMPT_SHORT_PATH;;
    git)     [[ -v 2 ]] && PROMPT_GIT_STATUS="$2" || echo $PROMPT_GIT_STATUS;;
    label)   [[ -v 2 ]] && PROMPT_HOST_LABEL="$2" || echo $PROMPT_HOST_LABEL;;
    venv)    [[ -v 2 ]] && VENV_PROMPT="$2"       || echo $VENV_PROMPT;;
    starship) eval "$(starship init zsh)";;
    *) echo "Usage: prompt { oneline | short | git | label | venv } [value]"
       echo "       prompt starship"
       ;;
  esac
}

precmd_functions+=(prompt_newline_hook)

PS1=$'$(prompt_venv)$(colored_pipestatus)%B%{\e[92m%}|$(prompt_jobs)%B$(prompt_shell_level)%B%{\e[92m%}%n@%m$(prompt_host_label)%{\e[0m%}:%B%{\e[96m%}$(prompt_pwd)$(git_branch_name)%{\e[93m%}$(git_status)%{\e[0m%}$prompt_newline%(!.#.$) '
RPS1=$'${duration_info}%F{7}%D{%H:%M:%S}%f'
ZLE_RPROMPT_INDENT=0

_prompt_executing=""
function __prompt_osc133_precmd() {
    local ret="$?"
    if test "$_prompt_executing" != "0"
    then
      _PROMPT_SAVE_PS1="$PS1"
      _PROMPT_SAVE_PS2="$PS2"
      PS1=$'%{\e]133;P;k=i\a%}'$PS1$'%{\e]133;B\a\e]122;> \a%}'
      PS2=$'%{\e]133;P;k=s\a%}'$PS2$'%{\e]133;B\a%}'
    fi
    if test "$_prompt_executing" != ""
    then
       printf "\033]133;D;%s;aid=%s\007" "$ret" "$$"
    fi
    printf "\033]133;A;cl=m;aid=%s\007" "$$"
    _prompt_executing=0
}
function __prompt_osc133_preexec() {
    PS1="$_PROMPT_SAVE_PS1"
    PS2="$_PROMPT_SAVE_PS2"
    printf "\033]133;C;\007"
    _prompt_executing=1
}
preexec_functions+=(__prompt_osc133_preexec)
precmd_functions+=(__prompt_osc133_precmd)

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

# aliases
alias sudo='sudo '
alias sudop='sudo --preserve-env=PATH '
alias ll='ls -alF'
alias lh='ls -alFh'
alias la='ls -A'
alias l='ls -lF'
alias cp='cp -i --reflink=auto'
alias mv='mv -i'
alias rm='rm -i'
alias crontab='crontab -i'

autoload -Uz edit-command-line
zle -N edit-command-line
bindkey '^[e' edit-command-line

if [[ -e /etc/zsh_command_not_found ]] then
    source /etc/zsh_command_not_found
fi

if [[ -e /usr/share/doc/find-the-command/ftc.bash ]] then
    builtin source /usr/share/doc/find-the-command/ftc.bash variant=zsh
fi

# functions
if [ -d ${ZSH_DIR}/functions ]; then
    fpath=(${ZSH_DIR}/functions $fpath)
fi

# completions
if [ -d ${ZSH_DIR}/completion ]; then
    fpath=(${ZSH_DIR}/completion $fpath)
fi

zstyle ':completion:*:processes' command "ps aux"
zstyle ':completion:*:*:docker:*' option-stacking yes
zstyle ':completion:*:*:docker-*:*' option-stacking yes

# Nix
if exists nix; then
    export __ETC_PROFILE_NIX_SOURCED=1
fi
if exists nix || exists nix-portable; then
    if [ -r /usr/lib/locale/locale-archive ]; then
        export LOCALE_ARCHIVE=/usr/lib/locale/locale-archive
    fi
    if [[ ! "$PATH" == *"$HOME/.nix-profile/bin"* ]]; then
        export PATH="$HOME/.nix-profile/bin:$PATH"
    fi
    if [ -f ~/.nix-profile/etc/profile.d/hm-session-vars.sh ]; then
        builtin source ~/.nix-profile/etc/profile.d/hm-session-vars.sh
    fi
    if [ -d /nix/var/nix/profiles/default/share/zsh/site-functions ]; then
        fpath=(/nix/var/nix/profiles/default/share/zsh/site-functions $fpath)
    fi
    if [ -d ~/.nix-profile/share/zsh/site-functions ]; then
        fpath=( ~/.nix-profile/share/zsh/site-functions $fpath)
    fi
fi

# asdf
if [ -d ~/.asdf ]; then
    if ! exists asdf; then
        . ~/.asdf/asdf.sh
    fi
    if ! exists _asdf; then
        fpath=(${ASDF_DIR}/completions $fpath)
    fi
elif [ -d ~/.anyenv ]; then
    if ! exists anyenv; then
        export PATH="$HOME/.anyenv/bin:$PATH"
        eval "$(anyenv init - zsh | grep -v '..env rehash')"
    fi
fi

if [ -d "$HOME/.rye/shims" ] && ! exists rye; then
    export PATH="$HOME/.rye/shims:$PATH"
fi

# editor
if exists "nvim"; then
    alias vi='nvim'
    export EDITOR="${EDITOR-nvim}"
    export SUDO_EDITOR="${SUDO_EDITOR-nvim -R}"
elif exists "vim"; then
    alias vi='vim'
    export EDITOR="${EDITOR-vim}"
    export SUDO_EDITOR="${SUDO_EDITOR-vim -R}"
fi

# Git templates
if [ -d ~/.config/git/templates ]; then
    export GIT_TEMPLATE_DIR="${GIT_TEMPLATE_DIR-$HOME/.config/git/templates}"
fi

# additional configurations
for f in `ls -v ${ZSH_DIR}/conf.d/*.zsh`; do
    source ${f}
done

# Zim
zstyle ':zim:input' double-dot-expand yes
if [[ -e ${ZDOTDIR:-${HOME}}/.zimrc ]]; then
  zstyle ':zim:zmodule' use 'degit'

  ZIM_HOME=${HOME}/.local/share/zsh/zim

  # Download zimfw plugin manager if missing.
  if [[ ! -e ${ZIM_HOME}/zimfw.zsh ]]; then
    if (( ${+commands[curl]} )); then
      curl -fsSL --create-dirs -o ${ZIM_HOME}/zimfw.zsh \
          https://github.com/zimfw/zimfw/releases/latest/download/zimfw.zsh
    else
      mkdir -p ${ZIM_HOME} && wget -nv -O ${ZIM_HOME}/zimfw.zsh \
          https://github.com/zimfw/zimfw/releases/latest/download/zimfw.zsh
    fi
  fi
  # Install missing modules, and update ${ZIM_HOME}/init.zsh if missing or outdated.
  if [[ ! ${ZIM_HOME}/init.zsh -nt ${ZDOTDIR:-${HOME}}/.zimrc ]]; then
    source ${ZIM_HOME}/zimfw.zsh init -q
  fi
  # Initialize modules.
  source ${ZIM_HOME}/init.zsh
fi

# Plugins
if exists history-substring-search-up && exists history-substring-search-down; then
  zmodload -F zsh/terminfo +p:terminfo
  for key ('^[[A' '^P' ${terminfo[kcuu1]}) bindkey ${key} history-substring-search-up
  for key ('^[[B' '^N' ${terminfo[kcud1]}) bindkey ${key} history-substring-search-down
  for key ('k') bindkey -M vicmd ${key} history-substring-search-up
  for key ('j') bindkey -M vicmd ${key} history-substring-search-down
  unset key
fi

typeset -A ZSH_HIGHLIGHT_STYLES
ZSH_AUTOSUGGEST_MANUAL_REBIND=1
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=#CCC"
ZSH_HIGHLIGHT_HIGHLIGHTERS=(main brackets)
ZSH_HIGHLIGHT_STYLES[arg0]='fg=#0FC'

zmodload -F zsh/datetime +p:EPOCHREALTIME
setopt nopromptbang prompt{cr,percent,sp,subst}
autoload -Uz add-zsh-hook
autoload -Uz duration-info-preexec
autoload -Uz duration-info-precmd
if (( ${+functions[duration-info-preexec]} && \
    ${+functions[duration-info-precmd]} )); then
  zstyle ':zim:duration-info' show-milliseconds yes
  zstyle ':zim:duration-info' threshold 0.000
  zstyle ':zim:duration-info' format ' %B%F{yellow}%d%f%b '
  add-zsh-hook preexec duration-info-preexec
  add-zsh-hook precmd duration-info-precmd
fi

compdef sshg=ssh

# ghq
fzf-ghq() {
    local repo=$(ghq list | fzf --preview "ghq list --full-path --exact {} | xargs eza --color=always -h --long --icons --classify -a -I .git --git --no-permissions --no-user --no-filesize --git-ignore --sort modified --reverse --tree --level 2")
    if [ -n "$repo" ]; then
        repo=$(ghq list --full-path --exact $repo)
        BUFFER="cd ${repo}"
        zle accept-line
    fi
    zle -R -c
}

if exists "ghq" && exists "eza"; then
    zle -N fzf-ghq
    bindkey '^]' fzf-ghq
fi

if exists "eza"; then
    alias es='eza --icons'
    alias ee='eza --icons -aalgF'
    alias el='eza --icons -aalgF'
    alias eb='eza --icons -aalgBF'
    alias ea='eza --icons -algF'
    alias e='eza --icons -lgF'
fi

CACHE_DIR=${HOME}/.cache/zsh

if exists "fzf"; then
    if [[ ! -r "${CACHE_DIR}/fzf.zsh" ]]; then
        mkdir -p ${CACHE_DIR}
        fzf --zsh > ${CACHE_DIR}/fzf.zsh
    fi
    source ${CACHE_DIR}/fzf.zsh
fi

if exists "zoxide"; then
    if [[ ! -r "${CACHE_DIR}/zoxide.zsh" ]]; then
        mkdir -p ${CACHE_DIR}
        zoxide init zsh > ${CACHE_DIR}/zoxide.zsh
    fi
    source ${CACHE_DIR}/zoxide.zsh
fi

if exists "direnv"; then
    if [[ ! -r "${CACHE_DIR}/direnv.zsh" ]]; then
        mkdir -p ${CACHE_DIR}
        direnv hook zsh > ${CACHE_DIR}/direnv.zsh
    fi
    source ${CACHE_DIR}/direnv.zsh
fi

if exists "thefuck"; then
    if [[ ! -r "${CACHE_DIR}/thefuck.zsh" ]]; then
    mkdir -p ${CACHE_DIR}
        thefuck --alias > ${CACHE_DIR}/thefuck.zsh
    fi
    source ${CACHE_DIR}/thefuck.zsh
fi

function zsh_update_caches() {
    mkdir -p ${CACHE_DIR}
    if exists "zoxide"; then
        zoxide init zsh > ${CACHE_DIR}/zoxide.zsh
    fi

    if exists "direnv"; then
        direnv hook zsh > ${CACHE_DIR}/direnv.zsh
    fi

    if exists "thefuck"; then
        thefuck --alias > ${CACHE_DIR}/thefuck.zsh
    fi
}

unfunction source

if (which zprof > /dev/null 2>&1) ;then
    zprof | cat
fi
