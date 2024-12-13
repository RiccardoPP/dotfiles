#!/bin/bash

setting=$(gsettings get org.gnome.settings-daemon.plugins.color night-light-enabled)

if [[ $setting == "true" ]]; then
  gsettings set org.gnome.settings-daemon.plugins.color night-light-enabled false
else
  gsettings set org.gnome.settings-daemon.plugins.color night-light-enabled true
fi
