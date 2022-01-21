# Dinkur the task time tracking utility.
# <https://github.com/dinkur/dinkur>
#
# SPDX-FileCopyrightText: 2021 Kalle Fagerberg
# SPDX-License-Identifier: CC0-1.0

.PHONY: install clean tidy deps

ifeq ($(OS),Windows_NT)
dinkur-gnome-raujonas-executor.exe:
else
dinkur-gnome-raujonas-executor:
endif
	go1.18beta1 build

install:
	go1.18beta1 install

clean:
	rm -rfv ./dinkur-gnome-raujonas-executor.exe ./dinkur-gnome-raujonas-executor

tidy:
	go1.18beta1 mod tidy

deps:
	go1.18beta1 get
