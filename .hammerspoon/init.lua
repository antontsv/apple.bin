require 'modules.loader'

-- watches Lua files
-- provides short-cuts to reload Hammerspoon config
loader = ModuleLoader()
loader.addWatcher('init.lua')

-- for all notifications and messaging needs
messenger = loader.loadModule('modules', 'messenger')

-- prevent Mac from sleeping,
-- it should also create Moon-like menu icon
loader.loadModule('modules', 'caffeinator')

-- performs actions upon screen lock:
-- mute audio, remove identities from SSH-agent, etc.
loader.loadModule('modules', 'screenLockWatcher')

-- Controls focused window size and movement
-- though several keyboard combinations
loader.loadModule('modules', 'windowController')

-- Automatically load any modules added to auto_dir
auto_dir = 'autoload'
local iterFn, dirObj = hs.fs.dir(os.getenv('HOME') .. '/.hammerspoon/' .. auto_dir)
if iterFn then
  for file in iterFn, dirObj do
    if file:sub(-4) == ".lua" then
        loader.loadModule(auto_dir, file:sub(0,-5))
    end
  end
end

-- Key combination to reload config
hs.hotkey.bind({'ctrl','alt','cmd'}, 'R', hs.reload)

-- display alert when config is loaded
-- if Hammerspoon crashes, you won't see message
messenger.message('Hammerspoon config - OK', 1)
