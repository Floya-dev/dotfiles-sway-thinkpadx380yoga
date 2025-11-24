#!/usr/bin/env bash
# My notifications in sway
# by Skajp
# modified by Floya

# ~/.config/sway/scripts/notifications.sh a // audio volume
# ~/.config/sway/scripts/notifications.sh b // audio mute
# ~/.config/sway/scripts/notifications.sh c // mic mute
# ~/.config/sway/scripts/notifications.sh cc // mic volume
# ~/.config/sway/scripts/notifications.sh d // brightness
# ~/.config/sway/scripts/notifications.sh 0/1 // Conservation Mode
# ~/.config/sway/scripts/notifications.sh h // Keyboard


function audio_volume {
	mute_status=$(pactl get-sink-mute @DEFAULT_SINK@ | awk '{print $2}')
	if [ "$mute_status" = "yes" ]; then
		iconSound="audio-volume-muted"
	else
		iconSound="audio-volume-high"
	fi
    	notify-send -i $iconSound -a "Audio" -r 2593 -u low -t 1000 "Volume: $(pactl get-sink-volume @DEFAULT_SINK@ | awk '{print $5}')"
}

function audio_mute {
	mute_status=$(pactl get-sink-mute @DEFAULT_SINK@ | awk '{print $2}')
	if [ "$mute_status" = "yes" ]; then
		iconMuted="audio-volume-muted"
	else
		iconMuted="audio-volume-high"
	fi
    	notify-send -i $iconMuted -a "Audio" -r 2593 -u low -t 1000 "Muted: $(pactl get-sink-mute @DEFAULT_SINK@ | awk '{print $2}')"
}

function mic_volume {
	micSens=$(pactl get-source-volume @DEFAULT_SOURCE@ | grep "Volume" | awk '{print $5}' | tr -d '%')
	threshold1=$((100 / 3))
	threshold2=$((2 * 100 / 3))

	if [ "$micSens" -le "$threshold1" ]; then
		micMuteIcon="microphone-sensitivity-low"
	elif [ "$micSens" -le "$threshold2" ]; then
		micMuteIcon="microphone-sensitivity-medium"
	else
		micMuteIcon="microphone-sensitivity-high"
	fi
	mute_status=$(pactl get-source-mute @DEFAULT_SOURCE@ | awk '{print $2}')
	if [ "$mute_status" = "yes" ]; then
		micMute="microphone-sensitivity-muted"
	else
		micMute=$micMuteIcon
	fi
    	notify-send -i $micMute -a "Microphone" -r 2594 -u low -t 1000 "Volume: $(pactl get-source-volume @DEFAULT_SOURCE@ | awk '{print $5}')"

}

function mic_mute {
	micSens=$(pactl get-source-volume @DEFAULT_SOURCE@ | grep "Volume" | awk '{print $5}' | tr -d '%')
	threshold1=$((100 / 3))
	threshold2=$((2 * 100 / 3))

	if [ "$micSens" -le "$threshold1" ]; then
		micMuteIcon="microphone-sensitivity-low"
	elif [ "$micSens" -le "$threshold2" ]; then
		micMuteIcon="microphone-sensitivity-medium"
	else
		micMuteIcon="microphone-sensitivity-high"
	fi
	mute_status=$(pactl get-source-mute @DEFAULT_SOURCE@ | awk '{print $2}')
	if [ "$mute_status" = "yes" ]; then
		micMute="microphone-sensitivity-muted"
	else
		micMute=$micMuteIcon
	fi
    	notify-send -i $micMute -a "Microphone" -r 2594 -u low -t 1000 "Muted: $(pactl get-source-mute @DEFAULT_SOURCE@ | awk '{print $2}')"
}

function brightness {
    	notify-send -i "high-brightness" -a "Brightness" -u low -t 1000 -r 5555 "$((100 * $(brightnessctl g) / $(brightnessctl m))) %"
}

function keyboard {
	notify-send -i "input-keyboard" -a "Keyboard Layout" -u low -t 1000 -r 5556 "$(xkblayout-state print %s | awk '{print toupper($0)}')"
}

function camera {
	sleep 1
	cam_status=$(lsusb | grep -E -i 'camera|webcam|video' | wc -l)
	if [ "$cam_status" = "1" ]; then 
		status_cam="on"
	else
		status_cam="off"
	fi
	notify-send -i "camera-web" -a "Camera" -r 2567 -u low -t 1000 "$status_cam"
}

case $1 in
  a)
    audio_volume
    ;;
  b)
    audio_mute
    ;;
  c)
    mic_mute
    ;;
  cc)
    mic_volume
    ;;
  d)
    brightness
    ;;
  1)
    notify-send -i battery-good-charging -a "Conservation Mode" -t 2000 -r 5559 "Enabled"
    ;;
  0)
    notify-send -i battery-good-charging -a "Conservation Mode" -t 2000 -r 5559 "Disabled"
    ;;
  3)
    notify-send -i edit-clear -a "Ram Cleared" -t 2000 -r 5600 "$(free -h | grep Mem | awk '{print $3}')"
    ;;
  e)
    notify-send -i video-display -a "Monitor Refresh Rate" -t 10000 -r 5601 "Changed to 165hz"
    ;;
  f)
    notify-send -i video-display -a "Monitor Refresh Rate" -t 10000 -r 5601 "Changed to 59.96hz"
    ;;
  h)
    keyboard
    ;;
  rof)
    notify-send -i preferences-desktop-screensaver -a "Night light" -t 2000 -r 7854 "Status: off"
    ;;
  ron)
    notify-send -i preferences-desktop-screensaver -a "Night Light" -t 2000 -r 7854 "Status: on (`cat /home/skajp/.config/redshifter | grep color | awk -F= '{print $2}'`K)"
    ;;
  radd)
    notify-send -i preferences-desktop-screensaver -a "Night Light - Level" -t 2000 -r 7854 "Status +100K (`cat /home/skajp/.config/redshifter | grep color | awk -F= '{print $2}'`K)"
    ;;
  rmin)
    notify-send -i preferences-desktop-screensaver -a "Night Light - Level" -t 2000 -r 7854 "Status -100K (`cat /home/skajp/.config/redshifter | grep color | awk -F= '{print $2}'`K)"
    ;;
   cam)
    camera
    ;;
esac
