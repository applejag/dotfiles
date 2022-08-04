#!/usr/bin/env bash

if [[ -z "$1" ]]; then
    cat <<EOF
Usage: $0 <num>

Example:
  $0 +10
  $0 -10
EOF
    exit 1
fi

DIFF="$1"
CURRENT="$(pactl get-sink-volume @DEFAULT_SINK@ | grep -o '[0-9]*%' -m 1 | head -n 1 | grep -o '[0-9]*')"
NEW=$((CURRENT + DIFF))

if [[ "$NEW" -gt 150 ]]; then
    echo "Max reached, using 150% instead of $NEW%"
    NEW=150
elif [[ "$NEW" -lt 0 ]]; then
    echo "Min reached, using 0% instead of $NEW%"
    NEW=0
fi

pactl set-sink-volume @DEFAULT_SINK@ "$NEW%"
