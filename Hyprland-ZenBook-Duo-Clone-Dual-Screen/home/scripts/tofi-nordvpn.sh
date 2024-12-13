#!/usr/bin/env bash
#             __ _                           _
#  _ __ ___  / _(_)      _ __   ___  _ __ __| |_   ___ __  _ __
# | '__/ _ \| |_| |_____| '_ \ / _ \| '__/ _` \ \ / / '_ \| '_ \
# | | | (_) |  _| |_____| | | | (_) | | | (_| |\ V /| |_) | | | |
# |_|  \___/|_| |_|     |_| |_|\___/|_|  \__,_| \_/ | .__/|_| |_|
#                                                   |_|

# exit when any command fails
set -e

echoexit() {
    # Print to stderr and exit
    printf "%s\n" "$@" 1>&2
    exit 1
}

# Checking dependencies:
type nordvpn >/dev/null || echoexit "'nordvpn' not found."
type tofi >/dev/null || echoexit "'tofi' not found."

completion_to_lines() {
    tr '\r\b\t' '\n' | sed '/^[[:space:]]*$/d'
}

menu() {
    # Menu command, should read from stdin and write to stdout.
    local stdin
    local line_count
    stdin="$(cat)"
    line_count="$(printf "%s" "$stdin" | wc -l)"

#    if [ "$line_count" -lt 5 ]; then
        printf "%s" "$stdin" | sort | tofi -c $HOME/.config/tofi/config-power
#    else
#        printf "%s" "$stdin" | sort | tofi -dmenu -i -p "NordVPN" -no-custom
#    fi
}

usage() {
    printf "Dynamic menu interface for nordvpn.

Usage:
  tofi-nordvpn [-h] [-s]
    -h                                 Display this help message.
    -s                                 Display current vpn status, useful for status bars.
"
}

# Initial menu.
init_menu() {
    local choices
    choices="connect\ndisconnect\nstatus\nsettings"
    printf "%b" "$choices" | menu
}

# nordvpn connect menu.
connect() {
    local choices
    choices="default\ncountries\ncities\np2p\nonion"
    printf "%b" "$choices" | menu
}

# Country selection menu.
countries() {
    # script needed to avoid it crashing when called from status bar (https://github.com/loiccoyle/rofi-nordvpn/issues/1)
    script -q -c "nordvpn connect --generate-bash-completion" /dev/null | completion_to_lines | menu
}

# City selection menu.
# Arg:
#   $1: a country
cities() {
    script -q -c "nordvpn connect $1 --generate-bash-completion" /dev/null | completion_to_lines | menu
}

# Print the vpn status, for status bars.
status() {
    local status
    status="$(nordvpn status | tr -d '\r -')"
    if [ -n "${status##*Connected*}" ]; then
        printf "OFF"
    else
        printf "%s" "$(printf "%s" "$status" | grep "City" | cut -d ":" -f 2)"
    fi
}

# Show vpn status menu.
vpn_status() {
    local choices
    choices="$(nordvpn status | tr -d '\r-' | sed 's/^ *//')"
    printf "%s" "$choices" | menu
}

# Show vpn settings.
settings() {
    local choices
    choices="$(nordvpn settings | tr -d '\r-' | sed 's/^ *//')"
    printf "%s" "$choices" | menu
}

# Parse options to the `rofi-nordvpn` command
while getopts ":hs" opt; do
    case ${opt} in
    h)
        usage
        exit 0
        ;;
    s)
        status
        exit 0
        ;;
    \?)
        printf "Invalid Option: -%s\n" "$OPTARG" 1>&2
        usage
        exit 1
        ;;
    esac
done

case "$(init_menu)" in
"connect")
    case $(connect) in
    "default")
        nordvpn connect
        ;;
    "countries")
        country="$(countries)"
        [ -n "$country" ] && nordvpn connect "$country"
        ;;
    "cities")
        country="$(countries)"
        [ -n "$country" ] && city="$(cities "$country")"
        [ -n "$city" ] && nordvpn connect "$country" "$city"
        ;;
    "p2p")
        nordvpn connect p2p
        ;;
    "onion")
        nordvpn connect onion_over_vpn
        ;;
    *) ;;

    esac
    ;;
"disconnect")
    nordvpn disconnect
    ;;
"status")
    vpn_status
    ;;
"settings")
    settings
    ;;
*) ;;

esac
