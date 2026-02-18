#!/bin/bash
# ~/.config/hypr/scripts/WallpaperChanged.sh

SCRIPTSDIR="$HOME/.config/hypr/scripts"

current_wall=$(swww query 2>/dev/null | grep -oP 'image: \K[^\s]+' | head -n 1)

if [[ ! -f "$current_wall" ]]; then
    current_wall=$(grep "^wallpaper" ~/.config/waypaper/config.ini 2>/dev/null | cut -d'=' -f2 | xargs)
fi

if [[ -f "$current_wall" ]]; then

    hellwal -i "$current_wall"
    W

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