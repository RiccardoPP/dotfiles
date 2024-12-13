#!/usr/bin/env bash

pid=$(pgrep gammastep)

if [[ $1 = "toggle" ]]; then
	if pgrep -x "gammastep" > /dev/null; then
		kill -9 $(pgrep -x "gammastep");
	else
		gammastep -O 5800  2>/dev/null &
	fi
fi

if pgrep -x "gammastep" > /dev/null; then
	echo ""
else
	echo ""
fi
