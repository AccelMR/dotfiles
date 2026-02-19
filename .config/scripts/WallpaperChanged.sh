#!/bin/bash
# ~/.config/scripts/WallpaperChanged.sh

# scripts directory
SCRIPTSDIR="$HOME/.config/scripts"
# fixed path for the symlink
LINK_PATH="$HOME/.config/.current_wallpaper.image"
# cache file to monitor
CACHE_FILE="$HOME/.cache/hellwal/colors-waybar.css"

# wait a bit for swww/waypaper to finalize the transition
sleep 0.8

# get current wallpaper from swww
current_wall=$(swww query 2>/dev/null | grep -oP 'image: \K[^\s]+' | head -n 1)

# fallback to waypaper config if swww fails
if [[ ! -f "$current_wall" ]]; then
  current_wall=$(grep "^wallpaper" ~/.config/waypaper/config.ini 2>/dev/null | cut -d'=' -f2 | xargs)
fi

# check if wallpaper path is valid
if [[ -f "$current_wall" ]]; then
  # get current timestamp of the cache file
  if [[ -f "$CACHE_FILE" ]]; then
    OLD_TIME=$(stat -c %Y "$CACHE_FILE")
  else
    OLD_TIME=0
  fi

  # run hellwal with the detected wallpaper
  hellwal -i "$current_wall"

  # wait until hellwal actually updates the cache file
  # timeout after 5 seconds to prevent infinite loop
  COUNTER=0
  while [[ $(stat -c %Y "$CACHE_FILE" 2>/dev/null) == "$OLD_TIME" && $COUNTER -lt 50 ]]; do
    sleep 0.1
    ((COUNTER++))
  done

  # handle symlink for image viewers or other tools
  extension="${current_wall##*.}"
  extension="${extension,,}"

  if [[ "$extension" == "png" || "$extension" == "jpg" || "$extension" == "jpeg" ]]; then
    ln -sf "$current_wall" "$LINK_PATH"
  fi

  # extra safety sleep before refreshing UI
  sleep 0.5
  
  # refresh waybar and other components
  if [[ -x "${SCRIPTSDIR}/Refresh.sh" ]]; then
    ${SCRIPTSDIR}/Refresh.sh
  fi
  
  notify-send "Wallpaper Changed" "Theme updated with hellwal" -i "$current_wall"
else
  echo "❌ Error: Could not retrieve wallpaper path"
  notify-send "Error" "Could not apply hellwal" -u critical
  exit 1
fi