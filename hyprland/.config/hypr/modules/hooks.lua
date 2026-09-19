hl.on("config.reloaded", function()
    -- Re-apply the *active* theme's GTK settings. Previously this hardcoded
    -- prefer-dark, which silently undid the theme switcher (the switcher runs
    -- `hyprctl reload`, which fires this hook right after it sets light mode).
    hl.exec_cmd(os.getenv("HOME") .. "/.local/dbin/theme-apply-gtk")
end)
