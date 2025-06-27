-- Remap Shift+Enter to Ctrl+J only in Warp terminal
local warpShiftEnterRemap = hs.hotkey.bind({"shift"}, "return", function()
    local frontApp = hs.application.frontmostApplication()
    if frontApp and frontApp:name() == "Warp" then
        -- Send Ctrl+J to Warp
        hs.eventtap.keyStroke({"ctrl"}, "j")
    else
        -- Pass through original Shift+Return for other apps
        hs.eventtap.keyStroke({"shift"}, "return")
    end
end)