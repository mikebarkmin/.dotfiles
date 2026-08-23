local mainMod = "SUPER"

local terminal = "kitty"
local menu = "rofi -show drun"
local emoji = "rofi -modi emoji -show emoji"

-- General
hl.bind(mainMod .. " + Return",       hl.dsp.exec_cmd(terminal))
hl.bind(mainMod .. " + Q",            hl.dsp.window.close())
hl.bind(mainMod .. " + SPACE",        hl.dsp.window.float({ action = "toggle" }))
hl.bind(mainMod .. " + F",            hl.dsp.window.fullscreen(""))
hl.bind(mainMod .. " + D",            hl.dsp.exec_cmd(menu))
hl.bind(mainMod .. " + R",            hl.dsp.exec_cmd(emoji))
hl.bind(mainMod .. " + P",            hl.dsp.window.pseudo())
hl.bind(mainMod .. " + V",            hl.dsp.layout("togglesplit"))
hl.bind(mainMod .. " + N",            hl.dsp.exec_cmd("swaync-client -t"))
hl.bind(mainMod .. " + SHIFT + DELETE", hl.dsp.exec_cmd("hyprctl dispatch exit,"))
hl.bind(mainMod .. " + SHIFT + P",   hl.dsp.exec_cmd("hyprpicker -a"))
hl.bind(mainMod .. " + SHIFT + C",   hl.dsp.exec_cmd("rofi -modi clipboard:~/.local/dbin/cliphist-rofi-img -show clipboard -show-icons"))
hl.bind(mainMod .. " + SHIFT + S",   hl.dsp.exec_cmd("~/.local/dbin/rofi-state-switcher"))
hl.bind(mainMod .. " + SHIFT + A",   hl.dsp.exec_cmd("~/.local/dbin/rofi-audio-output-switcher"))
hl.bind(mainMod .. " + SHIFT + F",   hl.dsp.exec_cmd("~/.local/dbin/rofi-finder"))
hl.bind(mainMod .. " + SHIFT + R",   hl.dsp.exec_cmd("killall -SIGUSR2 waybar"))
hl.bind("print",                      hl.dsp.exec_cmd("~/.local/dbin/rofi-screenshot"))

-- Focus
hl.bind(mainMod .. " + h", hl.dsp.focus({ direction = "left" }))
hl.bind(mainMod .. " + l", hl.dsp.focus({ direction = "right" }))
hl.bind(mainMod .. " + k", hl.dsp.focus({ direction = "up" }))
hl.bind(mainMod .. " + j", hl.dsp.focus({ direction = "down" }))

-- Move windows
hl.bind(mainMod .. " + SHIFT + h", hl.dsp.window.move({ direction = "l" }))
hl.bind(mainMod .. " + SHIFT + l", hl.dsp.window.move({ direction = "r" }))
hl.bind(mainMod .. " + SHIFT + k", hl.dsp.window.move({ direction = "u" }))
hl.bind(mainMod .. " + SHIFT + j", hl.dsp.window.move({ direction = "d" }))

-- Switch workspace
hl.bind(mainMod .. " + 1", hl.dsp.focus({ workspace = 1 }))
hl.bind(mainMod .. " + 2", hl.dsp.focus({ workspace = 2 }))
hl.bind(mainMod .. " + 3", hl.dsp.focus({ workspace = 3 }))
hl.bind(mainMod .. " + 4", hl.dsp.focus({ workspace = 4 }))
hl.bind(mainMod .. " + 5", hl.dsp.focus({ workspace = 5 }))
hl.bind(mainMod .. " + 6", hl.dsp.focus({ workspace = 6 }))
hl.bind(mainMod .. " + 7", hl.dsp.focus({ workspace = 7 }))
hl.bind(mainMod .. " + 8", hl.dsp.focus({ workspace = 8 }))
hl.bind(mainMod .. " + 9", hl.dsp.focus({ workspace = 9 }))
hl.bind(mainMod .. " + 0", hl.dsp.focus({ workspace = 10 }))

-- Layout
hl.bind(mainMod .. " + period",       hl.dsp.layout("move +col"))
hl.bind(mainMod .. " + comma",        hl.dsp.layout("move -col"))
hl.bind(mainMod .. " + SHIFT + period", hl.dsp.layout("swapcol r"))
hl.bind(mainMod .. " + SHIFT + comma", hl.dsp.layout("swapcol l"))

-- Move window to workspace
hl.bind(mainMod .. " + SHIFT + 1",  hl.dsp.window.move({ workspace = 1 }))
hl.bind(mainMod .. " + SHIFT + 2",  hl.dsp.window.move({ workspace = 2 }))
hl.bind(mainMod .. " + SHIFT + 3",  hl.dsp.window.move({ workspace = 3 }))
hl.bind(mainMod .. " + SHIFT + 4",  hl.dsp.window.move({ workspace = 4 }))
hl.bind(mainMod .. " + SHIFT + 5",  hl.dsp.window.move({ workspace = 5 }))
hl.bind(mainMod .. " + SHIFT + 6",  hl.dsp.window.move({ workspace = 6 }))
hl.bind(mainMod .. " + SHIFT + 7",  hl.dsp.window.move({ workspace = 7 }))
hl.bind(mainMod .. " + SHIFT + 8",  hl.dsp.window.move({ workspace = 8 }))
hl.bind(mainMod .. " + SHIFT + 9",  hl.dsp.window.move({ workspace = 9 }))
hl.bind(mainMod .. " + SHIFT + 0",  hl.dsp.window.move({ workspace = 10 }))

-- Zoom
hl.bind(mainMod .. " + SHIFT + mouse_down", hl.dsp.exec_cmd("hyprctl -q keyword cursor:zoom_factor $(hyprctl getoption cursor:zoom_factor -j | jq '.float * 1.1')"))
hl.bind(mainMod .. " + SHIFT + mouse_up",   hl.dsp.exec_cmd("hyprctl -q keyword cursor:zoom_factor $(hyprctl getoption cursor:zoom_factor -j | jq '(.float * 0.9) | if . < 1 then 1 else . end')"))
hl.bind(mainMod .. " + SHIFT + plus",  hl.dsp.exec_cmd("hyprctl -q keyword cursor:zoom_factor $(hyprctl getoption cursor:zoom_factor -j | jq '.float * 1.1')"), { repeating = true })
hl.bind(mainMod .. " + SHIFT + minus", hl.dsp.exec_cmd("hyprctl -q keyword cursor:zoom_factor $(hyprctl getoption cursor:zoom_factor -j | jq '(.float * 0.9) | if . < 1 then 1 else . end')"), { repeating = true })

-- Mouse window management
hl.bind(mainMod .. " + mouse:272", hl.dsp.window.drag(), { mouse = true })
hl.bind(mainMod .. " + mouse:273", hl.dsp.window.resize(), { mouse = true })

-- Media / brightness keys
hl.bind("XF86AudioRaiseVolume",  hl.dsp.exec_cmd("wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%+"),        { locked = true, repeating = true })
hl.bind("XF86AudioLowerVolume",  hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"),             { locked = true, repeating = true })
hl.bind("XF86AudioMute",         hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"),            { locked = true, repeating = true })
hl.bind("XF86AudioMicMute",      hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"),          { locked = true, repeating = true })
hl.bind("XF86MonBrightnessUp",   hl.dsp.exec_cmd("brightnessctl s 10%+"),                                  { locked = true, repeating = true })
hl.bind("XF86MonBrightnessDown", hl.dsp.exec_cmd("brightnessctl s 10%-"),                                  { locked = true, repeating = true })
hl.bind("XF86AudioNext",         hl.dsp.exec_cmd("playerctl next"),        { locked = true })
hl.bind("XF86AudioPause",        hl.dsp.exec_cmd("playerctl play-pause"),  { locked = true })
hl.bind("XF86AudioPlay",         hl.dsp.exec_cmd("playerctl play-pause"),  { locked = true })
hl.bind("XF86AudioPrev",         hl.dsp.exec_cmd("playerctl previous"),    { locked = true })

-- Special workspaces
hl.bind(mainMod .. " + S", hl.dsp.workspace.toggle_special("terminal"))
