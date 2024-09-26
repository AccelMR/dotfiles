#!/bin/bash

while true; do
  # Leer el valor del knob de headsetcontrol y extraer solo el número
  knob_value=$(headsetcontrol -m | grep -o '[0-9]\+' | tail -n 1)

  # Verifica si knob_value tiene un valor válido (es un número)
  if [[ "$knob_value" =~ ^[0-9]+$ ]]; then
    if [ "$knob_value" -eq 64 ]; then
      # Si el knob está en el centro, ambos volúmenes al 100%
      volume_chat=100
      volume_game=100
    elif [ "$knob_value" -lt 64 ]; then
      # Si el knob está más cerca del chat, ajusta proporcionalmente, pero mantén volúmenes más altos
      volume_chat=$(( 100 ))
      volume_game=$(( knob_value * 100 / 64 ))
    else
      # Si el knob está más cerca del juego, ajusta proporcionalmente
      volume_chat=$(( (128 - knob_value) * 100 / 64 ))
      volume_game=$(( 100 ))
    fi

    # Ajustar el volumen de ChatOutput y GameOutput
    pactl set-sink-volume ChatOutput ${volume_chat}%
    pactl set-sink-volume GameOutput ${volume_game}%

    # Mostrar el resultado
    echo "Knob: $knob_value, Chat Volume: $volume_chat%, Game Volume: $volume_game%"
  else
    echo "Error: Valor de knob no válido -> $knob_value"
  fi

  sleep 1
done
