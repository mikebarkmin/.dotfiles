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
-- choose the theme from the output under the pointer, independently of focus.
-- Use lime on the smartboard and the right-hand USB-C hub monitor; amber
-- stays on the laptop and left-hand monitor. Match descriptions since the
-- hub's DP output names can change when reconnecting.
local CURSOR_SIZE       = 32
local CURSOR_DEFAULT    = "Bibata-Modern-Amber"
local CURSOR_SECONDARY  = "Bibata-Modern-Lime"
local SMARTBOARD_DESC   = "IWB PC Monitor"
local EXTERNAL_RIGHT_DESC = "BNQ BenQ RL2460H KCF01940SL0"

local current_cursor = nil

local function apply_monitor_cursor()
    local m = hl.get_monitor_at_cursor()
    if not m then return end

    local theme = CURSOR_DEFAULT
    if m.description and (
        m.description:find(SMARTBOARD_DESC, 1, true)
        or m.description:find(EXTERNAL_RIGHT_DESC, 1, true)
    ) then
        theme = CURSOR_SECONDARY
    end
    if theme ~= current_cursor then
        current_cursor = theme
        hl.exec_cmd("hyprctl setcursor " .. theme .. " " .. CURSOR_SIZE)
    end
end

hl.on("monitor.focused", apply_monitor_cursor)
-- Slow crossings need not trigger a usable focus event. This check runs
-- inside Hyprland; setcursor is only spawned when the theme actually changes.
hl.timer(apply_monitor_cursor, { timeout = 50, type = "repeat" })
hl.on("config.reloaded", function()
    current_cursor = nil
    apply_monitor_cursor()
end)
