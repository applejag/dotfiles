#!/usr/bin/env zsh

setopt extendedglob
setopt +o nomatch
for FILE in (#i)readme.(markdown|md)
do
    if [[ -f "$FILE" || -r "$FILE" ]]; then
        PAGER=cat glow "$FILE" >&2
        echo -e "\e[2m(From file ./$FILE)" >&2
        break
    fi
done

exit 0
