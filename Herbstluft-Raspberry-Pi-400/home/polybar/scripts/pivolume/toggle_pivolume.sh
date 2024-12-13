#!/bin/bash

if [ $(amixer | grep -w "on" | wc -c) -eq 0 ]
then
	$(amixer set PCM unmute)
else
	$(amixer set PCM mute)
fi
