---------------------
---- KEYBINDINGS ----
---------------------

-- See https://wiki.hypr.land/configuring/core/binds/

local programs = safe_require("programs") or {}

local mainMod = "SUPER" -- Sets "Windows" key as main modifier

-- App launchers (a missing program is simply skipped instead of breaking the file)
local launchers = {
    Q = programs.terminal,
    E = programs.fileManager,
    R = programs.menu,
    L = programs.powermenu,
    B = programs.browser,
}
for key, cmd in pairs(launchers) do
    hl.bind(mainMod .. " + " .. key, hl.dsp.exec_cmd(cmd))
end

hl.bind(mainMod .. " + C", hl.dsp.window.close())
hl.bind(mainMod .. " + M", hl.dsp.exit())
hl.bind(mainMod .. " + V", hl.dsp.window.float({ action = "toggle" }))
hl.bind(mainMod .. " + P", hl.dsp.window.pseudo())         -- dwindle
hl.bind(mainMod .. " + J", hl.dsp.layout("togglesplit"))   -- dwindle

-- Move focus with mainMod + arrow keys
hl.bind(mainMod .. " + left",  hl.dsp.focus({ direction = "left" }))
hl.bind(mainMod .. " + right", hl.dsp.focus({ direction = "right" }))
hl.bind(mainMod .. " + up",    hl.dsp.focus({ direction = "up" }))
hl.bind(mainMod .. " + down",  hl.dsp.focus({ direction = "down" }))

-- Switch workspaces with mainMod + [1-0] (AZERTY keys)
-- Move active window to a workspace with mainMod + SHIFT + [1-0]
local workspaceKeys = {
    "ampersand", "eacute", "quotedbl", "apostrophe", "parenleft",
    "minus", "egrave", "underscore", "ccedilla", "agrave",
}
for i, key in ipairs(workspaceKeys) do
    hl.bind(mainMod .. " + " .. key,         hl.dsp.focus({ workspace = i }))
    hl.bind(mainMod .. " + SHIFT + " .. key, hl.dsp.window.move({ workspace = i }))
end

-- Special workspace (scratchpad)
hl.bind(mainMod .. " + S",         hl.dsp.workspace.toggle_special("magic"))
hl.bind(mainMod .. " + SHIFT + S", hl.dsp.window.move({ workspace = "special:magic" }))

-- Scroll through existing workspaces with mainMod + scroll
hl.bind(mainMod .. " + mouse_down", hl.dsp.focus({ workspace = "e+1" }))
hl.bind(mainMod .. " + mouse_up",   hl.dsp.focus({ workspace = "e-1" }))

-- Cycle through workspaces 1-10 with wraparound (ALT + q / ALT + w)
local function cycleWorkspace(step)
    local current = hl.get_active_workspace()
    if not current then
        return
    end
    local target = (current.id - 1 + step) % 10 + 1
    hl.dispatch(hl.dsp.focus({ workspace = target }))
end
hl.bind("ALT + q", function() cycleWorkspace(-1) end)
hl.bind("ALT + w", function() cycleWorkspace(1) end)

-- Move/resize windows with mainMod + LMB/RMB and dragging
hl.bind(mainMod .. " + mouse:272", hl.dsp.window.drag(),   { mouse = true })
hl.bind(mainMod .. " + mouse:273", hl.dsp.window.resize(), { mouse = true })

-- Laptop multimedia keys for volume and LCD brightness
hl.bind("XF86AudioRaiseVolume",  hl.dsp.exec_cmd("wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%+"), { locked = true, repeating = true })
hl.bind("XF86AudioLowerVolume",  hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"),      { locked = true, repeating = true })
hl.bind("XF86AudioMute",         hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"),     { locked = true, repeating = true })
hl.bind("XF86AudioMicMute",      hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"),   { locked = true, repeating = true })
hl.bind("XF86MonBrightnessUp",   hl.dsp.exec_cmd("brightnessctl -e4 -n2 set 5%+"),                  { locked = true, repeating = true })
hl.bind("XF86MonBrightnessDown", hl.dsp.exec_cmd("brightnessctl -e4 -n2 set 5%-"),                  { locked = true, repeating = true })

-- Requires playerctl
hl.bind("XF86AudioNext",  hl.dsp.exec_cmd("playerctl next"),       { locked = true })
hl.bind("XF86AudioPause", hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioPlay",  hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioPrev",  hl.dsp.exec_cmd("playerctl previous"),   { locked = true })

-- Screenshots
hl.bind("CTRL + Print",         hl.dsp.exec_cmd("slurp | grim -g - - | wl-copy"))
hl.bind("SHIFT + Print",        hl.dsp.exec_cmd("grim ~/Images/Screenshots/screenshot-$(date +'%Y-%m-%d_%H-%M-%S').png"))
hl.bind("CTRL + SHIFT + Print", hl.dsp.exec_cmd("slurp | grim -g - ~/Images/Screenshots/screenshot-$(date +'%Y-%m-%d_%H-%M-%S').png"))
