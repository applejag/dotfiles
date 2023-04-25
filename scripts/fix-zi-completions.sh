#!/usr/bin/env bash

set -xeuo pipefail
find ~/.zi/completions -xtype l -exec rm -v '{}' \;
