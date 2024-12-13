#!/usr/bin/env bash

icon=""

setting=$(gsettings get org.gnome.settings-daemon.plugins.color night-light-enabled)

if [[ $setting == "true" ]]; then
echo "%{F#F9F9F9s}$icon"
else
echo "%{F#888888}$icon"
fi
