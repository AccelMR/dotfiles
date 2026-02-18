#!/bin/bash

iDIR="$HOME/.config/dunst/icons"

# Get icon based on volume
get_icon() {
  volume=$(wpctl get-volume @DEFAULT_AUDIO_SINK@ | awk '{print int($2*100)}')
  if [[ "$volume" -eq 0 ]]; then
    echo "$iDIR/volume-mute.png"
  elif [[ "$volume" -lt 33 ]]; then
    echo "$iDIR/volume-low.png"
  elif [[ "$volume" -lt 66 ]]; then
    echo "$iDIR/volume-medium.png"
  else
    echo "$iDIR/volume-high.png"
  fi
}

# Get Volume
get_volume() {
  volume=$(wpctl get-volume @DEFAULT_AUDIO_SINK@ | awk '{print int($2*100)}')
  muted=$(wpctl get-volume @DEFAULT_AUDIO_SINK@ | grep -o "MUTED")
  
  if [[ -n "$muted" ]]; then
    echo "Muted"
  else
    echo "$volume%"
  fi
}

# Toggle Mute
toggle_mute() {
  wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle
  
  muted=$(wpctl get-volume @DEFAULT_AUDIO_SINK@ | grep -o "MUTED")
  if [[ -n "$muted" ]]; then
    notify-send -e -a volume -h string:x-canonical-private-synchronous:volume_notif -h boolean:SWAYNC_BYPASS_DND:true -u low -i "$iDIR/volume-mute.png" "Volume Switched OFF"
  else
    notify-send -e -a volume -h string:x-canonical-private-synchronous:volume_notif -h boolean:SWAYNC_BYPASS_DND:true -u low -i "$(get_icon)" "Volume Switched ON"
  fi
}

# Toggle Mic
toggle_mic() {
  wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle
  
  muted=$(wpctl get-volume @DEFAULT_AUDIO_SOURCE@ | grep -o "MUTED")
  if [[ -n "$muted" ]]; then
    notify-send -e -h string:x-canonical-private-synchronous:volume_notif -h boolean:SWAYNC_BYPASS_DND:true -u low -i "$iDIR/microphone-mute.png" "Microphone Switched OFF"
  else
    notify-send -e -h string:x-canonical-private-synchronous:volume_notif -h boolean:SWAYNC_BYPASS_DND:true -u low -i "$iDIR/microphone.png" "Microphone Switched ON"
  fi
}

# Execute accordingly
if [[ "$1" == "--get" ]]; then
  get_volume
elif [[ "$1" == "--inc" ]]; then
  wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%+
  get_volume
elif [[ "$1" == "--dec" ]]; then
  wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-
  get_volume
elif [[ "$1" == "--toggle" ]]; then
  toggle_mute
elif [[ "$1" == "--toggle-mic" ]]; then
  toggle_mic
else
  get_volume
fi