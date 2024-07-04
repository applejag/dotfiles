#!/usr/bin/env bash

# Usages:
#
# . ~/dotfiles/scripts/rootless-personio-env.sh
#
# rootless-personio attendance calendar -s 2024-07-01
#
# dinkur ls -r all -s '2024-07-01T00:00:00Z' -o json \
#  | jq '.[] | .comment=.name | del(.id, .createdAt, .updatedAt, .name)' \
#  | rootless-personio attendance set -f -

if [[ -z "$PERSONIO_AUTH_PASSWORD" ]]; then
	export PERSONIO_AUTH_PASSWORD="$(op item get 5lbnb6twtbpgyrr7ccmz6gm4ai --fields label=password)"
	if [[ -z "$PERSONIO_AUTH_PASSWORD" ]]; then
		echo "Could not obtain PERSONIO_AUTH_PASSWORD from 1Password CLI"
		exit 1
	fi
	echo "Env var PERSONIO_AUTH_PASSWORD has been set"
else
	echo "Env var PERSONIO_AUTH_PASSWORD was already set"
fi
