#!/bin/sh
#
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

case $(printf "%s\n" "Logout" "Reboot" "Suspend" "Shutdown" | tofi -c ~/.config/tofi/config_power_bottom $@) in
	"Logout")
		labwc --exit
		;;
	"Reboot")
		exec systemctl reboot
		;;
	"Suspend")
		exec systemctl suspend
		;;
	"Shutdown")
		exec systemctl poweroff
		;;
esac
