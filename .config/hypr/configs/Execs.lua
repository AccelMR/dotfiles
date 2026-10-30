--   ▗▄▄▖▗▄▄▄▖▗▄▖ ▗▄▄▖▗▄▄▄▖▗▖ ▗▖▗▄▄▖
--  ▐▌     █ ▐▌ ▐▌▐▌ ▐▌ █  ▐▌ ▐▌▐▌ ▐▌
--   ▝▀▚▖  █ ▐▛▀▜▌▐▛▀▚▖ █  ▐▌ ▐▌▐▛▀▘
--  ▗▄▄▞▘  █ ▐▌ ▐▌▐▌ ▐▌ █  ▝▚▄▞▘▐▌

-- ---------------- Startup Variables ----------------

local scriptsDir = os.getenv("HOME") .. "/.config/scripts"

hl.on("hyprland.start", function()
    -- ---------------- System Environment ----------------
    hl.exec_cmd("dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP")
    hl.exec_cmd("systemctl --user import-environment WAYLAND_DISPLAY XDG_CURRENT_DESKTOP")

    -- ---------------- System Services ----------------
    hl.exec_cmd("systemctl --user start hyprpolkitagent")

    -- ---------------- Startup Applications ----------------
    hl.exec_cmd("pkill kde6")
    hl.exec_cmd("hyprpaper")
    hl.exec_cmd("waypaper --restore")
    hl.exec_cmd(scriptsDir .. "/StartWaybar.sh")
    hl.exec_cmd("swaync")
    hl.exec_cmd("nm-applet --indicator")
    hl.exec_cmd("opensnitch-ui")
    hl.exec_cmd("wl-paste --watch cliphist store")
    hl.exec_cmd("hypridle -q")
    hl.exec_cmd('gsettings set org.gnome.desktop.interface cursor-theme "Bibata-Modern-Ice"')
    hl.exec_cmd('gsettings set org.gnome.desktop.interface color-scheme "prefer-dark"') -- for GTK4 apps

    hl.exec_cmd("blueman-applet")
    hl.exec_cmd("tailscale up")

    -- ---------------------- Laptop/desktop startup helper
    -- Run the appropriate setup for the current machine type.
    hl.exec_cmd(scriptsDir .. "/RunLaptopDesktopSetup.sh")
end)
