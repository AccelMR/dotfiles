#!/usr/bin/env bash
set -euo pipefail

scriptsDir="$HOME/.config/scripts"

# Run hardware-specific startup tasks depending on laptop vs desktop.
# This avoids relying on shell-inverted conditionals inside Hyprland exec-once.
if "$scriptsDir/IsLaptop.sh"; then
  "$scriptsDir/RefreshTouchScreen.sh"
else
  "$scriptsDir/SetupAudio.sh"
  "$scriptsDir/ArctisStartup.sh"
fi
