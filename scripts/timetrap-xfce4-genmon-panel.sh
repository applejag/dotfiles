#!/usr/bin/env bash

NOW_OUTPUT="$(timetrap now 2>&1)"
DAY_OUTPUT="$(timetrap display all --format day 2>&1)"

PAT='([0-9]+)%'
[[ "$DAY_OUTPUT" =~ $PAT ]]
PERCENTAGE="${BASH_REMATCH[1]}"

PAT='(([0-9]+:)+[0-9]+)'
[[ "$DAY_OUTPUT" =~ $PAT ]]
TIME="${BASH_REMATCH[1]}"

echo "<txt>$NOW_OUTPUT | $TIME </txt><bar>$PERCENTAGE</bar>"
