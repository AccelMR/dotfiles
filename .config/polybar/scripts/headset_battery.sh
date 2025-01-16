#!/bin/bash

# Ejecuta headsetcontrol y obtiene la línea con el nivel de batería
battery_info=$(headsetcontrol -b | grep "Level")

# Extrae solo el número de la batería
battery_level=$(echo $battery_info | awk '{print $2}')

# Verifica si se obtuvo un valor y lo muestra
if [ -z "$battery_level" ]; then
  echo "󰋐"
else
  echo " ⚡ $battery_level"
fi