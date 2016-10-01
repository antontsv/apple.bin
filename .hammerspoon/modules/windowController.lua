function WindowController()
    local self={}

    local CTRL_OPT_CMD = {"ctrl","alt","cmd"}

    -- Windows
    -- Toggle a window regular frame and maximized on the screen
    local savedFrameSizes = {}
    function self.maximizeCurrent()
        local win = hs.window.focusedWindow()
        if savedFrameSizes[win:id()] then
            win:setFrame(savedFrameSizes[win:id()])
            savedFrameSizes[win:id()] = nil
        else
            savedFrameSizes[win:id()] = win:frame()
            win:maximize()
        end
    end

    -- Control + Option + Command + F to maximize
    -- Note: Mac's Control + Command + F triggers app full-screen mode
    hs.hotkey.bind(CTRL_OPT_CMD, "f", self.maximizeCurrent)

     hs.hotkey.bind(CTRL_OPT_CMD, "Left", function()
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

    hs.hotkey.bind(CTRL_OPT_CMD, "Right", function()
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

    hs.hotkey.bind(CTRL_OPT_CMD, "Up", function()
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

    hs.hotkey.bind(CTRL_OPT_CMD, "Down", function()
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

    hs.hotkey.bind(CTRL_OPT_CMD, "]", function()
      local win = hs.window.focusedWindow()
      local f = win:frame()
      local screen = win:screen()
      local max = screen:frame()
      f.w = f.w + 10 
      win:setFrame(f)
    end)

    hs.hotkey.bind(CTRL_OPT_CMD, "[", function()
      local win = hs.window.focusedWindow()
      local f = win:frame()
      local screen = win:screen()
      local max = screen:frame()

      f.w = f.w - 10
      win:setFrame(f)
    end)

    hs.hotkey.bind(CTRL_OPT_CMD, "0", function()
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

    return self
end
