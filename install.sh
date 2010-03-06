#!/usr/bin/env bash
# Usage: ./install.sh [--no-bak]
# --no-bak erases the .vim/ directory backup, if it exists as a directory.

if [ -d ${HOME}/.vim/ ]; then
    mv ${HOME}/.vim $HOME/.vim.bak;
fi;
for i in _*
do 
    source="${PWD}/$i"
    target="${HOME}/${i/_/.}"
    ln -fivs ${source} ${target}
done
if [ "$1" = "--no-bak" ]; then
    rm -ir ${HOME}/.vim.bak
fi;
