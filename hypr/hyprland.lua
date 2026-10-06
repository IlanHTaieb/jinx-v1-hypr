-- Hyprland Lua config (>= 0.55)
-- See https://wiki.hypr.land/configuring/
--
-- Each module lives in its own folder as `<name>/init.lua`, so `require("<name>")` loads it.
-- Errors inside a module are isolated by Hyprland, but a *missing* module throws for real,
-- so every module goes through `safe_require` instead of a bare `require`.

-- Global on purpose: modules can use it too (e.g. keybindings loading programs)
function safe_require(name)
    local ok, result = pcall(require, name)
    if ok then
        return result
    end

    print("[config] failed to load module '" .. name .. "': " .. tostring(result))
    hl.notification.create({
        text    = "Config Hyprland : impossible de charger le module '" .. name .. "'",
        timeout = 10000,
    })
    return nil
end

safe_require("monitor")
safe_require("programs")
safe_require("autostart")
safe_require("environment")
safe_require("permissions")
safe_require("lookandfeel")
safe_require("input")
safe_require("keybindings")
safe_require("workspaces")
