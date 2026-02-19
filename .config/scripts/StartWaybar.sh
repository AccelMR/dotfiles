#!/usr/bin/env bash

pkill waybar
sleep 0.3
if ~/.config/scripts/IsLaptop.sh; then
  # Laptop: use full config with laptop group
  waybar -c ~/.config/waybar/configLaptop &
else
  # Desktop: use config without laptop modules
  waybar -c ~/.config/waybar/configDesktop &
fi