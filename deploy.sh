#!/bin/sh

set -u
DOT_ROOT="${HOME}/dotfiles"
CONFIG_ROOT="${HOME}/.config"
FISH_FUNCTIONS="${HOME}/.config/fish/functions"
VIMSPECTOR_ROOT="${HOME}/.config/vimspector"
VIMSPECTOR_CONFIG_ROOT="${VIMSPECTOR_ROOT}/configurations"
LIBSKK_RULES="${HOME}/.config/libskk/rules"
ALACRITTY_CONFIG="${HOME}/.config/alacritty"

cd ${DOT_ROOT}

# link dotfiles
for f in .??*; do
    # to ignore
    [ "$f" = ".git" ] && continue
    [ "$f" = ".config" ] && continue
    ln -snfv ${DOT_ROOT}/${f} ${HOME}/${f}
done

# create ~/.config
if [ ! -e ${CONFIG_ROOT} ]; then
    mkdir -p ${CONFIG_ROOT}
fi

# neovim
ln -snfv ${DOT_ROOT}/.vim ${HOME}/.config/nvim

# fish
if [ ! -e ${FISH_FUNCTIONS} ]; then
    mkdir -p ${FISH_FUNCTIONS}
fi
ln -snfv ${DOT_ROOT}/.config/fish/config.fish ${HOME}/.config/fish/config.fish
for f in `ls ${DOT_ROOT}/.config/fish/functions`; do
    ln -snfv ${DOT_ROOT}/.config/fish/functions/${f} ${FISH_FUNCTIONS}/${f}
done

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

# alacritty
if [ ! -e ${ALACRITTY_CONFIG} ]; then
    mkdir -p ${ALACRITTY_CONFIG}
fi
for f in `ls ${DOT_ROOT}/.config/alacritty`; do
    ln -snfv ${DOT_ROOT}/.config/alacritty/${f} ${ALACRITTY_CONFIG}/${f}
done
