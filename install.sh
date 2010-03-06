#!/usr/bin/env bash
for i in _*
do 
    source="${PWD}/$i"
    target="${HOME}/${i/_/.}"
    echo "${target} already exists"       
    ln -fivs ${source} ${target}
done

