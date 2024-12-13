#!/bin/bashlight
# Riccardo Palombo - https://riccardo.im
# Preparato per la community Patreon: patreon.com/riccardopalombo
# Da modificare con i dati della propria batteria

POWERSUPPLY="/sys/class/power_supply/BAT0/status" 
LOW=20
TOO_LOW=10
NOT_CHARGING="Discharging"

export DISPLAY=:0

BATTERY_LEVEL=$(cat /sys/class/power_supply/BAT0/capacity)
STATUS=$(cat $POWERSUPPLY)

if [ $BATTERY_LEVEL -le $LOW -a $STATUS = $NOT_CHARGING ]
then ~/scripts/noti -b
elif [ $BATTERY_LEVEL -le $TOO_LOW -a $STATUS = $NOT_CHARGING ] 
then pkill picom & xbacklight -set 20 & ~/scripts/noti -c
fi

exit 0
