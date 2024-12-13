#!/usr/bin/env bash
focused=$(xprop -root _NET_ACTIVE_WINDOW | awk -F' ' '{print $NF}')
if xprop -id "${focused}" I3_FLOATING_WINDOW | grep -q "not found"; then
    i3 "floating enable, border pixel 10, resize set 2785 1630, move absolute position center"
else
    i3 "floating disable, border pixel"
fi
