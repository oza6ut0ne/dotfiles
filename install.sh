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

if [ ! -d ~/.anyenv ]; then
    git clone https://github.com/riywo/anyenv ~/.anyenv
    source ~/.bashrc
    yes | anyenv install --init
    mkdir -p $(anyenv root)/plugins
    git clone https://github.com/znz/anyenv-update.git $(anyenv root)/plugins/anyenv-update
fi

if ! anyenv envs | grep goenv >/dev/null 2>&1; then
    ${SUDO} apt install -y golang
    if [ ! -d ~/go ]; then
        mkdir ~/go
    fi
    if [ ! -d ~/go/bin ]; then
        mkdir ~/go/bin
    fi
    anyenv install goenv
    source ~/.bashrc
    go get github.com/motemen/ghq
    go get -u github.com/github/hub
    go get -u github.com/kyoshidajp/ghkw
    go get -u github.com/jingweno/ccat

    goenv rehash
    GO_NEWEST="$(goenv install -l | grep --color=never -E '^ *[0-9]+\.[0-9]+\.[0-9]+$' | tail -n 1)"
    goenv install ${GO_NEWEST}
fi

if ! anyenv envs | grep pyenv >/dev/null 2>&1; then
    if exists "apt"; then
        ${SUDO} apt install -y make build-essential llvm clang gcc
        ${SUDO} apt install -y zlib1g-dev libbz2-dev 
        ${SUDO} apt install -y libssl-dev libffi-dev openssl
        ${SUDO} apt install -y libreadline-dev libsqlite3-dev
        ${SUDO} apt install -y libncurses5-dev libncursesw5-dev xz-utils tk-dev
    fi

    anyenv install pyenv
    source ~/.bashrc
    git clone git://github.com/yyuu/pyenv-virtualenv.git $(pyenv root)/plugins/pyenv-virtualenv
    git clone git://github.com/pyenv/pyenv-which-ext.git $(pyenv root)/plugins/pyenv-which-ext
fi

if ! pyenv versions | grep neovim-3 >/dev/null 2>&1; then
    PY3_NEWEST="$(pyenv install -l | grep --color=never -E '^ *3\.[0-9]+\.[0-9]+$' | tail -n 1)"
    pyenv install ${PY3_NEWEST}
    pyenv rehash
    pyenv virtualenv ${PY3_NEWEST} neovim-3
    pyenv shell neovim-3
    pip install pynvim
    pyenv shell --unset
fi

if ! pyenv versions | grep neovim-2 >/dev/null 2>&1; then
    PY2_NEWEST="$(pyenv install -l | grep --color=never -E '^ *2\.[0-9]+\.[0-9]+$' | tail -n 1)"
    pyenv install ${PY2_NEWEST}
    pyenv rehash
    pyenv virtualenv ${PY2_NEWEST} neovim-2
    pyenv shell neovim-2
    pip install pynvim
    pyenv shell --unset
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

