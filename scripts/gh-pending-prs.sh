#!/usr/bin/env bash

export GH_HOST="github.2rioffice.com"
GH_USER="$(yq ".[\"$GH_HOST\"].user" ~/.config/gh/hosts.yml)"
echo "Using user: $GH_USER" >&2

if ! PRS_TO_REVIEW="$(gh search prs --review-requested "$GH_USER" --state open --review required --archived=false --draft=false --json id --template '{{len .}}')"; then
	echo -n "<b></b>  "
	echo -n "<span foreground='red'>failed to load</span>"
	exit 0
fi

PRS_TO_MERGE="$(gh search prs --author "$GH_USER" --state open --review approved --archived=false --draft=false --json id --template '{{len .}}')"
PRS_TO_CHANGE="$(gh search prs --author "$GH_USER" --state open --review changes_requested --archived=false --draft=false --json id --template '{{len .}}')"

echo -n "<b></b>  "

if [[ "$PRS_TO_REVIEW" == 0 ]]; then
	echo -n "<span foreground='gray'> $PRS_TO_REVIEW</span>"
else
	echo -n "<span foreground='orange'> $PRS_TO_REVIEW</span>"
fi

echo -n " "

if [[ "$PRS_TO_MERGE" == 0 ]]; then
	echo -n "<span foreground='gray'> $PRS_TO_MERGE</span>"
else
	echo -n "<span foreground='green'> $PRS_TO_MERGE</span>"
fi

echo -n " "

if [[ "$PRS_TO_CHANGE" == 0 ]]; then
	echo -n "<span foreground='gray'> $PRS_TO_CHANGE</span>"
else
	echo -n "<span foreground='red'> $PRS_TO_CHANGE</span>"
fi

echo
