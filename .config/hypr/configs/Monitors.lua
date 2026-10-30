-- Rules for outputs that are not plugged in are ignored, so desktop and laptop can share this file.

-- Desktop
hl.monitor({ output = "DP-1", mode = "3840x2160@120", position = "0x0", scale = 1.2 })
hl.monitor({ output = "DP-2", mode = "3840x2160", position = "auto", scale = 1.2 })

-- Laptop
hl.monitor({ output = "eDP-1", mode = "2880x1920@120", position = "0x0", scale = 1.2 })
