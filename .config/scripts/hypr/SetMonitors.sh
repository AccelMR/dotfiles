#!/usr/bin/env bash

# Apply monitor config based on system type
if ~/.config/scripts/IsLaptop.sh; then
  ln -sf ~/.config/hypr/configs/MonitorsLaptop.conf \
         ~/.config/hypr/configs/Monitors.conf
else
  ln -sf ~/.config/hypr/configs/MonitorsDesktop.conf \
         ~/.config/hypr/configs/Monitors.conf
fi