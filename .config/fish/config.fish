# set -g fish_greeting ""

# oh-my-posh init fish | source
# oh-my-posh init fish --config ~/dotfiles/.config/oh-my-posh/themes/accelTheme.omp.json | source

# set -Ux EDITOR micro
# set -Ux VISUAL micro
# set -Ux SUDO_EDITOR micro

# set -x PATH $HOME/p4v/bin/ $PATH

# export EDITOR=micro
# export VISUAL=micro
# export SUDO_EDITOR=micro
# export QT_QPA_PLATFORMTHEME=qt5ct
# export GTK_THEME=Catppuccin-Mocha:dark
# export "MICRO_TRUECOLOR"=1

# if status is-interactive
#     # Commands to run in interactive sessions can go here
# end

# neofetch

# # bun
# set --export BUN_INSTALL "$HOME/.bun"
# set --export PATH $BUN_INSTALL/bin $PATH
# # export PATH=$PATH:/opt/rocm/bin
# export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/opt/rocm/lib:/opt/rocm/lib64:/usr/lib

# if test -d /opt/rocm/bin
#     fish_add_path /opt/rocm/bin
# end
# set -e fish_trace

# Eliminar el mensaje de bienvenida de Fish
set -g fish_greeting ""

# Oh-My-Posh
oh-my-posh init fish --config ~/dotfiles/.config/oh-my-posh/themes/accelTheme.omp.json | source

# Configuración de editores
set -Ux EDITOR micro
set -Ux VISUAL micro
set -Ux SUDO_EDITOR micro

# Agregar binarios al PATH
# set -x PATH $HOME/p4v/bin $PATH

# Variables de entorno
set -Ux QT_QPA_PLATFORMTHEME qt5ct
set -Ux GTK_THEME Catppuccin-Mocha:dark
set -Ux MICRO_TRUECOLOR 1
set -Ux LD_LIBRARY_PATH /opt/rocm/lib:/opt/rocm/lib64:/usr/lib

# Configuración de Bun
set -Ux BUN_INSTALL "$HOME/.bun"
set -x PATH $BUN_INSTALL/bin $PATH
set -Ux OLLAMA_MODELS "/mnt/nvme2TB/ollama-models"

# Agregar ROCm si existe
if test -d /opt/rocm/bin
    fish_add_path /opt/rocm/bin
end

# Solo ejecutar en sesiones interactivas
if status is-interactive
    neofetch
end
