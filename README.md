# Scripts and executable files for 

Your can copy desired script to any location in your PATH
or install to ~/bin with [homeshick](https://github.com/antontsv/homeshick)

Some of the scripts are using `#!/usr/bin/env awesome-bash` shebang,
which requires [awesome-shell installation] (https://github.com/antontsv/awesome-shell#installation)

These scripts are designed for Mac OS only

# Completion

Completion rules can be found in `.sh` directory,
if you use one-time [homeshick-based setup script](https://git.io/all.files),
completion rules will be installed and kept up-to-date automatically

# Notable scripts

* [setup-osx](https://github.com/antontsv/apple.bin/blob/master/bin/setup-osx) applies settings from .misc directory to your OSX,
useful for the first-time setup and also installs [hammerspoon](http://www.hammerspoon.org)

Hammerspoon's window shortcuts in action:
![hammerspoon-window](https://cloud.githubusercontent.com/assets/2007057/19018846/e61170e4-8824-11e6-843e-4d255e53d646.gif)

* [presenting](https://github.com/antontsv/apple.bin/blob/master/bin/presenting) to prepare MAC for presenting mode:
hides desktop icons, invokes Apple's Do not disturb to silence notifications
from chats, etc  [requires Accessibility feature enabled for terminal]
