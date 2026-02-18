#!/bin/bash
# ~/.config/hypr/scripts/WallpaperChanged.sh

SCRIPTSDIR="$HOME/.config/hypr/scripts"

# Intentar obtener desde swww primero
current_wall=$(swww query 2>/dev/null | grep -oP 'image: \K[^\s]+' | head -n 1)

# Si falla, intentar desde config de waypaper
if [[ ! -f "$current_wall" ]]; then
    current_wall=$(grep "^wallpaper" ~/.config/waypaper/config.ini 2>/dev/null | cut -d'=' -f2 | xargs)
fi

# Verificar que existe el archivo
if [[ -f "$current_wall" ]]; then
    echo "🎨 Aplicando hellwal a: $current_wall"
    
    # Ejecutar hellwal
    hellwal -i "$current_wall"
    W
    # Esperar un poco para que hellwal termine
    sleep 0.5
    
    # Recargar configuraciones (si tienes este script)
    if [[ -x "${SCRIPTSDIR}/Refresh.sh" ]]; then
        ${SCRIPTSDIR}/Refresh.sh
    fi
    
    # Notificación opcional (si usas dunst/mako/swaync)
    notify-send "Wallpaper Changed" "Theme updated with hellwal" -i "$current_wall"
else
    echo "❌ Error: No se pudo obtener la ruta del wallpaper"
    notify-send "Error" "Could not apply hellwal" -u critical
    exit 1
fi