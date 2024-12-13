#!/bin/sh
#
# Riccardo Palombo - https://riccardo.im
# Preparato per la community Patreon: patreon.com/riccardopalombo

# entries="[←] Logout\n[↑] Suspend\n[→] Reboot\n[↓] Shutdown"
# selected=$(echo -e $entries|rofi -dmenu -i -theme power-blue -p  | awk '{print tolower($2)}')

# case $selected in
  # logout)
    # hyprctl dispatch exit exit;;
  # suspend)
    # exec systemctl suspend;;
  # reboot)
    # exec systemctl reboot;;
  # shutdown)
    # exec systemctl poweroff -i;;
# esac

case $(printf "%s\n" "Logout" "Reboot" "Suspend" "Shutdown" | tofi -c ~/.config/tofi/config_power $@) in
	"Logout")
		labwc --exit
		;;
	"Reboot")
		sudo reboot -i
		;;
	"Suspend")
		sudo zzz
		;;
	"Shutdown")
		sudo poweroff -i
		;;
esac
