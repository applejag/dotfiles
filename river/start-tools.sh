#!/bin/sh

start_once() {
    if ! pgrep -u "$USER" -x "$1" > /dev/null
    then
        exec "$@" &
        bg
    fi
}

start_once swaybg --image ~/Pictures/Wallpaper/1561845449-201900764-abstraction-nevseoboi.com.ua.jpg
