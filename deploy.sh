#!/bin/sh

set -u
DOT_ROOT="${HOME}/dotfiles"
FISH_FUNCTIONS="${HOME}/.config/fish/functions"

cd ${DOT_ROOT}

# link dotfiles
for f in .??*; do
    # to ignore
    [ "$f" = ".git" ] && continue
    [ "$f" = ".config" ] && continue
    ln -snfv ${DOT_ROOT}/${f} ${HOME}/${f}
done

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

