--  ▗▄▄▄▖▗▖  ▗▖▗▖  ▗▖▗▄▄▄▖▗▄▄▖  ▗▄▖ ▗▖  ▗▖▗▖  ▗▖▗▄▄▄▖▗▖  ▗▖▗▄▄▄▖
--  ▐▌   ▐▛▚▖▐▌▐▌  ▐▌  █  ▐▌ ▐▌▐▌ ▐▌▐▛▚▖▐▌▐▛▚▞▜▌▐▌   ▐▛▚▖▐▌  █
--  ▐▛▀▀▘▐▌ ▝▜▌▐▌  ▐▌  █  ▐▛▀▚▖▐▌ ▐▌▐▌ ▝▜▌▐▌  ▐▌▐▛▀▀▘▐▌ ▝▜▌  █
--  ▐▙▄▄▖▐▌  ▐▌ ▝▚▞▘ ▗▄█▄▖▐▌ ▐▌▝▚▄▞▘▐▌  ▐▌▐▌  ▐▌▐▙▄▄▖▐▌  ▐▌  █

-- ---------------- Environment Variables ----------------

local home = os.getenv("HOME")

-- General
hl.env("CLUTTER_BACKEND", "wayland")
hl.env("GDK_BACKEND", "wayland,x11")
hl.env("XDG_CURRENT_DESKTOP", "Hyprland")
hl.env("XDG_SESSION_DESKTOP", "Hyprland")
hl.env("XDG_SESSION_TYPE", "wayland")
hl.env("GTK_USE_PORTAL", "1")
hl.env("PATH", os.getenv("PATH") .. ":" .. home .. "/.local/bin/scripts/")
hl.env("EDITOR", "nvim")

--GTK_THEME=Adwaita:dark firefox &

-- Qt
hl.env("QT_AUTO_SCREEN_SCALE_FACTOR", "1")
hl.env("QT_QPA_PLATFORM", "wayland;xcb")
hl.env("QT_QPA_PLATFORMTHEME", "qt5ct")
hl.env("QT_SCALE_FACTOR", "1")
hl.env("QT_WAYLAND_DISABLE_WINDOWDECORATION", "1")
hl.env("QT_QUICK_CONTROLS_STYLE", "org.hyprland.style")
hl.env("QT_STYLE_OVERRIDE", "kvantum")

-- Vulkan
--hl.env("VK_ICD_FILENAMES", "/usr/share/vulkan/icd.d/radeon_icd.i686.json:/usr/share/vulkan/icd.d/radeon_icd.x86_64.json")

-- XWayland
hl.env("GDK_SCALE", "1")

-- Cursor
hl.env("HYPRCURSOR_THEME", "Bibata-Modern-Ice")
hl.env("HYPRCURSOR_SIZE", "24")

-- Firefox
hl.env("MOZ_ENABLE_WAYLAND", "1")

-- Electron
hl.env("ELECTRON_OZONE_PLATFORM_HINT", "auto")
