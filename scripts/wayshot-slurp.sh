#!/usr/bin/env bash

set -euo pipefail

pretty_path() {
    echo "${1/$HOME/"~"}"
}

screenshot() {
    FILENAME="$HOME/Pictures/Screenshots/$(date +wayshot_%F_%H.%M.%S.png)"
    wayshot "$@" --stdout \
        | tee "$FILENAME" \
        | wl-copy >&2
    echo "$FILENAME"
}

screenshot_region() {
    local SLURP SLURP_POS SLURP_OUTPUT
    SLURP="$(slurp -f '%x %y %w %h %o')"
    SLURP_POS="$(echo "$SLURP" | cut -d' ' -f1-4)"
    SLURP_OUTPUT="$(echo "$SLURP" | cut -d' ' -f5)"
    FILENAME="$(screenshot --slurp "$SLURP_POS" --output "$SLURP_OUTPUT")"
    notify-send -a wayshot 'Screenshotted region' "Copied to clipboard and saved at $(pretty_path "$FILENAME")" -t 8000
}

screenshot_fullscreen() {
    FILENAME="$(screenshot --slurp "$SLURP_POS" --output "$SLURP_OUTPUT")"
    notify-send -a wayshot 'Screenshotted full screen' "Copied to clipboard and saved at $(pretty_path "$FILENAME")" -t 8000
}

usage() {
    echo "Usage: $(pretty_path "$0") <region|fullscreen>" >&2
    exit 1
}

if [[ $# == 0 ]]; then
    usage
fi

case "$1" in
    region)
        screenshot_region
        ;;
    fullscreen)
        screenshot_fullscreen
        ;;
    *)
        usage
        ;;
esac
