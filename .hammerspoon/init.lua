require "modules.autoloader"
require "modules.messenger"
require "modules.caffeinator"
require "modules.screenLockWatcher"
require "modules.windowController"
require "modules.nightWatcher"

-- watches Lua files
-- provides short-cuts to reload Hammerspoon config
Autoloader()

-- for all notifications and messaging needs
messenger = Messenger()

-- prevent Mac from sleeping,
-- it should also create Moon-like menu icon
Caffeinator()

-- performs actions upon screen lock:
-- mute audio, remove identities from SSH-agent, etc.
ScreenLockWatcher()

-- Controls focused window size and movement
-- though several keyboard combinations
WindowController()

-- Sets up for the night:
-- mostly tweaks display color temperature
NightWatcher(2800,'21:00','7:00')

-- display alert when config is loaded
-- if Hammerspoon crashes, you won't see message
messenger.message("Hammerspoon config - OK", 1)
