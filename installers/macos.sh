# References:
# https://macos-defaults.com/
# https://gist.github.com/erikh/2260182


# Dock

## remove all persistent apps
defaults write "com.apple.dock" "persistent-apps" -array

## autohide
defaults write com.apple.dock "autohide" -bool "true" 

## instantly hide
defaults write com.apple.dock "autohide-time-modifier" -float "0"

## instantly show
defaults write com.apple.dock "autohide-delay" -float "0"

killall Dock


# Finder

## show all file extensions
defaults write NSGlobalDomain "AppleShowAllExtensions" -bool "true"

## show hidden files
defaults write com.apple.finder "AppleShowAllFiles" -bool "true"

## show path bar
defaults write com.apple.finder "ShowPathbar" -bool "false"

# doesn't seem to work
# ## default to list view
# defaults write com.apple.finder "FXPreferredViewStyle" -string "Nlsv"

## default search scope to the current folder
defaults write com.apple.finder "FXDefaultSearchScope" -string "SCcf"

## disable warning when changing a file extension
defaults write com.apple.finder "FXEnableExtensionChangeWarning" -bool "false"

killall Finder


# Keyboard

# Hmmm... this doesn't persist across reboots. Do it manually in "Keyboard > Keyboard Shortcuts... > Customize modifier keys".
# ## map Caps Lock key to left Ctrl
# hidutil property --set '{"UserKeyMapping":[{"HIDKeyboardModifierMappingSrc":0x700000039,"HIDKeyboardModifierMappingDst":0x7000000E0}]}'

# Need to reboot before the following are in effect... tho not sure why.

## initial pause before key repeat
## 15 is lowest setting in Settings UI
defaults write NSGlobalDomain InitialKeyRepeat -int 12

## key repeat delay
## 2 is lowest setting in Settings UI
defaults write NSGlobalDomain KeyRepeat -int 2


# Trackpad

# set gestures manually
# set tracking speed manually
