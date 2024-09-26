#!/bin/bash

status=$(playerctl status 2>/dev/null)

if [ "$status" == "Playing" ]; then
    echo ""  # Icono de pausa
elif [ "$status" == "Paused" ]; then
    echo ""  # Icono de reproducción
else
    echo ""  # Icono de detener
fi