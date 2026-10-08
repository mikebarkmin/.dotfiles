hl.on("config.reloaded", function()
    -- Re-apply the *active* theme's GTK settings. Previously this hardcoded
    -- prefer-dark, which silently undid the theme switcher (the switcher runs
    -- `hyprctl reload`, which fires this hook right after it sets light mode).
    hl.exec_cmd(os.getenv("HOME") .. "/.local/dbin/theme-apply-gtk")
end)

hl.on("config.reloaded", function()
    -- A reload re-applies the static smartboard monitor rule, which undoes the
    -- raised scale of classroom mode. No-op when classroom mode is off.
    hl.exec_cmd(os.getenv("HOME") .. "/.local/dbin/classroom-mode reapply-scale")
end)

-- Per-monitor cursor colour: Hyprland only has one global cursor theme, so
-- swap it whenever focus moves to another output (which follows the mouse).
local CURSOR_SIZE       = 32
local CURSOR_DEFAULT    = "Bibata-Modern-Amber"
local CURSOR_SMARTBOARD = "Bibata-Modern-Lime"
local SMARTBOARD_DESC   = "IWB PC Monitor"

local current_cursor = nil

local function apply_monitor_cursor()
    for _, m in ipairs(hl.get_monitors()) do
        if m.focused then
            local theme = CURSOR_DEFAULT
            if m.description and m.description:find(SMARTBOARD_DESC, 1, true) then
                theme = CURSOR_SMARTBOARD
            end
            if theme ~= current_cursor then
                current_cursor = theme
                hl.exec_cmd("hyprctl setcursor " .. theme .. " " .. CURSOR_SIZE)
            end
            return
        end
    end
end

hl.on("monitor.focused", apply_monitor_cursor)
hl.on("config.reloaded", function()
    current_cursor = nil
    apply_monitor_cursor()
end)
