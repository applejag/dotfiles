#!/usr/bin/env bash

if [[ -r .envrc ]]
then
    if command -v bat &> /dev/null; then
        bat .envrc --decorations always --style numbers,header --language bash
    else
        cat .envrc
        echo -e "\e[2m(From file ./.envrc)" >&2
    fi
fi

exit 0
