#!/usr/bin/env bash
# Usage: ./install.sh [--no-bak]
# --no-bak erases the ${PWD} directory backup, if it exists as a directory.
CURRTS=`date +%s`;
if [ ! -d ${PWD}/backups/$USER ]; then
    mkdir -p ${PWD}/backups/$USER;
fi;
BACKDIR=${PWD}/backups/$USER/$CURRTS;
mkdir ${BACKDIR};
for d in _*;
do
    orig="${HOME}/${d/_/.}"
    if [ -f ${orig} ]; then
        cp -v ${orig} ${BACKDIR};
    fi;
    if [ -d ${orig} ]; then
        mv -v ${orig} ${BACKDIR};
    fi;
done;
for i in _*;
do 
    source="${PWD}/$i"
    target="${HOME}/${i/_/.}"
    if [ ! -L $target ]; then
        ln -fivs ${source} ${target};
    fi;
done;
echo "bin/ directory's contents: ";
ls ${PWD}/bin
echo "Install the bin/ directory contents to $HOME/bin (y/n)?: "
read -n 1 doinstbin
if [ "$doinstbin" == "y" ]; then
    for b in `ls {$PWD}/bin/`;
    do
        cp -v ${PWD}/bin/$b $HOME/bin/;
    done;
fi;
if [ "$1" == "--no-bak" ]; then
    rm -ir ${BACKDIR}
fi;
