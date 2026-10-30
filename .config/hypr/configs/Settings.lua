--   ▗▄▄▖▗▄▄▄▖▗▄▄▄▖▗▄▄▄▖▗▄▄▄▖▗▖  ▗▖ ▗▄▄▖ ▗▄▄▖
--  ▐▌   ▐▌     █    █    █  ▐▛▚▖▐▌▐▌   ▐▌
--   ▝▀▚▖▐▛▀▀▘  █    █    █  ▐▌ ▝▜▌▐▌▝▜▌ ▝▀▚▖
--  ▗▄▄▞▘▐▙▄▄▖  █    █  ▗▄█▄▖▐▌  ▐▌▝▚▄▞▘▗▄▄▞

-- refer to Hyprland wiki for more info https://wiki.hypr.land/configuring/core/config-options/

-- ---------------- Color Scheme ----------------

-- Falls back to plain grays so the rest of the config still loads before hellwal has generated its colors.
local ok, c = pcall(require, os.getenv("HOME") .. "/.cache/hellwal/colors-hyprland")
if not ok or type(c) ~= "table" then
    c = setmetatable({}, { __index = function() return "rgb(888888)" end })
end

local accentGradient = { colors = { c.color4, c.color6, c.color7, c.color13, c.color15 }, angle = 40 }

-- ---------------- General Settings ----------------

hl.config({
    general = {
        gaps_in = 4,
        gaps_out = 8,
        border_size = 2,
        resize_on_border = true,
        col = {
            active_border = accentGradient,
            inactive_border = c.color5,
        },
        layout = "dwindle",
        -- allow_tearing = true,
    },

    -- ---------------- Dwindle Layout ----------------

    dwindle = {
        --pseudotile = true,
        preserve_split = true,
        special_scale_factor = 0.8,
        split_width_multiplier = 1.5,
        default_split_ratio = 1.3,
        -- smart_resizing = true,
    },

    -- ---------------- Master Layout ----------------

    master = {
        new_status = "slave",
        new_on_top = false,
        mfact = 0.65,
    },

    -- ---------------- Group Settings ----------------

    group = {
        col = {
            border_active = accentGradient,
        },

        groupbar = {
            col = {
                active = c.color5,
                inactive = c.color2,
            },
            gradients = true,
            gaps_in = 5,
            gaps_out = 2,
            height = 12,
            indicator_height = 0,
            font_size = 9,
            stacked = false,
            rounding = 2,
            gradient_rounding = 6,
            gradient_round_only_edges = true,
        },
    },

    -- ---------------- Decoration Settings ----------------

    decoration = {
        rounding = 8,
        active_opacity = 1.0,
        inactive_opacity = 0.8,
        fullscreen_opacity = 1.0,
        dim_inactive = true,
        dim_strength = 0.1,
        dim_special = 0.8,

        shadow = {
            enabled = true,
            range = 6,
            render_power = 3,
            color = c.color2,
            color_inactive = 0x50000000,
        },

        blur = {
            enabled = true,
            size = 5,
            passes = 3,
            ignore_opacity = true,
            new_optimizations = true,
            xray = false,
            special = true,
            noise = 0.0117,
            vibrancy = 0.1696,
        },
    },

    -- ---------------- Animation Settings ----------------

    animations = {
        enabled = true,
    },

    -- ---------------- Input Settings ----------------

    input = {
        kb_layout = "us",
        kb_variant = "intl",
        kb_model = "",
        kb_rules = "",
        repeat_rate = 50,
        repeat_delay = 300,
        numlock_by_default = false,
        left_handed = false,
        follow_mouse = 1,
        float_switch_override_focus = 0,
        accel_profile = "flat",

        touchpad = {
            disable_while_typing = true,
            natural_scroll = true,
            clickfinger_behavior = false,
            middle_button_emulation = true,
            tap_to_click = true,
            drag_lock = false,
            scroll_factor = 0.3,
        },
    },

    -- ---------------- Gesture Settings ----------------

    gestures = {
        workspace_swipe_invert = true,
        workspace_swipe_min_speed_to_force = 30,
        workspace_swipe_cancel_ratio = 0.5,
        workspace_swipe_create_new = true,
        workspace_swipe_forever = true,
        workspace_swipe_distance = 700,
    },

    -- ---------------- Miscellaneous Settings ----------------

    misc = {
        disable_hyprland_logo = true,
        disable_splash_rendering = true,
        mouse_move_enables_dpms = true,
        vrr = 0,
        enable_swallow = false,
        focus_on_activate = false,
        force_default_wallpaper = 0,
    },

    -- ---------------- Bind Settings ----------------

    binds = {
        workspace_back_and_forth = true,
        allow_workspace_cycles = true,
        pass_mouse_when_bound = false,
    },

    -- ---------------- Cursor Settings ----------------

    cursor = {
        sync_gsettings_theme = true,
        no_hardware_cursors = 2,
        enable_hyprcursor = true,
        no_warps = false,
    },

    -- ---------------- XWayland Settings ----------------

    xwayland = {
        enabled = true,
        force_zero_scaling = true,
    },
})

hl.gesture({ fingers = 3, direction = "horizontal", action = "workspace" })

-- ---------------- Animation Curves ----------------

local function bezier(name, x1, y1, x2, y2)
    hl.curve(name, { type = "bezier", points = { { x1, y1 }, { x2, y2 } } })
end

bezier("myBezier", 0.05, 0.9, 0.1, 1.05)
bezier("linear", 0.0, 0.0, 1.0, 1.0)
bezier("wind", 0.05, 0.9, 0.1, 1.05)
bezier("winIn", 0.1, 1.1, 0.1, 1.1)
bezier("winOut", 0.3, -0.3, 0, 1)
bezier("slow", 0, 0.85, 0.3, 1)
bezier("overshot", 0.7, 0.6, 0.1, 1.1)
bezier("bounce", 1.1, 1.6, 0.1, 0.85)
bezier("sligshot", 1, -1, 0.15, 1.25)
bezier("nice", 0, 6.9, 0.5, -4.20)
bezier("smoothOut", 0.36, 0, 0.66, -0.56)
bezier("smoothIn", 0.25, 1, 0.5, 1)
bezier("easeInSine", 0.005, 0.89, 0.09, 0.91)
bezier("rofi_curve", 0.34, -0.09, 0, 0.96)

-- ---------------- Animations ----------------

hl.animation({ leaf = "windowsIn",        enabled = true, speed = 5,   bezier = "winIn",    style = "popin" })
hl.animation({ leaf = "windowsOut",       enabled = true, speed = 5,   bezier = "winOut",   style = "popin" })
hl.animation({ leaf = "windowsMove",      enabled = true, speed = 5,   bezier = "wind",     style = "slide" })
hl.animation({ leaf = "border",           enabled = true, speed = 10,  bezier = "linear" })
hl.animation({ leaf = "borderangle",      enabled = true, speed = 100, bezier = "linear",   style = "loop" })
hl.animation({ leaf = "fade",             enabled = true, speed = 5,   bezier = "overshot" })
hl.animation({ leaf = "workspaces",       enabled = true, speed = 5,   bezier = "wind" })
hl.animation({ leaf = "windows",          enabled = true, speed = 5,   bezier = "bounce",   style = "popin" })
hl.animation({ leaf = "specialWorkspace", enabled = true, speed = 3,   bezier = "overshot", style = "slidevert" })
hl.animation({ leaf = "layersIn",         enabled = true, speed = 3,   bezier = "smoothIn", style = "slide top" })
hl.animation({ leaf = "layersOut",        enabled = true, speed = 3,   bezier = "wind",     style = "slide top" })

-- ---------------- Plugin Settings ----------------

-- Plugin options are rejected when the plugin is not loaded.
if hl.plugin and hl.plugin.hyprexpo ~= nil then
    hl.config({
        plugin = {
            hyprexpo = {
                columns = 3,
                gap_size = 5,
                bg_col = c.color7,
                workspace_method = "center current", -- [center/first] [workspace] e.g. first 1 or center m+1
            },
        },
    })
end
