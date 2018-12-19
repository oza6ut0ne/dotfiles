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

if is_ubuntu; then
    ${SUDO} apt install -y software-properties-common
fi
if exists "apt"; then
    ${SUDO} apt update
fi

if ! exists "git"; then
    if exists "apt"; then
        ${SUDO} apt install -y git
    fi
fi

if [ ! -d ~/dotfiles ]; then
    git clone https://github.com/oza6ut0ne/dotfiles.git ~/dotfiles
fi

cd ~/dotfiles
./deploy.sh

if ! exists "direnv"; then
    if exists "apt"; then
        ${SUDO} apt install -y direnv
    fi
fi

if [ ! -d ~/.fzf ]; then
    git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
    ~/.fzf/install --bin
fi

if ! exists "nvim"; then
    if is_ubuntu; then
        ${SUDO} apt-add-repository ppa:neovim-ppa/stable -y
        ${SUDO} apt update
    fi
    if exists "apt"; then
        ${SUDO} apt install -y neovim
    fi
fi

if [ ! -d ~/.pyenv ]; then
    if exists "apt"; then
        ${SUDO} apt install -y make build-essential llvm clang gcc
        ${SUDO} apt install -y zlib1g-dev libbz2-dev 
        ${SUDO} apt install -y libssl-dev libffi-dev openssl
        ${SUDO} apt install -y ibreadline-dev libsqlite3-dev
        ${SUDO} apt install -y libncurses5-dev libncursesw5-dev xz-utils tk-dev
    fi

    git clone https://github.com/yyuu/pyenv.git ~/.pyenv
    git clone git://github.com/yyuu/pyenv-virtualenv.git ~/.pyenv/plugins/pyenv-virtualenv
    source ~/.bashrc
fi

if ! pyenv versions | grep neovim-3 >/dev/null 2>&1; then
    PY3_NEWEST="$(pyenv install -l | grep --color=never -E '^ *3\.[0-9]+\.[0-9]+$' | tail -n 1)"
    pyenv install ${PY3_NEWEST}
    pyenv rehash
    pyenv virtualenv ${PY3_NEWEST} neovim-3
    pyenv shell neovim-3
    pip install neovim
    pyenv shell --unset
fi

if ! pyenv versions | grep neovim-2 >/dev/null 2>&1; then
    PY2_NEWEST="$(pyenv install -l | grep --color=never -E '^ *2\.[0-9]+\.[0-9]+$' | tail -n 1)"
    pyenv install ${PY2_NEWEST}
    pyenv rehash
    pyenv virtualenv ${PY2_NEWEST} neovim-2
    pyenv shell neovim-2
    pip install neovim
    pyenv shell --unset
fi

if [ ! -d ~/.anyenv ]; then
    git clone https://github.com/riywo/anyenv ~/.anyenv
    # source ~/.bashrc
    eval "$(~/.anyenv/bin/anyenv init -)"
fi

if ! ~/.anyenv/bin/anyenv envs | grep goenv >/dev/null 2>&1; then
    ~/.anyenv/bin/anyenv install goenv
    if [ ! -d ~/go ]; then
        mkdir ~/go
    fi
    if [ ! -d ~/go/bin ]; then
        mkdir ~/go/bin
    fi
    # source ~/.bashrc
    ~/.anyenv/envs/goenv rehash
fi

if ! exists "fish"; then
    if is_ubuntu; then
        ${SUDO} apt-add-repository ppa:fish-shell/release-2 -y
        ${SUDO} apt update
    fi
    if exists "apt"; then
        ${SUDO} apt install -y fish
    fi
    curl -L http://get.oh-my.fish | fish
    curl -Lo ~/.config/fish/functions/fisher.fish --create-dirs https://git.io/fisher
    fish -c 'fisher add jethrokuan/z jethrokuan/fzf jorgebucaran/fish-spin edc/bass oh-my-fish/plugin-balias oh-my-fish/plugin-extract'
    chsh -s "$(which fish)"
fi

