#!/bin/sh

exec_once() {
    if ! pgrep -u "$USER" -x "$1" > /dev/null
    then
        echo "$0: No '$1' found, starting it."
        exec "$@" &
    fi
}

exec_once swaybg --image ~/Pictures/Wallpaper/1561845449-201900764-abstraction-nevseoboi.com.ua.jpg

exec_once swayidle -w \
    timeout 300 'wlopm --off "*"' \
    timeout 310 'swaylock -f' \
    resume 'wlopm --on "*"' \
    before-sleep 'swaylock -f'

LC_TIME=sv_SE.utf8 exec_once waybar

exec_once playerctld

exec_once fnott

exec_once mpDris2

exec_once ~/dotfiles/scripts/way-displays-river.sh

exec_once nm-applet

exec_once emacs --daemon

exec_once 1password --silent

exec_once nwg-drawer -r
