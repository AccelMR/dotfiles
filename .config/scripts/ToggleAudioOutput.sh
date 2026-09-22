#!/bin/bash

set -euo pipefail

find_sink_by_description() {
    local pattern="$1"
    pactl list sinks | python3 - "$pattern" <<'PY'
import sys
import subprocess
pattern = sys.argv[1].lower()
text = subprocess.check_output(['pactl', 'list', 'sinks'], text=True)
name = None
for line in text.splitlines():
    if line.startswith('Sink #'):
        name = None
    elif line.strip().startswith('Name:'):
        name = line.split(':', 1)[1].strip()
    elif line.strip().startswith('Description:'):
        desc = line.split(':', 1)[1].strip()
        if pattern in desc.lower() or (name and pattern in name.lower()):
            print(name)
            break
PY
}

starship_sink=$(find_sink_by_description 'starship')
game_sink=$(find_sink_by_description 'gameoutput')
current_sink=$(pactl get-default-sink 2>/dev/null || true)

if [ -z "$starship_sink" ] || [ -z "$game_sink" ]; then
    echo "No se encontraron los sinks requeridos." >&2
    exit 1
fi

if [ -z "$current_sink" ]; then
    target_sink="$starship_sink"
elif [ "$current_sink" = "$game_sink" ]; then
    target_sink="$starship_sink"
else
    target_sink="$game_sink"
fi

pactl set-default-sink "$target_sink"

for input in $(pactl list short sink-inputs | awk '{print $1}'); do
    pactl move-sink-input "$input" "$target_sink" >/dev/null 2>&1 || true
done

notify-send "Audio" "Salida activa: $target_sink" 2>/dev/null || true
