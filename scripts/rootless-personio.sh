#!/usr/bin/env bash

# Usages:
#
# . ~/dotfiles/scripts/rootless-personio.sh attendance calendar

if [[ -z "$PERSONIO_AUTH_PASSWORD" ]]; then
	export PERSONIO_AUTH_PASSWORD="$(op item get 5lbnb6twtbpgyrr7ccmz6gm4ai --fields label=password)"
fi
rootless-personio "$@"
