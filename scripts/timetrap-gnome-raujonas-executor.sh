#!/usr/bin/env bash

# https://stackoverflow.com/a/59592881
{
    IFS=$'\n' read -r -d '' NOW_INACTIVE;
    IFS=$'\n' read -r -d '' NOW_ACTIVE;
} < <((printf '\0%s\0' "$(timetrap now)" 1>&2) 2>&1)

NOW_COLOR='gray'
NOW_OUTPUT="$NOW_INACTIVE"
if [ "$NOW_ACTIVE" ]; then
    NOW_COLOR='lime'
    NOW_OUTPUT="$NOW_ACTIVE"
fi

DAY_OUTPUT="$(timetrap display all --format day 2>&1)"

PAT='([0-9]+)%'
[[ "$DAY_OUTPUT" =~ $PAT ]]
PERCENTAGE="${BASH_REMATCH[1]}"

PAT='(([0-9]+:)+[0-9]+)'
[[ "$DAY_OUTPUT" =~ $PAT ]]
TIME="${BASH_REMATCH[1]}"

echo -n "<executor.markup.true>"
echo -n " <span foreground='$NOW_COLOR'>$NOW_OUTPUT</span>"
echo -n " | <span>$TIME</span>"
echo -n " | <span>$PERCENTAGE%</span>"

# https://github.com/raujonas/executor
