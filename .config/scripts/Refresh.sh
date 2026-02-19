
SCRIPTSDIR="$HOME/.config/scripts"

# Recargar Hyprland
hyprctl reload
touch ~/.config/waybar/style.css
touch ~/.cache/hellwal/colors-waybar.css

# Recargar Waybar (si tienes este script)
if [[ -x "${SCRIPTSDIR}/StartWaybar.sh" ]]; then
    ${SCRIPTSDIR}/StartWaybar.sh
fi