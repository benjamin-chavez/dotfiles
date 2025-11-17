-- init.lua

-- Brings the Ghostty app into focus or launches it if not running
hs.hotkey.bind({"cmd", "alt"}, "t", function()
  local script = [[
    tell application "Ghostty"
      activate
    end tell
  ]]

  local success = hs.osascript.applescript(script)

  if not success then
    local ghostty = hs.application.get("Ghostty")
    if ghostty then
      ghostty:activate()
    else
      hs.application.launchOrFocus("Ghostty")
    end
  end
end)

-- Launches Ghostty or brings an existing Ghostty window into focus
hs.hotkey.bind({"ctrl", "cmd"}, "t", function()
  hs.application.launchOrFocus("Ghostty")
end)

-- Closes the currently focused Ghostty window
hs.hotkey.bind({"cmd", "shift"}, "w", function()
  local app = hs.application.find("Ghostty")

  if app and app:isFrontmost() then
    hs.osascript.applescript([[
      tell application "Ghostty"
        tell application "System Events"
          tell process "Ghostty"
            click menu item "Close Window" of menu "File" of menu bar 1
          end tell
        end tell
      end tell
    ]])
  end
end)

