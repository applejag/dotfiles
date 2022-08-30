#!/bin/bash

set -eo pipefail

for attr in brightness max_brightness; do
    sudo chgrp -vR backlighters /sys/class/backlight/*/$attr
    sudo chmod -v g+w /sys/class/backlight/*/$attr
done
