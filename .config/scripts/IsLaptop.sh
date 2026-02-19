#!/usr/bin/env bash

# Check if the system is a laptop by checking for battery or chassis type
# Indentation: 2 spaces

if [ -d /sys/class/power_supply/BAT0 ] || [ -d /sys/class/power_supply/BAT1 ]; then
  exit 0  # Is laptop
else
  exit 1  # Is desktop
fi