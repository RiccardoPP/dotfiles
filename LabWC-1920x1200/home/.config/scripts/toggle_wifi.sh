#!/bin/sh

if [ $(nmcli radio wifi | awk '/led/ {print}') = 'enabled'  ] ; then
  nmcli radio wifi off && notify-send "Wifi off"
else
  nmcli radio wifi on && notify-send "Wifi on"
fi
