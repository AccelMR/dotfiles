--  ▗▖ ▗▖▗▄▄▄▖▗▖  ▗▖▗▄▄▖ ▗▄▄▄▖▗▖  ▗▖▗▄▄▄ ▗▄▄▄▖▗▖  ▗▖ ▗▄▄▖ ▗▄▄▖
--  ▐▌▗▞▘▐▌    ▝▚▞▘ ▐▌ ▐▌  █  ▐▛▚▖▐▌▐▌  █  █  ▐▛▚▖▐▌▐▌   ▐▌
--  ▐▛▚▖ ▐▛▀▀▘  ▐▌  ▐▛▀▚▖  █  ▐▌ ▝▜▌▐▌  █  █  ▐▌ ▝▜▌▐▌▝▜▌ ▝▀▚▖
--  ▐▌ ▐▌▐▙▄▄▖  ▐▌  ▐▙▄▞▘▗▄█▄▖▐▌  ▐▌▐▙▄▄▀▗▄█▄▖▐▌  ▐▌▝▚▄▞▘▗▄▄▞▘


-- ---------------- App-Specific Rules ----------------

local mainMod = "SUPER"
local files_main = "dolphin"
local browser = "helium"
local termPri = "kitty"
local scriptsDir = os.getenv("HOME") .. "/.config/scripts"

-- Misc
local aniCliCmd = "ani-cli-mpv"

local function exec(cmd)
    return hl.dsp.exec_cmd(cmd)
end

-- ---------------- System Controls ----------------

-- Power
hl.bind("XF86PowerOff", exec("systemctl suspend"))
hl.bind("CTRL + ALT + Delete", hl.dsp.exit())
hl.bind("CTRL + ALT + P", exec(scriptsDir .. "/RofiPower.sh"))

-- Hyprland
hl.bind(mainMod .. " + SHIFT + R", hl.dsp.reload_config())
hl.bind(mainMod .. " + Escape", exec("hyprctl kill"))

-- Wayland
hl.bind("CTRL + ALT + W", exec(scriptsDir .. "/StartWaybar.sh"))
hl.bind(mainMod .. " + W", exec("pkill waypaper || true && waypaper"))

-- ---------------- App Launchers ----------------

-- Rofi

hl.bind(mainMod .. " + Space", exec("pkill rofi || rofi -matching fuzzy -show drun -modi drun,filebrowser"),
    { release = true, description = "App Launcher" })
--hl.bind(mainMod .. " + Space", exec("pkill wofi || wofi --show drun --conf $HOME/.config/wofi/config --cache-file ~/.cache/wofi-cache"), { release = true })

-- Apps
hl.bind(mainMod .. " + Return", exec(termPri))
hl.bind(mainMod .. " + E", exec(files_main))
hl.bind(mainMod .. " + B", exec(browser))
hl.bind("XF86Calculator", exec("qalculate-qt")) -- f3

-- Ani-cli
hl.bind("XF86Explorer", exec(aniCliCmd .. " -q 1080p --dub --rofi")) -- f1
hl.bind("XF86HomePage", exec(aniCliCmd .. " -q 1080p --rofi"))       -- f2
hl.bind("XF86Tools", exec(aniCliCmd .. " -c --rofi"))                -- f4

-- ---------------- Window Management ----------------

-- Window States
hl.bind(mainMod .. " + SHIFT + F", hl.dsp.window.float({ action = "toggle" }))
hl.bind(mainMod .. " + F", hl.dsp.window.fullscreen())
hl.bind(mainMod .. " + SHIFT + Q", hl.dsp.window.close())
hl.bind(mainMod .. " + P", hl.dsp.window.pin())

local directions = {
    { arrow = "left",  vim = "h", dir = "left" },
    { arrow = "right", vim = "l", dir = "right" },
    { arrow = "up",    vim = "k", dir = "up" },
    { arrow = "down",  vim = "j", dir = "down" },
}

for _, d in ipairs(directions) do
    -- Move focus with arrow keys or vim motions
    hl.bind(mainMod .. " + " .. d.arrow, hl.dsp.focus({ direction = d.dir }))
    hl.bind(mainMod .. " + " .. d.vim, hl.dsp.focus({ direction = d.dir }))

    -- Move window with arrow keys or vim motions
    hl.bind(mainMod .. " + SHIFT + " .. d.arrow, hl.dsp.window.move({ direction = d.dir }))
    hl.bind(mainMod .. " + SHIFT + " .. d.vim, hl.dsp.window.move({ direction = d.dir }))
end

-- Layout

-- Grouping
hl.bind(mainMod .. " + G", hl.dsp.group.toggle())
hl.bind(mainMod .. " + Tab", hl.dsp.group.next())
hl.bind(mainMod .. " + CTRL + R", hl.dsp.window.move({ out_of_group = true }))

-- Resize
hl.bind(mainMod .. " + CTRL + left", hl.dsp.window.resize({ x = -50, y = 0, relative = true }))
hl.bind(mainMod .. " + CTRL + right", hl.dsp.window.resize({ x = 50, y = 0, relative = true }))
hl.bind(mainMod .. " + CTRL + up", hl.dsp.window.resize({ x = 0, y = -50, relative = true }))
hl.bind(mainMod .. " + CTRL + down", hl.dsp.window.resize({ x = 0, y = 50, relative = true }))

-- Move/Resize with Mouse
hl.bind(mainMod .. " + mouse:272", hl.dsp.window.drag(), { mouse = true })
hl.bind(mainMod .. " + mouse:273", hl.dsp.window.resize(), { mouse = true })

-- ---------------- Workspace Management ----------------

-- Special Workspace
hl.bind(mainMod .. " + SHIFT + U", hl.dsp.window.move({ workspace = "special:special" }))
hl.bind(mainMod .. " + U", hl.dsp.workspace.toggle_special("special"))

for i = 1, 10 do
    local key = i % 10 -- 10 maps to key 0
    -- Switch Workspaces
    hl.bind(mainMod .. " + " .. key, hl.dsp.focus({ workspace = i }))
    -- Move to Workspaces
    hl.bind(mainMod .. " + CTRL + " .. key, hl.dsp.window.move({ workspace = i, follow = true }))
    -- Move to Workspaces (Silent)
    hl.bind(mainMod .. " + SHIFT + " .. key, hl.dsp.window.move({ workspace = i, follow = false }))
end

hl.bind(mainMod .. " + period", hl.dsp.focus({ workspace = "e+1" }))
hl.bind(mainMod .. " + comma", hl.dsp.focus({ workspace = "e-1" }))

-- ---------------- Multimedia Controls ----------------

-- Brightness
hl.bind("XF86MonBrightnessUp", exec("brightnessctl set 5%+"), { repeating = true, locked = true })
hl.bind("XF86MonBrightnessDown", exec("brightnessctl set 5%-"), { repeating = true, locked = true })

-- Audio mapping
hl.bind("XF86AudioRaiseVolume", exec(scriptsDir .. "/Volume.sh --inc"), { repeating = true })
hl.bind("XF86AudioLowerVolume", exec(scriptsDir .. "/Volume.sh --dec"), { repeating = true })
hl.bind("XF86AudioMute", exec(scriptsDir .. "/Volume.sh --toggle"), { repeating = true })
hl.bind(mainMod .. " + ALT + A", exec(scriptsDir .. "/ToggleAudioOutput.sh"))

-- Media
hl.bind("XF86AudioPlayPause", exec(scriptsDir .. "/MediaControl.sh --pause"))
hl.bind("XF86AudioPause", exec(scriptsDir .. "/MediaControl.sh --pause"))
hl.bind("XF86AudioPlay", exec(scriptsDir .. "/MediaControl.sh --pause"))
hl.bind("XF86AudioNext", exec(scriptsDir .. "/MediaControl.sh --nxt"))
hl.bind("XF86AudioPrev", exec(scriptsDir .. "/MediaControl.sh --prv"))
hl.bind("XF86AudioStop", exec(scriptsDir .. "/MediaControl.sh --stop"))

-- ---------------- Screenshot ----------------
hl.bind(mainMod .. " + SHIFT + S", exec("hyprshot -m region --raw | swappy -f -"))
hl.bind("Print", exec("hyprshot -m region --raw | swappy -f -"))

-- ---------------- Misc ----------------

-- Clip Manager
hl.bind(mainMod .. " + V", exec(scriptsDir .. "/ClipManager.sh"))

-- Swaync
hl.bind(mainMod .. " + N", exec("swaync-client -t -sw"))

-- Window Cycle
hl.bind("ALT + Tab", function()
    hl.dispatch(hl.dsp.window.cycle_next())
    hl.dispatch(hl.dsp.window.alter_zorder({ mode = "top" }))
end)

-- Hyprlock
-- hl.bind(mainMod .. " + L", exec("hyprlock -c ~/.config/hypr/hyprlock.conf"))

-- Home and End for laptop
hl.bind("SUPER + CTRL + Left", hl.dsp.send_shortcut({ mods = "", key = "Home" }))
hl.bind("SUPER + CTRL + Right", hl.dsp.send_shortcut({ mods = "", key = "End" }))
