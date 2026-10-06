-------------------
---- AUTOSTART ----
-------------------

-- See https://wiki.hypr.land/configuring/core/autostart/

-- Equivalent of `exec-once`: runs only when Hyprland starts
-- Never call hl.exec_cmd at top level: it runs while the config is parsed,
-- before the compositor and monitors exist (awww-daemon crashes on that)
hl.on("hyprland.start", function()
    hl.exec_cmd("waybar -c ~/.config/waybar/config.jsonc")
    hl.exec_cmd("mako -c ~/.config/mako/config")

    -- Starts awww-daemon and restores both monitors (see ~/.config/waypaper/config.ini)
    hl.exec_cmd("waypaper --restore")

    -- hl.exec_cmd("~/.config/hypr/scripts/launch-waybar.sh")
    -- hl.exec_cmd("swww img -o DP-3 ~/Images/waypaper/fearless-jinx.gif")
    -- hl.exec_cmd("nm-applet")
end)
