#!/bin/bash

# Function to check if a sink already exists
sink_exists() {
  pactl list sinks short | grep -q "$1"
}

# Function to unload all loopback modules for a given source
unload_loopbacks_for_source() {
  local source="$1"
  # pactl list modules (long form) includes arguments per module
  pactl list modules | awk -v src="source=$source" '
    /^Module #/ { id = substr($2, 2) }
    /Argument:/ && $0 ~ src { print id }
  ' | while read -r id; do
    pactl unload-module "$id"
  done
}

# Create GameOutput sink if it doesn't exist
if ! sink_exists "GameOutput"; then
  pactl load-module module-null-sink sink_name=GameOutput sink_properties=device.description="GameOutput"
fi

# Create ChatOutput sink if it doesn't exist
if ! sink_exists "ChatOutput"; then
  pactl load-module module-null-sink sink_name=ChatOutput sink_properties=device.description="ChatOutput"
fi

# Get the name of the Arctis sink
arctis_sink=$(pactl list sinks short | grep -i "usb-SteelSeries_Arctis_7" | awk '{print $2}' | head -n1)

if [ -z "$arctis_sink" ]; then
  echo "❌ No se encontró un sink de Arctis. Abortando."
  exit 1
fi

echo "✅ Arctis sink: $arctis_sink"

# Always unload and recreate loopbacks to ensure they point to the current sink
unload_loopbacks_for_source "GameOutput.monitor"
pactl load-module module-loopback source=GameOutput.monitor sink="$arctis_sink"
echo "✅ Loopback GameOutput -> $arctis_sink recreado"

unload_loopbacks_for_source "ChatOutput.monitor"
pactl load-module module-loopback source=ChatOutput.monitor sink="$arctis_sink"
echo "✅ Loopback ChatOutput -> $arctis_sink recreado"