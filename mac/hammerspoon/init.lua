-- init.lua

-- Brings the Terminal app into focus or launches it if not running
hs.hotkey.bind({"cmd", "alt"}, "t", function()
  local script = [[
    tell application "Terminal"
    do script ""
    activate
    end tell
  ]]

  local success = hs.osascript.applescript(script)

  if not success then
    local terminal = hs.application.get("Terminal")
    if terminal then
      terminal:selectMenuItem({"Shell", "New Window"})
      terminal:activate()
    else
      hs.application.launchOrFocus("Terminal")
    end
  end
end)


-- Launches Terminal or brings an existing Terminal window into focus
hs.hotkey.bind({"ctrl", "cmd"}, "t", function()
  hs.application.launchOrFocus("Terminal")
end)

-- Closes the currently focused Terminal window
hs.hotkey.bind({"cmd", "shift"}, "w", function()
  local app = hs.application.find("Terminal")

  if app and app:isFrontmost() then
    hs.osascript.applescript([[
      tell application "Terminal"
        close front window
      end tell
    ]])
  end
end)
