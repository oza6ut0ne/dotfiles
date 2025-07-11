#!/bin/sh

set -u
DOT_ROOT="${HOME}/dotfiles"
BIN="${HOME}/bin"
CONFIG_ROOT="${HOME}/.config"
FISH_CONFD="${CONFIG_ROOT}/fish/conf.d"
FISH_FUNCTIONS="${CONFIG_ROOT}/fish/functions"
ZSH_CONFD="${CONFIG_ROOT}/zsh/conf.d"
ZSH_FUNCTIONS="${CONFIG_ROOT}/zsh/functions"
GIT_CONFIG="${CONFIG_ROOT}/git"
DIRENV_CONFIG="${CONFIG_ROOT}/direnv"
VIMSPECTOR_ROOT="${CONFIG_ROOT}/vimspector"
VIMSPECTOR_CONFIG_ROOT="${VIMSPECTOR_ROOT}/configurations"
LIBSKK_RULES="${CONFIG_ROOT}/libskk/rules"
MPV_CONFIG="${CONFIG_ROOT}/mpv"
ALACRITTY_CONFIG="${CONFIG_ROOT}/alacritty"
WEZTERM_CONFIG="${CONFIG_ROOT}/wezterm"

cd ${DOT_ROOT}

# link dotfiles
for f in .??*; do
    # to ignore
    [ "$f" = ".git" ] && continue
    [ "$f" = ".gitignore" ] && continue
    [ "$f" = ".config" ] && continue
    ln -snfv ${DOT_ROOT}/${f} ${HOME}/${f}
done

# ~/bin
if [ ! -e ${BIN} ]; then
    mkdir -p ${BIN}
fi
for f in `ls ${DOT_ROOT}/bin`; do
    ln -snfv ${DOT_ROOT}/bin/${f} ${BIN}/${f}
done

# create ~/.config
if [ ! -e ${CONFIG_ROOT} ]; then
    mkdir -p ${CONFIG_ROOT}
fi

# neovim
ln -snfv ${DOT_ROOT}/.vim ${HOME}/.config/nvim

# fish
if [ ! -e ${FISH_CONFD} ]; then
    mkdir -p ${FISH_CONFD}
fi
if [ ! -e ${FISH_FUNCTIONS} ]; then
    mkdir -p ${FISH_FUNCTIONS}
fi
ln -snfv ${DOT_ROOT}/.config/fish/config.fish ${HOME}/.config/fish/config.fish
for f in `ls ${DOT_ROOT}/.config/fish/conf.d`; do
    ln -snfv ${DOT_ROOT}/.config/fish/conf.d/${f} ${FISH_CONFD}/${f}
done
for f in `ls ${DOT_ROOT}/.config/fish/functions`; do
    ln -snfv ${DOT_ROOT}/.config/fish/functions/${f} ${FISH_FUNCTIONS}/${f}
done

# zsh
if [ ! -e ${ZSH_CONFD} ]; then
    mkdir -p ${ZSH_CONFD}
fi
if [ ! -e ${ZSH_FUNCTIONS} ]; then
    mkdir -p ${ZSH_FUNCTIONS}
fi
cd ${DOT_ROOT}/.config/zsh
for f in .??*; do
    ln -snfv ${DOT_ROOT}/.config/zsh/${f} ${HOME}/.config/zsh/${f}
done
cd -
for f in `ls ${DOT_ROOT}/.config/zsh/conf.d`; do
    ln -snfv ${DOT_ROOT}/.config/zsh/conf.d/${f} ${ZSH_CONFD}/${f}
done
for f in `ls ${DOT_ROOT}/.config/zsh/functions`; do
    ln -snfv ${DOT_ROOT}/.config/zsh/functions/${f} ${ZSH_FUNCTIONS}/${f}
done

# Git
if [ ! -e ${GIT_CONFIG} ]; then
    mkdir -p ${GIT_CONFIG}
fi
for f in `ls ${DOT_ROOT}/.config/git`; do
    ln -snfv ${DOT_ROOT}/.config/git/${f} ${GIT_CONFIG}/${f}
done

# Direnv
if [ ! -e ${DIRENV_CONFIG} ]; then
    mkdir -p ${DIRENV_CONFIG}
fi
ln -snfv ${DOT_ROOT}/.config/direnv/direnvrc ${DIRENV_CONFIG}/direnvrc

# vimspector
if [ ! -e ${VIMSPECTOR_ROOT} ]; then
    mkdir -p ${VIMSPECTOR_ROOT}
fi
if [ ! -L ${VIMSPECTOR_CONFIG_ROOT} ] && [ -e ${VIMSPECTOR_CONFIG_ROOT} ]; then
    rm -rf ${VIMSPECTOR_CONFIG_ROOT}
fi
ln -snfv ${DOT_ROOT}/.config/vimspector/configurations ${VIMSPECTOR_CONFIG_ROOT}

# libskk
if [ ! -e ${LIBSKK_RULES} ]; then
    mkdir -p ${LIBSKK_RULES}
fi
for f in `ls ${DOT_ROOT}/.config/libskk/rules`; do
    ln -snfv ${DOT_ROOT}/.config/libskk/rules/${f} ${LIBSKK_RULES}/${f}
done

# mpv
if [ ! -e ${MPV_CONFIG} ]; then
    mkdir -p ${MPV_CONFIG}
fi
for f in `ls ${DOT_ROOT}/.config/mpv`; do
    ln -snfv ${DOT_ROOT}/.config/mpv/${f} ${MPV_CONFIG}/${f}
done

# alacritty
if [ ! -e ${ALACRITTY_CONFIG} ]; then
    mkdir -p ${ALACRITTY_CONFIG}
fi
for f in `ls ${DOT_ROOT}/.config/alacritty`; do
    ln -snfv ${DOT_ROOT}/.config/alacritty/${f} ${ALACRITTY_CONFIG}/${f}
done

# WezTerm
if [ ! -e ${WEZTERM_CONFIG} ]; then
    mkdir -p ${WEZTERM_CONFIG}
fi
for f in `ls ${DOT_ROOT}/.config/wezterm`; do
    ln -snfv ${DOT_ROOT}/.config/wezterm/${f} ${WEZTERM_CONFIG}/${f}
done
