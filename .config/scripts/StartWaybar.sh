#!/usr/bin/env bash

# Start Waybar with appropriate config based on hardware
# Indentation: 2 spaces

pkill waybar
if ~/.config/scripts/IsLaptop.sh; then
  # Laptop: use full config with laptop group
  waybar -c ~/.config/waybar/configLaptop &
else
  # Desktop: use config without laptop modules
  waybar -c ~/.config/waybar/configDesktop &
fi