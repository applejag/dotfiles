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

CACHE_DIR="${HOME}/.cache/pactl-set-volume"
LAST_NOTI_ID_PATH="${CACHE_DIR}/last_noti_id"
LAST_NOTI_ID=0
if [[ -r "$LAST_NOTI_ID_PATH" ]]; then
    LAST_NOTI_ID="$(cat "$LAST_NOTI_ID_PATH")"
fi

VOLUME_ICON=''
URGENCY="normal"
if [[ "$NEW" -le 15 ]]; then
    VOLUME_ICON=''
elif [[ "$NEW" -le 60 ]]; then
    VOLUME_ICON=''
elif [[ "$NEW" -gt 100 ]]; then
    URGENCY="critical"
fi

NEW_NOTI_ID="$(notify-send \
    "$VOLUME_ICON Volume $NEW%" \
    --urgency="$URGENCY" \
    --app-name="$(basename "$0")" \
    --expire-time=5000 \
    --hint=int:value:"$NEW" \
    --replace-id="$LAST_NOTI_ID" \
    --print-id)"

mkdir -p "$CACHE_DIR"
if [[ -w "$CACHE_DIR" ]]; then
    echo "$NEW_NOTI_ID" > "$LAST_NOTI_ID_PATH"
fi
