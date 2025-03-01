#!/usr/bin/env bash

host="${1:?Missing required arg}"
icon="${2:?Missing required arg}"

shift 2
extraArgs=("$@")

echo "<b>$icon</b> <span foreground='gray'><i>loading…</i></span>"

export GH_HOST="$host"
echo "Using host: $GH_HOST" >&2
GH_USER="$(yq ".[\"$GH_HOST\"].user" ~/.config/gh/hosts.yml)"
echo "Using user: $GH_USER" >&2

if ! PRS_TO_REVIEW="$(gh search prs --review-requested "$GH_USER" --state open --review required --archived=false --draft=false --json id --template '{{len .}}' "${extraArgs[@]}")"; then
	echo -n "<b>$icon</b>  "
	echo "<span foreground='red'>failed to load</span>"
	exit 0
fi

PRS_TO_MERGE="$(gh search prs --author "$GH_USER" --state open --review approved --archived=false --draft=false --json id --template '{{len .}}' "${extraArgs[@]}")"
PRS_TO_CHANGE="$(gh search prs --author "$GH_USER" --state open --review changes_requested --archived=false --draft=false --json id --template '{{len .}}' "${extraArgs[@]}")"

echo -n "<b>$icon</b>  "

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
