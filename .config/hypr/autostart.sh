#!/bin/bash

# Establecer el fondo de pantalla
swaybg -i ~/.config/backgrounds/mountain_1.jpg  &

# Iniciar compositor para efectos (opcional si quieres un compositor diferente o extra)
# Hyprland ya tiene su propio compositor, pero si quieres uno extra como waybar o rofi, lo puedes lanzar aquí.
# picom --experimental-backends &

# Iniciar barra de estado como Waybar (si lo tienes instalado)
waybar &

# Iniciar aplicaciones al inicio
# Puedes lanzar cualquier aplicación que necesites en segundo plano.
# Por ejemplo, un cliente de notificaciones como dunst:
dunst &

# Lanzar un gestor de portapapeles
wl-clipboard &

# Iniciar cliente de red
nm-applet &

# Lanzar algún daemon o servicio extra, como un gestor de energía
# Si usas algo como power management:
# xfce4-power-manager &

# Ajustar el brillo de la pantalla (opcional)
# brightnessctl set 50% &

# Lanzar otros programas que uses al inicio, como Discord, Slack, etc.
# discord &
# slack &

# Ejecutar tu propio script de configuraciones si es necesario.
# ~/.config/hypr/custom_script.sh &

exit 0
