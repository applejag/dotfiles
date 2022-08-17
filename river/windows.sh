#!/bin/sh

# This file contains settings/exceptions on a per-app/window basis

# Make certain views start floating
riverctl float-filter-add app-id float

# Set app-ids and titles of views which should use client side decorations
riverctl csd-filter-add app-id "gedit"
