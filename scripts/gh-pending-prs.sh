#!/usr/bin/env bash

host="${1:?Missing required arg}"
icon="${2:?Missing required arg}"

shift 2
extraArgs=("$@")
export GH_HOST="$host"

# Catppuccin macchiato
C_RED="#ed8796"
C_GRAY="#b8c0e0"
C_ORANGE="#f5a97f"
C_GREEN="#a6da95"

function fetch() {
	echo "Using host: $GH_HOST" >&2
	GH_USER="$(yq ".[\"$GH_HOST\"].user" ~/.config/gh/hosts.yml)"
	echo "Using user: $GH_USER" >&2

	if ! PRS_TO_REVIEW="$(gh search prs --review-requested "$GH_USER" --state open --review required --archived=false --draft=false --json id --template '{{len .}}' "${extraArgs[@]}")"; then
		echo -n "<b>$icon</b>  "
		echo "<span foreground='$C_RED'>failed to load</span>"

		echo "Waiting until host can be resolved" >&2
		while ! curl -sS --connect-timeout 2s "$GH_HOST" >/dev/null 2>/dev/null; do
			echo -n "<b>$icon</b>  "
			echo "<span foreground='$C_GRAY'>waiting</span>"
			sleep 5s
		done
		echo "Host resolved successfully. Retrying search..." >&2
		if ! PRS_TO_REVIEW="$(gh search prs --review-requested "$GH_USER" --state open --review required --archived=false --draft=false --json id --template '{{len .}}' "${extraArgs[@]}")"; then
			return 0
		fi
	fi

	PRS_TO_MERGE="$(gh search prs --author "$GH_USER" --state open --review approved --archived=false --draft=false --json id --template '{{len .}}' "${extraArgs[@]}")"
	PRS_TO_CHANGE="$(gh search prs --author "$GH_USER" --state open --review changes_requested --archived=false --draft=false --json id --template '{{len .}}' "${extraArgs[@]}")"

	echo -n "<b>$icon</b>  "

	if [[ "$PRS_TO_REVIEW" == 0 ]]; then
		echo -n "<span foreground='$C_GRAY'> $PRS_TO_REVIEW</span>"
	else
		echo -n "<span foreground='$C_ORANGE'> $PRS_TO_REVIEW</span>"
	fi

	echo -n " "

	if [[ "$PRS_TO_MERGE" == 0 ]]; then
		echo -n "<span foreground='$C_GRAY'> $PRS_TO_MERGE</span>"
	else
		echo -n "<span foreground='$C_GREEN'> $PRS_TO_MERGE</span>"
	fi

	echo -n " "

	if [[ "$PRS_TO_CHANGE" == 0 ]]; then
		echo -n "<span foreground='$C_GRAY'> $PRS_TO_CHANGE</span>"
	else
		echo -n "<span foreground='$C_RED'> $PRS_TO_CHANGE</span>"
	fi

	echo
}

echo "<b>$icon</b> <span foreground='$C_GRAY'><i>loading…</i></span>"

while true; do
	fetch
	sleep 5m
done
