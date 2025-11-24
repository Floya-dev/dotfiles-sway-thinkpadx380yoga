#!/bin/bash

# Night light script for sway using wlsunset
DEFAULT_VALUE=5000

function OnOff {
  if pgrep -x "wlsunset" > /dev/null
  then
        pkill wlsunset > /dev/null 2>&1
        notify-send -i video-display -a "Night Light" -t 2000 -r 7854 "Status: off"  
  else
    wlsunset  -T ${DEFAULT_VALUE} -t $((DEFAULT_VALUE - 1))  > /dev/null 2>&1 &
        notify-send -i video-display -a "Night Light" -t 2000 -r 7854 "Status: on (${DEFAULT_VALUE}K)"  
  fi
}

function CustomLight {
  VALUE=$(seq -3000 500 8000 | fuzzel --dmenu -f "BigBlueTerm437 Nerd Font Mono" -l 11 -a center --counter --placeholder "Night Light")
  if [[ -z "$VALUE" ]]; then
    exit 0
  fi
  PIDID=$(pidof wlsunset)
  wlsunset  -T ${VALUE} -t $((VALUE - 1)) > /dev/null 2>&1 &
  kill -9 ${PIDID} > /dev/null 2>&1
  notify-send -i video-display -a "Night Light" -t 2000 -r 7854 "Status: custom (${VALUE}K)"  
}

case $1 in
  onf)
    OnOff
    ;;
  custom)
    CustomLight
    ;;
esac
