#!/bin/sh
# Riccardo Palombo - https://riccardo.im
# Preparato per la community Patreon: patreon.com/riccardopalombo
# Fa girare lo script ogni 10 minuti (senza cron o simili)

while :
do
	~/scripts/checklevels.sh
    sleep 600
done
