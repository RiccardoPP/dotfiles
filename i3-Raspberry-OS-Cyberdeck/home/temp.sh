#!/bin/bash
# Script: my-pi-temp.sh
# Purpose: Display the ARM CPU and GPU  temperature of Raspberry Pi 2/3 
# Author: Vivek Gite <www.cyberciti.biz> under GPL v2.x+
# -------------------------------------------------------
cpu=$(</sys/class/thermal/thermal_zone0/temp)
echo "$(date)"
echo "-------------------------------------------"
echo "GPU → $(vcgencmd measure_temp | egrep  -o  '[[:digit:]].*')"
echo "CPU → $((cpu/1000))'C"
echo "-------------------------------------------"
