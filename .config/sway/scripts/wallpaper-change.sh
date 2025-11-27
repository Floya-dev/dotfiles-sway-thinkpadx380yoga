#!/bin/bash
# Made by: Floya
c=~/.config/sway/wallpaper-state/current
f=~/Pictures/Wallpapers/
waypaper --folder $f --state-file $c
i=$(cat $c | grep '^wallpaper' | cut -d '=' -f2 | tr -d ' ')
eval_i=$(eval echo $i)
notify-send -i $eval_i "Wallpaper changed!"
