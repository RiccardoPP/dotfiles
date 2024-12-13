#!/bin/bash

envFile=~/.config/polybar/scripts/env.sh
changeValue=300

changeMode() {
  sed -i "s/REDSHIFT=$1/REDSHIFT=$2/g" $envFile 
  REDSHIFT=$2
  echo $REDSHIFT
}

case $1 in 
  toggle) 
    if [ "$REDSHIFT" = on ];
    then
      changeMode "$REDSHIFT" off
      redshift -x
    else
      changeMode "$REDSHIFT" on
      redshift -O "$REDSHIFT_TEMP"
    fi
    ;;
  temperature)
    case $REDSHIFT in
      on)
        printf ""
        ;;
      off)
        printf ""
        ;;
    esac
    ;;
esac
