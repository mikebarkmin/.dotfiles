local LAPTOP      = "eDP-1"
local EXTERNAL_1  = "BNQ BenQ BL2405 H4H02869SL0"
local EXTERNAL_2  = "BNQ BenQ RL2460H KCF01940SL0"
local BEAMER      = "HDMI-A-1"
local TOUCHSCREEN = "IWB PC Monitor"

local LOG_FILE = "/tmp/hyprland-monitors.log"

local function log(msg)
    local f = io.open(LOG_FILE, "a")
    if f then
        f:write(os.date("%Y-%m-%d %H:%M:%S") .. " - " .. msg .. "\n")
        f:close()
    end
end

-- Match by monitor name or description substring
local function is_connected(identifier)
    for _, m in ipairs(hl.get_monitors()) do
        if m.name == identifier or (m.description and m.description:find(identifier, 1, true)) then
            return true
        end
    end
    return false
end

local function configure_external()
    log("Configuring dual external setup (laptop disabled)")
    hl.monitor({ output = LAPTOP,     disabled = true })
    hl.monitor({ output = EXTERNAL_1, mode = "1920x1080@60", position = "0x0",    scale = 1 })
    hl.monitor({ output = EXTERNAL_2, mode = "1920x1080@60", position = "1920x0", scale = 1 })
end

local function configure_laptop()
    log("Configuring laptop-only setup")
    hl.monitor({ output = LAPTOP,     mode = "1920x1200@60", position = "0x0", scale = 1 })
    hl.monitor({ output = EXTERNAL_1, disabled = true })
    hl.monitor({ output = EXTERNAL_2, disabled = true })
end

local function configure_beamer()
    log("Configuring beamer mode (eDP-1 mirrored to HDMI-A-1)")
    hl.monitor({ output = LAPTOP,     mode = "1920x1200@60", position = "0x0", scale = 1 })
    hl.monitor({ output = BEAMER,     mode = "preferred",    position = "auto", scale = 1, mirror = LAPTOP })
    hl.monitor({ output = EXTERNAL_1, disabled = true })
    hl.monitor({ output = EXTERNAL_2, disabled = true })
end

-- The IWB touchscreen (DP-2) runs at 3840x2160.
-- Touch input remapping should be handled via a libinput/udev rule
-- mapping the touch device to the eDP-1 workspace.
local function configure_touchscreen()
    log("Configuring touchscreen mode (eDP-1 primary, IWB extended at 4K)")
    hl.monitor({ output = LAPTOP,      mode = "1920x1200@60", position = "0x0",    scale = 1 })
    hl.monitor({ output = TOUCHSCREEN, mode = "3840x2160@60", position = "1920x0", scale = 1 })
    hl.monitor({ output = EXTERNAL_1,  disabled = true })
    hl.monitor({ output = EXTERNAL_2,  disabled = true })
    hl.monitor({ output = BEAMER,      disabled = true })
end

local function apply()
    local beamer      = is_connected(BEAMER)
    local touchscreen = is_connected(TOUCHSCREEN)
    local ext1        = is_connected(EXTERNAL_1)
    local ext2        = is_connected(EXTERNAL_2)

    log(string.format(
        "Monitor status — BenQ1: %s, BenQ2: %s, Beamer: %s, IWB: %s",
        tostring(ext1), tostring(ext2), tostring(beamer), tostring(touchscreen)
    ))

    -- Priority: Beamer > Touchscreen > Dual external > Laptop only
    if beamer then
        configure_beamer()
    elseif touchscreen then
        configure_touchscreen()
    elseif ext1 and ext2 then
        configure_external()
    else
        configure_laptop()
    end
end

hl.on("monitor.added",   function(_) apply() end)
hl.on("monitor.removed", function(_) apply() end)
hl.on("config.reloaded", apply)

