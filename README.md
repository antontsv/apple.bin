# Scripts and executable files for 

Scripts in this repository are designed for Mac OS only

Some of the scripts are using `#!/usr/bin/env awesome-bash` shebang, which requires [awesome-shell installation] (https://github.com/antontsv/awesome-shell#installation)

# Completion

Bash completion rules can be found in `.sh` directory.

# Install
* You can copy scripts to any location in your PATH.

 OR

* you can go for complete dot files and scripts setup using [this one-liner](https://github.com/antontsv/.files#comprehensive-setup). It includes dotfiles manager, completion rules, awesome-bash, etc.

# Notable scripts

* [setup-macos](https://github.com/antontsv/apple.bin/blob/master/bin/setup-macos) applies settings from .misc directory to your MacOs,
useful for the first-time setup and also installs [hammerspoon](http://www.hammerspoon.org)

Hammerspoon's window shortcuts in action:
![hammerspoon-window](https://cloud.githubusercontent.com/assets/2007057/19018846/e61170e4-8824-11e6-843e-4d255e53d646.gif)

* [presenting](https://github.com/antontsv/apple.bin/blob/master/bin/presenting) to prepare MAC for presenting mode:
hides desktop icons, invokes Apple's Do not disturb to silence notifications
from chats, etc  [requires Accessibility feature enabled for terminal]
