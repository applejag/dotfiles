#!/usr/bin/env zsh

setopt extendedglob
setopt +o nomatch
for FILE in (#i)readme.(markdown|md)
do
    if [[ -f "$FILE" || -r "$FILE" ]]; then
        PAGER=cat glow "$FILE" --width=0 >&2
        echo -e "\e[2m(From file ./$FILE)" >&2
        exit 0
    fi
done
for FILE in (#i)readme(|.txt)
do
    if [[ -f "$FILE" || -r "$FILE" ]]; then
        cat "$FILE" >&2
        echo -e "\e[2m(From file ./$FILE)" >&2
        exit 0
    fi
done

exit 0
