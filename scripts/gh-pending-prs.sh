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
		echo "<font color='$C_RED'>failed to load</font>"

		echo "Waiting until host can be resolved" >&2
		while ! curl -sS --connect-timeout 2s "$GH_HOST" >/dev/null 2>/dev/null; do
			echo -n "<b>$icon</b>  "
			echo "<font color='$C_GRAY'>waiting</font>"
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
		echo -n "<font color='$C_GRAY'> $PRS_TO_REVIEW</font>"
	else
		echo -n "<font color='$C_ORANGE'> $PRS_TO_REVIEW</font>"
	fi

	echo -n " "

	if [[ "$PRS_TO_MERGE" == 0 ]]; then
		echo -n "<font color='$C_GRAY'> $PRS_TO_MERGE</font>"
	else
		echo -n "<font color='$C_GREEN'> $PRS_TO_MERGE</font>"
	fi

	echo -n " "

	if [[ "$PRS_TO_CHANGE" == 0 ]]; then
		echo -n "<font color='$C_GRAY'> $PRS_TO_CHANGE</font>"
	else
		echo -n "<font color='$C_RED'> $PRS_TO_CHANGE</font>"
	fi

	echo
}

echo "<b>$icon</b> <font color='$C_GRAY'><i>loading…</i></font>"

while true; do
	fetch
	sleep 5m
done
