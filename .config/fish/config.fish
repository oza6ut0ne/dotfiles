# profile
if test -f $HOME/.profile; and not set -q __PROFILE_SOURCED
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
set -q PROMPT_SHORT_PATH || set -x PROMPT_SHORT_PATH 1
set -q PROMPT_GIT_STATUS || set -x PROMPT_GIT_STATUS 1

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
alias sudop='sudo --preserve-env=PATH'
alias ll='ls -alF'
alias lh='ls -alFh'
alias la='ls -A'
alias l='ls -lF'
alias cp='cp -i --reflink=auto'
alias mv='mv -i'
alias rm='rm -i'
alias crontab='crontab -i'

if test -r /usr/share/doc/find-the-command/ftc.fish
    source /usr/share/doc/find-the-command/ftc.fish
end

if test -r ~/.config/fish/functions/sudo_preserve_alias.fish
    source ~/.config/fish/functions/sudo_preserve_alias.fish
end

# Nix
if exists nix
    set -x __ETC_PROFILE_NIX_SOURCE 1
end
if exists nix; or exists nix-portable
    if test -r /usr/lib/locale/locale-archive
        set -x LOCALE_ARCHIVE /usr/lib/locale/locale-archive
    end
    if test -f ~/.nix-profile/etc/profile.d/hm-session-vars.sh
        bass source ~/.nix-profile/etc/profile.d/hm-session-vars.sh
    end
end

# asdf
if test -d ~/.asdf;
    if not exists asdf
        source ~/.asdf/asdf.fish
    end
else if test -d ~/.anyenv
    if not exists anyenv
        set -x PATH "$HOME/.anyenv/bin" $PATH
        anyenv init - fish | grep -v '..env rehash' | source
    end
end

if test -d "$HOME/.rye/shims"; and not exists rye
    set -x PATH "$HOME/.rye/shims" $PATH
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

complete -c sshg -w ssh

if exists eza
    alias es='eza --icons'
    alias ee='eza --icons -aalgF'
    alias el='eza --icons -aalgF'
    alias eb='eza --icons -aalgBF'
    alias ea='eza --icons -algF'
    alias e='eza --icons -lgF'
end

if exists adb-peco
    alias adb adb-peco
end

set CACHE_DIR "$HOME/.cache/fish"

if exists zoxide
    if test ! -r "$CACHE_DIR/zoxide.fish"
        mkdir -p $CACHE_DIR
        zoxide init fish > "$CACHE_DIR/zoxide.fish"
    end
    source "$CACHE_DIR/zoxide.fish"
end

if exists direnv
    if test ! -r "$CACHE_DIR/direnv.fish"
        mkdir -p $CACHE_DIR
        direnv hook fish > "$CACHE_DIR/direnv.fish"
    end
    source "$CACHE_DIR/direnv.fish"
end

function fish_update_caches
    mkdir -p $CACHE_DIR
    if exists zoxide
        zoxide init fish > "$CACHE_DIR/zoxide.fish"
    end

    if exists direnv
        direnv hook fish > "$CACHE_DIR/direnv.fish"
    end
end

# thefuck
set -x THEFUCK_OVERRIDDEN_ALIASES 'vi'
