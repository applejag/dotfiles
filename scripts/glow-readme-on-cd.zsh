#!/usr/bin/env zsh

setopt extendedglob
for FILE in (#i)readme.(markdown|md)
do
    if [[ -f "$FILE" || -r "$FILE" ]]; then
        PAGER=cat glow "$FILE"
        echo "(From file ./$FILE)"
        break
    fi
done

exit 0
