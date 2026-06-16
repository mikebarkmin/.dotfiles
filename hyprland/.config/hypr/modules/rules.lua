-- Workspace rules
hl.workspace_rule({ workspace = "special:terminal", on_created_empty = "[float; size 1000 800; center] kitty" })

hl.workspace_rule({
    workspace = "10",
    gaps_in = 5,
    gaps_out = 0,
    no_border = true,
})

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

-- Prusa Live Stream Overlay
hl.window_rule({
    name = "prusa-stream-overlay",
    match = { title = "^prusa-live-float$" },
    float = true,
    size = "800 600",
    center = true,
    pin = true, -- Optional: Keeps the camera feed pinned on top of other windows
})
