#!/bin/bash

CACHE_DIR='~/.local/share/namnsdag'
CACHE_NAME_FILE='~/.local/share/namnsdag/cached_name.txt'
CACHE_DATE_FILE='~/.local/share/namnsdag/cached_date.txt'

fetch_names() {
    echo -e "\e[90m\e[3mFetching namnes from https://www.dagensnamn.nu/\e[0m" >&2
    curl -sL 'http://www.dagensnamn.nu/' \
	| grep '<div class="today mt-0 mb-2"' \
	| grep -oP '<h1>\K[^<]+(?=</h1>)'
}

get_or_fetch_names() {
    TODAYS_DATE="$(date '+%F')"

    if [ -f "$CACHE_DATE_FILE" ] \
	&& [ -f "$CACHE_NAME_FILE" ]; then
	LATEST_DATE="$(cat "$CACHE_DATE_FILE")"
	if [ "$LATEST_DATE" == "$TODAYS_DATE" ]; then
	    cat "$CACHE_NAME_FILE"
	    return
	fi
    fi

    mkdir -p "$CACHE_DIR"
    NAMES="$(fetch_names | tee "$CACHE_NAME_FILE")"
    printf '%s' "$TODAYS_DATE" > "$CACHE_DATE_FILE"
}

NAMES="$(get_or_fetch_names)"

echo -e "\e[90m=== \e[33mToday's names: $NAMES\e[0m"
