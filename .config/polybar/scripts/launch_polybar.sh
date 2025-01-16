#!/usr/bin/env bash

# Termina las instancias de Polybar que ya están corriendo
killall -q polybar

# Espera hasta que los procesos se cierren
while pgrep -u $UID -x polybar >/dev/null; do sleep 1; done

# Lanza Polybar en monitores específicos
if type "xrandr"; then
    MONITOR=$(xrandr --query | grep " connected" | awk 'NR==1{print $1}')
    MONITOR=$MONITOR polybar --reload Monitor0Left &

    MONITOR=$(xrandr --query | grep " connected" | awk 'NR==2{print $1}')
    MONITOR=$MONITOR polybar --reload Monitor0Center &

    MONITOR=$(xrandr --query | grep " connected" | awk 'NR==3{print $1}')
    MONITOR=$MONITOR polybar --reload Monitor0Right &

    MONITOR=$(xrandr --query | grep " connected" | awk 'NR==4{print $1}')
    MONITOR=$MONITOR polybar --reload Monitor1Left &

    MONITOR=$(xrandr --query | grep " connected" | awk 'NR==5{print $1}')
    MONITOR=$MONITOR polybar --reload Monitor1Center &

    MONITOR=$(xrandr --query | grep " connected" | awk 'NR==6{print $1}')
    MONITOR=$MONITOR polybar --reload Monitor1Right &
else
    polybar --reload Monitor0Left &
    polybar --reload Monitor0Center &
    polybar --reload Monitor0Right &
fi