#!/bin/bash

ssid=$(iwgetid | cut -c 18-)

if [[ $(iwgetid | wc -c) -eq 0 ]]
then
	echo "OFFLINE"
else
	echo 
fi
