#!/usr/bin/env bash
# Info sul sistema in stile notifica (chi ha bisogno di una status bar?)
# Riccardo Palombo - https://riccardo.im
# Preparato per la community Patreon: patreon.com/riccardopalombo

nwg-wrapper -s info.sh -c info.css -r 1000 -p right -mr 50 -a start -mt 70 -j right --layer 3 -sq 31 & sleep 3 && pkill -31 nwg-wrapper
