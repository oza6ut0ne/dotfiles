#!/bin/sh

set -u
DOT_ROOT="${HOME}/dotfiles"

cd ${DOT_ROOT}

# link dotfiles
for f in .??*
do
    # to ignore
    [ "$f" = ".git" ] && continue
    [ "$f" = ".config" ] && continue
    ln -snfv ${DOT_ROOT}/${f} ${HOME}/${f}
done

# neovim
ln -snfv ${DOT_ROOT}/.vim ${HOME}/.config/nvim

