#!/bin/bash

function exists() {
    which "$1" >/dev/null 2>&1
    return $?
}

function is_ubuntu() {
    [ ! -d /etc/lsb-release ]
    return $?
}

if exists "sudo"; then
    SUDO="sudo"
else
    SUDO=""
fi

if exists "apt"; then
    ${SUDO} apt update
fi
if is_ubuntu; then
    ${SUDO} apt install -y software-properties-common
    ${SUDO} apt update
fi

if ! exists "git" && exists "apt"; then
    ${SUDO} apt install -y git
fi

if ! exists "curl" && exists "apt"; then
    ${SUDO} apt install -y curl
fi

if [ ! -d ~/dotfiles ]; then
    git clone https://github.com/oza6ut0ne/dotfiles.git ~/dotfiles
fi

cd ~/dotfiles
./deploy.sh

if [ ! -d ~/.asdf ]; then
    git clone https://github.com/asdf-vm/asdf.git ~/.asdf
    . ~/.asdf/asdf.sh
    asdf update

    mkdir -p ~/.config/fish/completions
    ln -s ~/.asdf/completions/asdf.fish ~/.config/fish/completions
fi

if ! exists "nvim"; then
    if is_ubuntu; then
        ${SUDO} apt-add-repository ppa:neovim-ppa/unstable -y
        ${SUDO} apt update
    fi
    if exists "apt"; then
        ${SUDO} apt install -y neovim
    fi
fi

if ! exists "direnv"; then
    asdf plugin-add direnv
    asdf install direnv latest
    asdf global direnv latest
fi

if ! exists "fzf"; then
    asdf plugin-add fzf
    asdf install fzf latest
    asdf global fzf latest
fi

if ! exists "zoxide"; then
    asdf plugin-add zoxide
    asdf install zoxide latest
    asdf global zoxide latest
fi
if ! exists "hub" && exists "apt"; then
    ${SUDO} apt install -y hub
fi

if is_ubuntu; then
    ${SUDO} apt install -y python3 python3-pip
    /usr/bin/python3 -m pip install --user pynvim
fi

if ! asdf list | grep -q python; then
    if exists "apt"; then
        ${SUDO} apt install -y make build-essential llvm curl wget
        ${SUDO} apt install -y libssl-dev zlib1g-dev libbz2-dev
        ${SUDO} apt install -y libreadline-dev libsqlite3-dev
        ${SUDO} apt install -y libncursesw5-dev xz-utils tk-dev libffi-dev
        ${SUDO} apt install -y libxml2-dev libxmlsec1-dev liblzma-dev
    fi

    asdf plugin-add python
    asdf install python latest
    asdf global python latest
fi

if ! exists "zsh"; then
    if exists "apt"; then
        ${SUDO} apt install -y zsh
    fi
    chsh -s "$(which zsh)"
fi

if ! exists "fish"; then
    if is_ubuntu; then
        ${SUDO} apt-add-repository ppa:fish-shell/release-3 -y
        ${SUDO} apt update
    fi
    if exists "apt"; then
        ${SUDO} apt install -y fish
    fi
    curl -L http://get.oh-my.fish | fish
    curl -Lo ~/.config/fish/functions/fisher.fish --create-dirs https://git.io/fisher
    fish -c 'fisher install jethrokuan/fzf jorgebucaran/fish-spin edc/bass oh-my-fish/plugin-balias oh-my-fish/plugin-extract'
fi
