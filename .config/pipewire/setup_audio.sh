#!/bin/bash

# Función para verificar si un sink ya existe
sink_exists() {
    pactl list sinks short | grep -q "$1"
}

# Crear GameOutput si no existe
if ! sink_exists "GameOutput"; then
    pactl load-module module-null-sink sink_name=GameOutput sink_properties=device.description="GameOutput"
fi

# Crear ChatOutput si no existe
if ! sink_exists "ChatOutput"; then
    pactl load-module module-null-sink sink_name=ChatOutput sink_properties=device.description="ChatOutput"
fi

# Obtener el nombre del sink de los auriculares Arctis
arctis_sink=$(pactl list short sinks | grep -i "arctis" | awk '{print $2}')

# Crear loopback para GameOutput a los auriculares Arctis
pactl load-module module-loopback source=GameOutput.monitor sink=$arctis_sink

# Crear loopback para ChatOutput a los auriculares Arctis
pactl load-module module-loopback source=ChatOutput.monitor sink=$arctis_sink