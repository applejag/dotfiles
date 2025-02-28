#!/usr/bin/env bash

swww img -t any "$(fd -t f . ~/Nextcloud/Photos/wallpaper/simonstalenhag/ | shuf | head -n 1)"
