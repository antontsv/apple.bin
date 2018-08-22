require 'modules.autoloader'

-- watches Lua files
-- provides short-cuts to reload Hammerspoon config
autoloader = Autoloader()

-- for all notifications and messaging needs
messenger = autoloader.loadModule('messenger')

-- prevent Mac from sleeping,
-- it should also create Moon-like menu icon
autoloader.loadModule('caffeinator')

-- performs actions upon screen lock:
-- mute audio, remove identities from SSH-agent, etc.
autoloader.loadModule('screenLockWatcher')

-- Controls focused window size and movement
-- though several keyboard combinations
autoloader.loadModule('windowController')

-- display alert when config is loaded
-- if Hammerspoon crashes, you won't see message
messenger.message('Hammerspoon config - OK', 1)
