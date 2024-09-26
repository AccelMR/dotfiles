# Opciones del menú con íconos
options=" Power Off\n Reboot\n Suspend\n Log out\n Lock"

# Mostrar el menú y capturar la selección
selected=$(echo -e $options | rofi -dmenu -i -p "Choose an option: ")

# Ejecutar la acción correspondiente
case $selected in
    " Power Off")
        systemctl poweroff
        ;;
    " Reboot")
        systemctl reboot
        ;;
    " Suspend")
        i3lock && systemctl suspend
        ;;
    " Log out")
        i3-msg exit
        ;;
    " Lock")
        i3lock
        ;;
    *)
        ;;
esac