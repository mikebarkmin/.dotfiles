local LAPTOP      = "eDP-1"
local EXTERNAL_1  = "desc:BNQ BenQ BL2405 H4H02869SL0"
local EXTERNAL_2  = "desc:BNQ BenQ RL2460H KCF01940SL0"
local BEAMER      = "HDMI-A-1"
local TOUCHSCREEN = "desc:IWB PC Monitor"
local LOG_FILE    = "/tmp/hyprland-monitors.log"

local last_config  = nil

-- In split modes, workspaces 1-5 live on the left monitor and 6-10 on the
-- right one. Each mode's rules are only enabled while that mode is active so
-- the other setups keep Hyprland's default placement.
local LEFT_WORKSPACES  = { 1, 2, 3, 4, 5 }
local RIGHT_WORKSPACES = { 6, 7, 8, 9, 10 }

local WORKSPACE_SPLITS = {
    touchscreen = { left = LAPTOP,     right = TOUCHSCREEN },
    external    = { left = EXTERNAL_1, right = EXTERNAL_2 },
}

local split_rules = {}
for config, split in pairs(WORKSPACE_SPLITS) do
    split_rules[config] = {}
    for _, id in ipairs(LEFT_WORKSPACES) do
        table.insert(split_rules[config], hl.workspace_rule({ workspace = tostring(id), monitor = split.left, enabled = false }))
    end
    for _, id in ipairs(RIGHT_WORKSPACES) do
        table.insert(split_rules[config], hl.workspace_rule({ workspace = tostring(id), monitor = split.right, enabled = false }))
    end
end

local function log(msg)
    local f = io.open(LOG_FILE, "a")
    if f then
        f:write(os.date("%Y-%m-%d %H:%M:%S") .. " - " .. msg .. "\n")
        f:close()
    end
end

local function find_monitor(identifier)
    local stripped_identifier = identifier:match(":(.+)") or identifier
    for _, m in ipairs(hl.get_monitors()) do
        if m.name == stripped_identifier or (m.description and m.description:find(stripped_identifier, 1, true)) then
            return m
        end
    end
    return nil
end

local function is_connected(identifier)
    return find_monitor(identifier) ~= nil
end

-- Touch/stylus input defaults to the *focused* monitor ("current"), so on the
-- IWB board touches get mapped onto eDP-1 whenever it has focus. Pin them.
local function bind_touch_input(output)
    hl.config({ input = { touchdevice = { output = output }, tablet = { output = output } } })
end

-- Rules only affect newly created workspaces, so move the existing ones over.
local function move_existing_workspaces(ids, identifier)
    local monitor = find_monitor(identifier)
    if not monitor then
        log("Cannot move workspaces, monitor not found: " .. identifier)
        return
    end
    for _, id in ipairs(ids) do
        if hl.get_workspace(id) then
            hl.dispatch(hl.dsp.workspace.move({ workspace = tostring(id), monitor = monitor.name }))
        end
    end
end

-- Enable the workspace split for `config` (if it has one) and disable all others.
local function apply_workspace_split(config)
    for name, rules in pairs(split_rules) do
        for _, rule in ipairs(rules) do
            rule:set_enabled(name == config)
        end
    end

    local split = WORKSPACE_SPLITS[config]
    if not split then return end

    -- Give the modeset a moment before moving workspaces around.
    hl.timer(function()
        move_existing_workspaces(LEFT_WORKSPACES, split.left)
        move_existing_workspaces(RIGHT_WORKSPACES, split.right)
    end, { timeout = 500, type = "oneshot" })
end

local function configure_external()
    log("Configuring dual external setup (laptop disabled)")
    hl.monitor({ output = LAPTOP,     disabled = true })
    hl.monitor({ output = EXTERNAL_1, mode = "1920x1080@60", position = "0x0",    scale = 1 })
    hl.monitor({ output = EXTERNAL_2, mode = "1920x1080@60", position = "1920x0", scale = 1 })
end

local function configure_laptop()
    log("Configuring laptop-only setup")
    hl.monitor({ output = LAPTOP, mode = "1920x1200@60", position = "0x0", scale = 1, disabled = false })
    bind_touch_input("current")
end

local function configure_beamer()
    log("Configuring beamer mode (eDP-1 mirrored to HDMI-A-1)")
    hl.monitor({ output = LAPTOP,     mode = "1920x1200@60", position = "0x0", scale = 1 })
    hl.monitor({ output = BEAMER,     mode = "preferred",    position = "auto", scale = 1, mirror = LAPTOP })
    hl.monitor({ output = EXTERNAL_1, disabled = true })
    hl.monitor({ output = EXTERNAL_2, disabled = true })
end

local function configure_touchscreen()
    log("Configuring touchscreen mode (eDP-1 primary, IWB extended at 4K@30)")
    hl.monitor({ output = LAPTOP,      mode = "1920x1200@60", position = "0x0",    scale = 1 })
    hl.monitor({ output = TOUCHSCREEN, mode = "3840x2160@30", position = "auto-right", scale = 2 })
    hl.monitor({ output = EXTERNAL_1,  disabled = true })
    hl.monitor({ output = EXTERNAL_2,  disabled = true })
    hl.monitor({ output = BEAMER,      disabled = true })

    local iwb = find_monitor(TOUCHSCREEN)
    if iwb then
        log("Binding touch/tablet input to " .. iwb.name)
        bind_touch_input(iwb.name)
    end
end

local function get_config_name()
    local beamer      = is_connected(BEAMER)
    local touchscreen = is_connected(TOUCHSCREEN)
    local ext1        = is_connected(EXTERNAL_1)
    local ext2        = is_connected(EXTERNAL_2)
    if beamer then             return "beamer"
    elseif touchscreen then    return "touchscreen"
    elseif ext1 and ext2 then  return "external"
    else                       return "laptop"
    end
end

local function apply(event)
    local ext1        = is_connected(EXTERNAL_1)
    local ext2        = is_connected(EXTERNAL_2)
    local beamer      = is_connected(BEAMER)
    local touchscreen = is_connected(TOUCHSCREEN)

    log(string.format(
        "Monitor status (%s) — BenQ1: %s, BenQ2: %s, Beamer: %s, IWB: %s",
        tostring(event), tostring(ext1), tostring(ext2), tostring(beamer), tostring(touchscreen)
    ))

    local config = get_config_name()

    if config == last_config then
        log("No config change (still: " .. config .. "), skipping")
        return
    end

    last_config = config

    if config == "beamer" then
        configure_beamer()
    elseif config == "touchscreen" then
        configure_touchscreen()
    elseif config == "external" then
        configure_external()
    else
        configure_laptop()
    end

    apply_workspace_split(config)
end

hl.on("monitor.added",   function(_) apply("added") end)
hl.on("monitor.removed", function(_) apply("removed") end)
hl.on("config.reloaded", function(_) apply("reloaded") end)

-- Static rule so the very first modeset on hotplug (before the hook above runs)
-- already uses 30 Hz; 4K@60 is flaky over the USB-C hub.
hl.monitor({ output = TOUCHSCREEN, mode = "3840x2160@30", position = "auto-right", scale = 2 })
