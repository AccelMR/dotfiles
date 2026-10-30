----
-- HYPRLAND WINDOW RULES - MERGED CONFIGURATION
----

-- --- TAG DEFINITIONS (Effects) ---

-- Utility: Floating, centered, standard size
hl.window_rule({
    name = "utility-rule",
    match = { tag = "utility" },
    float = true,
    center = true,
    size = { 1000, 700 },
})

-- WebApps: Floating, specific size and position
hl.window_rule({
    name = "webapp-rule",
    match = { tag = "webapp" },
    float = true,
    size = { "monitor_w*0.3", "monitor_h*0.5" },
    move = { "monitor_w*0.02", "monitor_h*0.05" },
})

-- Media: Floating and centered
hl.window_rule({
    name = "media-rule",
    match = { tag = "media" },
    float = true,
    center = true,
})

-- System: Opacity and visual tweaks
hl.window_rule({
    name = "transparent-rule",
    match = { tag = "transparent" },
    opacity = "0.9 0.8",
})

-- Launchers: Floating, centered, and visual effects
hl.window_rule({
    name = "launcher-rule",
    match = { tag = "launcher" },
    float = true,
    center = true,
    stay_focused = true,
    dim_around = true,
    opacity = "0.95 0.90",
})

-- Video Apps: No blur/dim for better playback
hl.window_rule({
    name = "no-blur-video-apps",
    match = { class = "^(firefox|helium|zen)$" },
    no_blur = true,
    no_dim = true,
    opacity = "1.0 override 1.0 override",
})

-- --- TAG ASSIGNMENTS (Matching) ---

-- Assign +launcher tag to wofi and rofi
hl.window_rule({ match = { class = "^(wofi|Rofi)$" }, tag = "+launcher" })

-- Assign +utility tag to system tools
hl.window_rule({
    match = { class = "(pavucontrol|org.pulseaudio.pavucontrol|nm-connection-editor|blueman-manager|corectrl|nwg-look|qt5ct|qt6ct|yad|gnome-system-monitor|opensnitch|opensnitch_ui|waypaper)" },
    tag = "+utility",
})

-- Assign +media tag to players and viewers
hl.window_rule({
    match = { class = "(mpv|eog|qalculate-qt|io.github.Qalculate.qalculate-qt|Amberol|net.davidotek.pupgui2)" },
    tag = "+media",
})

-- Assign +webapp tag to specific firefox instances
hl.window_rule({ match = { class = "(firefox-(chat.openai.com|gemini.google.com|music.youtube.com).*)" }, tag = "+webapp" })

-- Assign +transparent tag for consistent opacity
hl.window_rule({ match = { class = "(kitty|mousepad|foot|foot-dropterm|thunar|VSCodium|gedit)" }, tag = "+transparent" })


----
-- SPECIFIC OVERRIDES (Rules that need unique values)
----

hl.window_rule({
    match = { class = "^(org.kde.dolphin)$" },
    float = true,
    center = true,
    size = { 1200, 800 },
    opacity = "0.85 0.75 override",
})

-- Btop (Special terminal from bar)
hl.window_rule({ match = { class = "^kitty-btop$" }, float = true, center = true, size = { 1200, 800 } })

-- Octopi
hl.window_rule({ match = { class = "(octopi)", title = "(Octopi)" }, size = { 1400, 996 }, center = true })

-- Picture-in-Picture
hl.window_rule({
    name = "pip-rule",
    match = { title = "^(Picture-in-picture)$" },
    float = true,
    pin = true,
    size = { "monitor_w*0.3", "monitor_h*0.405" },
    move = { "monitor_w*0.69", "monitor_h*0.05" },
    keep_aspect_ratio = true,
    no_dim = true,
    opaque = true,
})

-- Gaming (Lutris & Steam)
hl.window_rule({
    match = { class = "(net.lutris.Lutris.*)" },
    size = { "monitor_w*0.8", "monitor_h*0.85" },
    center = true,
    opacity = "0.95 0.85",
})
hl.window_rule({ match = { class = "([Ss]team)" }, float = true })


----
-- DIALOGS & POPUPS
----

-- Common floating dialogs
hl.window_rule({
    match = { class = "(file_progress|confirm|dialog|download|notification|error|splash|confirmreset|zenity|org.kde.polkit-kde-authentication-agent-1)" },
    float = true,
})

-- Browser specific popups
hl.window_rule({ match = { class = "(firefox|librewolf|chromium)", title = "(Save File|Open File|.*Popup.*)" }, float = true })
hl.window_rule({ match = { class = "(firefox)", title = "(Save File|Select file)" }, size = { 1220, 850 } })


----
-- WORKSPACE ASSIGNMENTS
----

hl.window_rule({ match = { class = "(firefox-browser)" }, workspace = "1" })
hl.window_rule({ match = { class = "(net.lutris.Lutris)" }, workspace = "2 silent" })
hl.window_rule({ match = { class = "([Ss]team)" }, workspace = "3 silent" })
hl.window_rule({ match = { class = "(gimp-.*)" }, workspace = "6" })
hl.window_rule({ match = { class = "(org.wezfurlong.wezterm)" }, workspace = "7" })


----
-- LAYER RULES (Waybar, Notifications, etc.)
----

local barsAndNotifications = "(waybar|fabric|swaync-control-center|swaync-notification-window)"
hl.layer_rule({ match = { namespace = barsAndNotifications }, blur = true, ignore_alpha = 0 })
hl.layer_rule({ match = { namespace = "selection" }, no_anim = true })

hl.layer_rule({ match = { namespace = "^(wofi|rofi)$" }, blur = true, ignore_alpha = 0.3, animation = "slide" })


----
-- GLOBAL SETTINGS
----

hl.window_rule({ match = { class = ".*" }, focus_on_activate = true })
hl.window_rule({ match = { class = "^(firefox)$" }, no_dim = true })
hl.window_rule({ match = { class = "^(kitty)$" }, float = false, tile = true })
