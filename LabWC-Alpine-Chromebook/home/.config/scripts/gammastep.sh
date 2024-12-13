#!/usr/bin/env bash

pid=$(pgrep gammastep)

if [[ $1 = "toggle" ]]; then
	if pgrep -x "gammastep" > /dev/null; then
		kill -9 $(pgrep -x "gammastep");
	else
		gammastep -O 5600  2>/dev/null &
	fi
fi

if pgrep -x "gammastep" > /dev/null; then
	echo "5600K"
else
	echo "6500K"
fi
