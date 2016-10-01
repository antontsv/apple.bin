require "modules.autoloader"
require "modules.caffeinator"
require "modules.screenLockWatcher"
require "modules.windowController"

-- watches Lua files
-- provides short-cuts to reload Hammerspoon config
Autoloader()

-- prevent Mac from sleeping,
-- it should also create Moon-like menu icon
Caffeinator()

-- performs actions upon screen lock:
-- mute audio, remove identities from SSH-agent, etc.
ScreenLockWatcher()

-- Controls focused window size and movement
-- though several keyboard combinations
WindowController()

-- shift (⇧ ); control/crtl (⌃); option/alt (⌥ ); command/cmd (⌘ )
local scod = {"shift","ctrl","alt","cmd"}
local cd = {"ctrl","cmd"}
local cod = {"ctrl","alt","cmd"}

-- redshift to 2800K from 20:30->21:30
-- and back to standard 6:30->7:30
hs.redshift.start(2800,'21:00','7:00','1h')



-- Simple short-cut to display alerts:
-- open -g 'hammerspoon://show_alert?text=Nice one!'
hs.urlevent.bind("show_alert", function(eventName, params)
  if params["text"] then
    hs.alert.show(params["text"])
  end
end)

-- Simulate keystrokes on the field where paste is disabled
hs.hotkey.bind(cod, "v", function()
  hs.eventtap.keyStrokes(hs.pasteboard.getContents())
end)

hs.hotkey.bind(cod, "Left", function()
  local win = hs.window.focusedWindow()
  local f = win:frame()
  local screen = win:screen()
  local max = screen:frame()

  f.x = max.x
  f.y = max.y
  f.w = max.w / 2
  f.h = max.h
  win:setFrame(f)
end)

hs.hotkey.bind(cod, "Right", function()
  local win = hs.window.focusedWindow()
  local f = win:frame()
  local screen = win:screen()
  local max = screen:frame()

  f.x = max.x + (max.w / 2)
  f.y = max.y
  f.w = max.w / 2
  f.h = max.h
  win:setFrame(f)
end)

hs.hotkey.bind(cod, "Up", function()
  local win = hs.window.focusedWindow()
  local f = win:frame()
  local screen = win:screen()
  local max = screen:frame()

  f.x = max.x
  f.y = max.y
  f.w = max.w
  f.h = max.h /2 
  win:setFrame(f)
end)


hs.hotkey.bind(cod, "Down", function()
  local win = hs.window.focusedWindow()
  local f = win:frame()
  local screen = win:screen()
  local max = screen:frame()

  f.x = max.x
  f.y = max.y + (max.h / 2)
  f.w = max.w
  f.h = max.h /2
  win:setFrame(f)
end)

hs.hotkey.bind(cod, "]", function()
  local win = hs.window.focusedWindow()
  local f = win:frame()
  local screen = win:screen()
  local max = screen:frame()
  f.w = f.w + 10 
  win:setFrame(f)
end)

hs.hotkey.bind(cod, "[", function()
  local win = hs.window.focusedWindow()
  local f = win:frame()
  local screen = win:screen()
  local max = screen:frame()

  f.w = f.w - 10
  win:setFrame(f)
end)

hs.hotkey.bind(cod, "0", function()
  local win = hs.window.focusedWindow()
  local f = win:frame()
  local screen = win:screen()
  local max = screen:frame()

  f.x = max.x + (max.w / 4)
  f.y = max.y + (max.h / 4)
  f.w = max.w / 2
  f.h = max.h / 2
  win:setFrame(f)
end)

-- display alert when config is loaded
hs.alert.show("Hammerspoon config - OK", 1)
