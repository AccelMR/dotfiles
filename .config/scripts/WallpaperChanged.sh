#!/bin/bash
# ~/.config/scripts/WallpaperChanged.sh

# scripts directory
SCRIPTSDIR="$HOME/.config/scripts"
# fixed path for the symlink
LINK_PATH="$HOME/.config/.current_wallpaper.image"
# cache file to monitor
CACHE_FILE="$HOME/.cache/hellwal/colors-waybar.css"

# Get wallpaper from argument $1 (passed by waypaper)
current_wall="$1"

# Expand tilde to full home path if necessary
current_wall="${current_wall/#\~/$HOME}"

# If argument is empty, try to read from waypaper config as fallback
if [[ -z "$current_wall" || ! -f "$current_wall" ]]; then
  current_wall=$(grep "^wallpaper =" ~/.config/waypaper/config.ini 2>/dev/null | cut -d'=' -f2 | xargs)
  current_wall="${current_wall/#\~/$HOME}"
fi

# Check if wallpaper path is valid
if [[ -f "$current_wall" ]]; then
  # Set wallpaper via modern hyprpaper IPC (single command)
  # Empty monitor name means "fallback" for monitors without a specific assignment
  # fit_mode can be: contain|cover|tile|fill (waypaper uses "fill" in your config)
  hyprctl hyprpaper wallpaper ",$current_wall,fill" >/dev/null 2>&1

  pkill -f waypaper

  # Get current timestamp of the cache file
  if [[ -f "$CACHE_FILE" ]]; then
    OLD_TIME=$(stat -c %Y "$CACHE_FILE" 2>/dev/null || echo 0)
  else
    OLD_TIME=0
  fi

  # Run hellwal with the detected wallpaper
  hellwal -i "$current_wall"

  # Wait until hellwal actually updates the cache file
  # Timeout after 5 seconds to prevent infinite loop
  COUNTER=0
  while [[ $(stat -c %Y "$CACHE_FILE" 2>/dev/null || echo 0) == "$OLD_TIME" && $COUNTER -lt 50 ]]; do
    sleep 0.1
    ((COUNTER++))
  done

  # Handle symlink for image viewers or other tools
  extension="${current_wall##*.}"
  extension="${extension,,}"

  if [[ "$extension" == "png" || "$extension" == "jpg" || "$extension" == "jpeg" || "$extension" == "webp" ]]; then
    ln -sf "$current_wall" "$LINK_PATH"
  fi

  # Refresh waybar and other components
  if [[ -x "${SCRIPTSDIR}/Refresh.sh" ]]; then
    "${SCRIPTSDIR}/Refresh.sh"
  fi
else
  notify-send "Error" "Wallpaper path not found: $current_wall" -u critical
  exit 1
fi