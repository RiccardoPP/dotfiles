#!/usr/bin/env ash

options="Shutdown\nReboot\nSuspend\nExit"

# Run Fuzzel and capture selection
selection=$(echo -e "$options" | fuzzel --dmenu --config=.config/fuzzel/fuzzel-power.ini --hide-prompt)

# Systemd based
# case $selection in
#     *Shutdown) systemctl poweroff -i ;;
#     *Reboot) systemctl reboot -i ;;
#     *Exit) hyprctl dispatch exit exit ;; 
#     *Suspend) systemctl suspend ;;
#     *"UEFI Setup") systemctl reboot --firmware-setup ;;
# esac

# Alpine Linux
case $selection in
    *Shutdown) sudo poweroff -i ;;
    *Reboot) sudo reboot -i ;;
    *Suspend) sudo zzz ;; # apk add zzz
    *Exit) labwc --exit ;; 
esac
