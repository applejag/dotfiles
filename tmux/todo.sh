#!/bin/bash

TODO_COUNT=$(todo --flat | wc -l)
if [ $TODO_COUNT = 0 ]; then
    printf '📝 -'
else
    printf '📝 %i' $TODO_COUNT
fi
