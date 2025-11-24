#!/bin/bash

# Get the current keyboard layout
current_layout=$(swaymsg -t get_inputs | jq -r '.[] | select(.type=="keyboard") | .xkb_active_layout_name'|head -n 1)

# Debugging: Print current layout
echo "Current layout: $current_layout"

if [[ "$current_layout" == "Czech" ]]; then
    swaymsg input type:keyboard xkb_layout us
    bash ~/.config/sway/scripts/notifications.sh h
else
    swaymsg input type:keyboard xkb_layout cz
    bash ~/.config/sway/scripts/notifications.sh h
fi
