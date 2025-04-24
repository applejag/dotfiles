#!/usr/bin/env bash

wpctl set-volume @DEFAULT_AUDIO_SINK@ "$@" \
&& pw-play ~/dotfiles/audio/sharp-pop-328170.mp3&
