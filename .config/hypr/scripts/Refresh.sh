
SCRIPTSDIR="$HOME/.config/hypr/scripts"

# Recargar Hyprland
hyprctl reload
# Recargar Waybar (si tienes este script)
if [[ -x "${SCRIPTSDIR}/RefreshWaybar.sh" ]]; then
    ${SCRIPTSDIR}/RefreshWaybar.sh
fi