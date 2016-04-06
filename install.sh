#!/bin/bash

shopt -s dotglob extglob nullglob

if [[ $0 == /* ]]; then
    location=${0%/*}
else
    location=$PWD/${0#./}
    location=${location%/*}
fi

excludes='+(readme.md|install.sh|.git|.git/*|*/.git|.gitignore|.gitmodules)'

for file in $location/*
do
    bare="${file#$location/}"

    case "$bare" in $excludes)
        continue ;;
    esac

    echo "Linking "$bare
    ln -s "$file" "$HOME/${file##*/}"
done
