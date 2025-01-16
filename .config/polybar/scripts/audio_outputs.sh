# #!/bin/bash

# # Obtener la lista de dispositivos de salida
# devices=$(pactl list short sinks | awk '{print $2}')

# # Mostrar un menú para seleccionar el dispositivo con rofi
# chosen_device=$(echo "$devices" | rofi -dmenu -p "Select Output:")

# # Cambiar al dispositivo seleccionado
# if [ -n "$chosen_device" ]; then
#     pactl set-default-sink "$chosen_device"
#     notify-send "Output changed to $chosen_device"
# fi

#!/bin/bash

# Obtener la lista de dispositivos de salida
devices=$(pactl list short sinks)

# Crear un array para almacenar los identificadores y nombres
declare -A device_map

# Llenar el array con identificadores y nombres
while IFS= read -r line; do
    id=$(echo "$line" | awk '{print $2}')
    name=$(echo "$line" | awk '{print $2}' | cut -d'.' -f2-)
    device_map["$name"]="$id"
done <<< "$devices"

# Mostrar un menú para seleccionar el dispositivo con rofi
chosen_name=$(printf "%s\n" "${!device_map[@]}" | rofi -dmenu -p "🎧 Select Output:")

# Cambiar al dispositivo seleccionado
if [ -n "$chosen_name" ]; then
    chosen_device=${device_map["$chosen_name"]}
    pactl set-default-sink "$chosen_device"
    notify-send "Output changed to $chosen_name"
fi