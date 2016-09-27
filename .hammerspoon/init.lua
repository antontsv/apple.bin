
-- shift (⇧ ); control/crtl (⌃); option/alt (⌥ ); command/cmd (⌘ )
local scod = {"shift","ctrl","alt","cmd"}
local cd = {"ctrl","cmd"}
local cod = {"ctrl","alt","cmd"}

-- redshift to 2800K from 20:30->21:30
-- and back to standard 6:30->7:30
hs.redshift.start(2800,'21:00','7:00','1h')

function triggerReload()
    hs.reload()
end

--config reloading. manual (from getting started guide):
hs.hotkey.bind(cod, "R", triggerReload)

-- menu icon to access Mac's caffeine functions
local caffeine = hs.menubar.new()

function setCaffeineDisplay(state)
    local result
    if state then
        result = caffeine:setIcon("assets/stay-awake.pdf")
        caffeine:setTooltip("Caffeine is on - Mac won't sleep")
    else
        result = caffeine:setIcon("assets/can-sleep.pdf")
        caffeine:setTooltip("Caffeine is off - Mac is allowed to sleep")
    end
end

function caffeineClicked()
    setCaffeineDisplay(hs.caffeinate.toggle("displayIdle"))
end

if caffeine then
    caffeine:setClickCallback(caffeineClicked)
    -- enable caffeine and prevent sleep by default
    hs.caffeinate.set("displayIdle", true, true)
    setCaffeineDisplay(hs.caffeinate.get("displayIdle"))
end

-- watch & reload config automatically if changed
function reloadConfig(files)
    doReload = false
    for _,file in pairs(files) do
        if file:sub(-4) == ".lua" then
            doReload = true
        end
    end
    if doReload then
        triggerReload()
    end
end
hs.pathwatcher.new(os.getenv("HOME") .. "/.hammerspoon/", reloadConfig):start()
hs.pathwatcher.new(os.getenv("HOME") .. "/.homesick/repos/apple.bin/.hammerspoon/", reloadConfig):start()


-- Windows
-- Toggle a window regular frame and maximized on the screen
local savedFrameSizes = {}
function toggleMaximize()
    local win = hs.window.focusedWindow()
    if savedFrameSizes[win:id()] then
        win:setFrame(savedFrameSizes[win:id()])
        savedFrameSizes[win:id()] = nil
    else
        savedFrameSizes[win:id()] = win:frame()
        win:maximize()
    end
end
-- Control + Option + Command + F to maximize (different from full screen)
-- Note: Mac's Control + Command + F triggers app full-screen mode
hs.hotkey.bind(cod, "f", toggleMaximize)


-- Do some actions upon screen lock/unlock (including screen saver with password)
local caffeineUnmute=false
local caffeineItunesPlayPause=false
function caffeinateCallback(eventType)
    if (eventType == hs.caffeinate.watcher.screensDidLock) then
        caffeineItunesPlayPause = hs.itunes.isPlaying()
        if caffeineItunesPlayPause then
            hs.itunes.playpause() -- pause playing
        end
        local audioOutput = hs.audiodevice.defaultOutputDevice()
        caffeineUnmute = not audioOutput:muted()
        audioOutput:setMuted(true)
        -- remove all keys from ssh-agent
        hs.task.new("/usr/bin/ssh-add", function() end, function() return false end, {"-D"}):start()
    elseif (eventType == hs.caffeinate.watcher.screensDidUnlock) then
        if caffeineUnmute then
            hs.audiodevice.defaultOutputDevice():setMuted(false)
        end
        if caffeineItunesPlayPause then
            hs.itunes.playpause() -- resume playing
        end
    end
end

caffeinateWatcher = hs.caffeinate.watcher.new(caffeinateCallback)
caffeinateWatcher:start()

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

-- display alert when config is loaded
hs.alert.show("Hammerspoon config - OK", 1)
