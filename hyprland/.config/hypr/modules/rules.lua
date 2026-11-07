-- Workspace rules
hl.workspace_rule({
    workspace = "10",
    gaps_in = 5,
    gaps_out = 0,
    no_border = true,
})

-- Launch programs when a workspace is created empty. Replaces the old
-- on_created_empty workspace rule field.
-- https://wiki.hypr.land/configuring/code-snippets/#launching-programs-on-workspace-creation
local workspace_programs = {
    ["special:terminal"] = { "kitty", { float = true, size = "1000 800", center = true } },
}

hl.on("workspace.created", function(ws)
    if not ws.is_empty then return end

    local program = ws.id and workspace_programs[tostring(ws.id)]
        or workspace_programs[ws.name]
    if program == nil then return end

    local cmd, provided_rules = table.unpack(program)
    -- shallow-copy the rules table so we can add the workspace to it
    local rules = {}
    if provided_rules ~= nil then
        for key, value in pairs(provided_rules) do rules[key] = value end
    end
    -- force the program onto the created workspace, even if focus moves
    -- elsewhere before its window appears
    rules.workspace = (ws.id and tostring(ws.id) or ws.name) .. " silent"
    hl.exec_cmd(cmd, rules)
end)

-- Window rules
hl.window_rule({
    name = "suppress-maximize-events",
    match = { class = ".*" },
    -- Ignore maximize requests from all apps
    suppress_event = "maximize",
})

hl.window_rule({
    name = "fix-xwayland-drags",
    match = {
        class = "^$",
        title = "^$",
        xwayland = true,
        float = true,
        fullscreen = false,
        pin = false,
    },
    -- Fix some dragging issues with XWayland
    -- TODO: manual review — unmapped window rule action: "no_focus true"
})

hl.window_rule({
    name = "waydroid",
    match = { class = "waydroid.*" },
})

-- SchILD-NRW 3 (Wine/Bottles): Delphi's invisible TApplication window shows up
-- as an empty white window under Wine/XWayland -> park it on a hidden special workspace.
hl.window_rule({
    name = "schild-hide-tapplication",
    match = { class = "^schild30\\.exe$", title = "^SchILD-NRW 3$" },
    workspace = "special:schild-hidden silent",
    no_initial_focus = true,
})

-- Prusa Live Stream Overlay
hl.window_rule({
    name = "prusa-stream-overlay",
    match = { title = "^prusa-live-float$" },
    float = true,
    size = "800 600",
    center = true,
    pin = true, -- Optional: Keeps the camera feed pinned on top of other windows
})
