#!/usr/bin/env bash

GH_USER="kalle-fagerberg"
export GH_HOST="github.2rioffice.com"

PRS_TO_REVIEW="$(gh search prs --review-requested "$GH_USER" --state open --review required --json id --template '{{len .}}')"
PRS_TO_MERGE="$(gh search prs --author "$GH_USER" --state open --review approved --json id --template '{{len .}}')"
PRS_TO_CHANGE="$(gh search prs --author "$GH_USER" --state open --review changes_requested --json id --template '{{len .}}')"

echo -n "<b>[GitHub]</b> "

if [[ "$PRS_TO_REVIEW" == 0 ]]; then
	echo -n "<span foreground='gray'>review: $PRS_TO_REVIEW</span>"
else
	echo -n "<span foreground='orange'>review: $PRS_TO_REVIEW</span>"
fi

echo -n " | "

if [[ "$PRS_TO_MERGE" == 0 ]]; then
	echo -n "<span foreground='gray'>merge: $PRS_TO_MERGE</span>"
else
	echo -n "<span foreground='green'>merge: $PRS_TO_MERGE</span>"
fi

echo -n " | "

if [[ "$PRS_TO_CHANGE" == 0 ]]; then
	echo -n "<span foreground='gray'>change: $PRS_TO_CHANGE</span>"
else
	echo -n "<span foreground='red'>change: $PRS_TO_CHANGE</span>"
fi

echo
