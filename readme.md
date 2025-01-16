# Dotfiles

This repository contains my personal configuration files for various applications and tools. These dotfiles help set up my development environment and customize my system.

## Table of Contents

- [Hyprland Configuration](#hyprland-configuration)
- [Pipewire Setup](#pipewire-setup)
- [Arctis 7 Mixer Script](#arctis-7-mixer-script)
- [Themes](#themes)
- [Usage](#usage)
- [License](#license)

## Hyprland Configuration

The Hyprland configuration files are located in the `.config/hypr/` directory. These files contain settings for monitors, programs, and autostart applications.

### Key Files

- **[hyprland.conf](.config/hypr/hyprland.conf)**: Main configuration file for Hyprland.
- **[mocha.conf](.config/hypr/mocha.conf)**: Additional configuration sourced by `hyprland.conf`.

### Programs needed by hyprland congif

- `$terminal = kitty`
- `$fileManager = dolphin`
- `$menu = wofi -I --conf ~/.config/wofi/config --style ~/.config wofi/themes/mocha/style.css --allow-images --show drun`

## Pipewire Setup
The setup_audio.sh script creates two virtual audio outputs (GameOutput and ChatOutput) and sets the Arctis 7 headset as the default output and chat output as the default input.

### Key Files
- **[setup_audio.sh](.config/pipewire/setup_audio.sh): Script to set up virtual audio outputs and link them to Arctis 7 headsets.
- **[startup.sh](.config/pipewire/startup.sh): Script to start a Python script that controls mixer volume for Arctis 7.

### Arctis 7 Mixer Script
The [arctis7MixerScript.py](.config/pipewire/arctis7MixerScript.py) script controls the mixer volume for the Arctis 7 headset based on the Chatmix value. It adjusts the volumes of **GameOutput** and **ChatOutput** accordingly.

## Credits

This configuration makes use of **HyprPanel**, a panel for Hyprland created by **Jas-SinghFSU**. You can find more information and the original repository here:

- **HyprPanel**: [https://github.com/Jas-SinghFSU/HyprPanel](https://github.com/Jas-SinghFSU/HyprPanel)


## Usage

1. Clone the repository to your local machine.
2. Ensure all necessary dependencies are installed.
3. Modify the configuration files as needed.
4. Start Hyprland and enjoy your customized setup.
