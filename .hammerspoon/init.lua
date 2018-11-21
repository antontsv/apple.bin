require 'modules.autoloader'

-- watches Lua files
-- provides short-cuts to reload Hammerspoon config
loader = Autoloader('modules')

-- for all notifications and messaging needs
messenger = loader.loadModule('messenger')

-- prevent Mac from sleeping,
-- it should also create Moon-like menu icon
loader.loadModule('caffeinator')

-- performs actions upon screen lock:
-- mute audio, remove identities from SSH-agent, etc.
loader.loadModule('screenLockWatcher')

-- Controls focused window size and movement
-- though several keyboard combinations
loader.loadModule('windowController')

-- Automatically load any modules added to dir defined by extras variable
extras = 'autoload'
local iterFn, dirObj = hs.fs.dir(extras)
if iterFn then
  autoloader = Autoloader(extras)
  for file in iterFn, dirObj do
    if file:sub(-4) == ".lua" then
      autoloader.loadModule(file:sub(0,-5))
    end
  end
end

-- display alert when config is loaded
-- if Hammerspoon crashes, you won't see message
messenger.message('Hammerspoon config - OK', 1)
