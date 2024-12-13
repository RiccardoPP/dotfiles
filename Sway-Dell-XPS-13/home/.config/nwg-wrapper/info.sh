#!/usr/bin/env bash
#
#
echo '<span>'
time=$(date +"%I:%M %P")
date=$(date +"%a, %d %b")
echo $time 
echo $date
echo ''
bat=$(cat /sys/class/power_supply/BAT0/capacity)
echo 'Batteria: '$bat'%'
vol=$(amixer -D pulse get Master | awk -F 'Left:|[][]' 'BEGIN {RS=""}{ print $3 }')
echo 'Volume: '$vol
screen=$(light | cut -f1 -d'.')
echo 'Luminosità: '$screen'%'
echo '</span>'
