# dotfiles

Personal configuration files (dotfiles) that I use across my Arch Linux laptop and desktop.  
This repo keeps my environment consistent, minimal, and easy to reinstall.

---

### ✨ Purpose

This repository exists to:

- Keep my dotfiles synchronized between my laptop and desktop.
- Have a single source of truth for my Arch-based setup.
- Rebuild my environment quickly after a fresh install.
- Serve as a reference for anyone who wants a similar workflow and look.

---
### 🛠️ Core Components

This setup is built around a modern, Wayland-based environment on Arch Linux:

- **Hyprland**: A dynamic tiling Wayland compositor based on wlroots that provides smooth animations and a highly productive workflow.
- **Waybar**: A highly customizable status bar for Wayland, used to display system information, workspaces, and tray icons.
- **Wofi / Rofi**: Application launcher and menu system used for quick access to programs and custom scripts.
---

### 💻 Target Environment

These dotfiles are designed for:

- **Distro**: Arch Linux (BTW).
- **Usage**: daily work, development, Gaming, and personal use.
- **Sync model**: same repo cloned on both machines, configs symlinked or copied from here.

---

### ⚙️ Installation / Usage

#### 1. Clone the repository

```bash
git clone https://github.com/AccelMR/dotfiles.git
cd dotfiles
```

### 2. Manage Symlinks with GNU Stow
 I use GNU Stow to manage my configurations. This makes it easy to symlink files from the repository to your home directory.

```bash
sudo pacman -S stow
```

If you are on your PC and the dotfiles are on a different drive or location, you can specify the target directory:
```bash
# Standard usage (if repo is in your home)
stow .

# If the repo is on another disk/partition, specify the target
stow -t $HOME .
```

### 3. Restart relevant components
Depending on what you changed:

- Log out and log back in to your graphical session.
- Restart your window manager / compositor (Hyprland).
- Close and reopen terminals.

---
### Notes & Caveats
 - This is opinionated and tailored to my workflow.
 - Things might not work "out of the box" on other distributions, but it should be a good starting point if you are on Arch.