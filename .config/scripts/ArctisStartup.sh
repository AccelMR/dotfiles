pkill -f arctis7MixerScript.py
python3 ~/.config/scripts/python/Arctis7MixerScript.py &

# Verificar si tailscaled ya está corriendo
if ! systemctl is-active --quiet tailscaled; then
    sudo systemctl start tailscaled
fi

# Verificar si ya está conectado a Tailscale
if ! tailscale status --json | grep -q '"BackendState":"Running"'; then
    sudo tailscale up
fi