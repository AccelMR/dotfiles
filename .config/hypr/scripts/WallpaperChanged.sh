#!/bin/bash
# ~/.config/hypr/scripts/WallpaperChanged.sh

SCRIPTSDIR="$HOME/.config/hypr/scripts"
# Define a fixed path for the symlink
LINK_PATH="$HOME/.config/.current_wallpaper.image"

current_wall=$(swww query 2>/dev/null | grep -oP 'image: \K[^\s]+' | head -n 1)

if [[ ! -f "$current_wall" ]]; then
  current_wall=$(grep "^wallpaper" ~/.config/waypaper/config.ini 2>/dev/null | cut -d'=' -f2 | xargs)
fi

if [[ -f "$current_wall" ]]; then

  hellwal -i "$current_wall"

  # Create symlink if wallpaper is PNG or JPG
  extension="${current_wall##*.}"
  extension="${extension,,}" # Convert to lowercase

  if [[ "$extension" == "png" || "$extension" == "jpg" || "$extension" == "jpeg" ]]; then
    ln -sf "$current_wall" "$LINK_PATH"
  fi

  sleep 0.5
  
  if [[ -x "${SCRIPTSDIR}/Refresh.sh" ]]; then
    ${SCRIPTSDIR}/Refresh.sh
  fi
  
  notify-send "Wallpaper Changed" "Theme updated with hellwal" -i "$current_wall"
else
  echo "❌ Error: No se pudo obtener la ruta del wallpaper"
  notify-send "Error" "Could not apply hellwal" -u critical
  exit 1
fi