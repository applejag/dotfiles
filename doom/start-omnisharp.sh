#!/usr/bin/env bash

omnisharp_cmd="$HOME/.emacs.d/.local/etc/omnisharp/server/v1.37.1/omnisharp/OmniSharp.exe"
mono_cmd=mono
no_omnisharp=false

if [ "$1" = "--no-omnisharp" ]; then
    shift
    no_omnisharp=true
fi

if [ "$no_omnisharp" = true ]; then
    exec "${mono_cmd}" "$@"
else
    exec "${mono_cmd}" "${omnisharp_cmd}" "$@"
fi
