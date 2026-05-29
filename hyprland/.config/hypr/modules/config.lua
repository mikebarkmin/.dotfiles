local theme = require("mocha")

-- See https://wiki.hyprland.org/Configuring/Variables/
hl.config({
    general = {
        gaps_in = 5,
        gaps_out = 10,
        border_size = 2,
        col = {
            active_border = theme.mauve,
            inactive_border = theme.surface0,
        },
        resize_on_border = true,
        allow_tearing = false,
        layout = "dwindle",
    },
    group = {
        col = {
            border_active = theme.yellow,
            border_inactive = theme.surface0,
        },
        groupbar = {
            enabled = true,
            font_size = 12,
            height = 20,
            indicator_height = 4,
            stacked = false,
            col = {
                active = theme.yellow,
                inactive = theme.surface0,
            },
        },
    },
    -- https://wiki.hyprland.org/Configuring/Variables/#decoration
    decoration = {
        rounding = 0,
        rounding_power = 0,
        active_opacity = 1.0,
        inactive_opacity = 1.0,
        shadow = {
            enabled = false,
            range = 4,
            render_power = 3,
            color = theme.surface1,
            color_inactive = theme.surface1,
        },
        -- https://wiki.hyprland.org/Configuring/Variables/#blur
        blur = {
            enabled = false,
            size = 3,
            passes = 1,
            vibrancy = 0.1696,
        },
    },
    -- https://wiki.hyprland.org/Configuring/Variables/#animations
    animations = {
        enabled = true,
    },
    dwindle = {
        preserve_split = true,
    },
    scrolling = {
        fullscreen_on_one_column = true,
        column_width = 0.6,
        direction = "right",
        follow_focus = false,
    },
    -- See https://wiki.hyprland.org/Configuring/Master-Layout/
    master = {
        new_status = "master",
    },
    -- https://wiki.hyprland.org/Configuring/Variables/#misc
    misc = {
        force_default_wallpaper = 0,
        disable_hyprland_logo = true,
    },
    -- https://wiki.hyprland.org/Configuring/Variables/#input
    input = {
        resolve_binds_by_sym = 1,
        kb_layout = "de",
        kb_variant = "nodeadkeys",
        kb_model = "",
        kb_options = "caps:escape",
        kb_rules = "",
        follow_mouse = 1,
        sensitivity = 0,
        touchpad = {
            natural_scroll = true,
            tap_to_click = false,
            disable_while_typing = false,
        },
        tablet = {
            output = "current"
        },
    },
})
