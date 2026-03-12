#!/bin/bash

MONITOR="eDP-1"
USER="accelmr"
USER_ID=$(id -u "$USER")

export XDG_RUNTIME_DIR="/run/user/${USER_ID}"
export DBUS_SESSION_BUS_ADDRESS="unix:path=/run/user/${USER_ID}/bus"
export HYPRLAND_INSTANCE_SIGNATURE=$(ls /run/user/${USER_ID}/hypr/ 2>/dev/null | head -1)

if [ "$1" == "performance" ]; then
  hyprctl keyword monitor "$MONITOR,2880x1920@120,0x0,1.5"
  powerprofilesctl set performance
  notify-send "Performance" "Mode Performance: 120Hz activated" -i battery-full
else
  hyprctl keyword monitor "$MONITOR,2880x1920@60,0x0,1.5"
  powerprofilesctl set power-saver
  notify-send "Battery" "Mode Battery: 60Hz activated" -i battery-empty
fi