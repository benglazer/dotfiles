### References
# https://macos-defaults.com/
# https://gist.github.com/erikh/2260182

### Manual steps

# First, execute these steps manually:
# 1. Complete the regular MacOS install process.
# 2. Open Preferences —> Time Machine -> Options. Check the boxes next to:
#     - Back up while on battery power and
#     - Exclude system files and applications
# 3. Complete an initial backup.
# 4. Complete manual config steps
#   a. Set Caps Lock to Control
#   b. Enable zoom using Control + two-finger swipe up/down
#   c. Enable dictation
# 5. Open Terminal.app and install dotfiles via bootstrap.sh.

### Backup defaults

defaults read > defaults.orig.txt  # backup defaults

### Keyboard

# May need to reboot before the following are in effect. Not sure why.

# fast keyboard repeat rate (2 is lowest setting in UI)
defaults write "Apple Global Domain" KeyRepeat 2
# low delay before repeat starts (15 is lowest setting in UI)
defaults write "Apple Global Domain" InitialKeyRepeat 15
# tab to navigate between controls
defaults write "Apple Global Domain" AppleKeyboardUIMode 2
# disable spell check
defaults write "Apple Global Domain" NSAutomaticSpellingCorrectionEnabled 0
# disable auto-capitalization
defaults write "Apple Global Domain" NSAutomaticCapitalizationEnabled 0
# disable period on double-space
defaults write "Apple Global Domain" NSAutomaticPeriodSubstitutionEnabled 0
# disable "smart" quotes and dashes
defaults write "Apple Global Domain" NSAutomaticQuoteSubstitutionEnabled 0
defaults write "Apple Global Domain" NSAutomaticDashSubstitutionEnabled 0

### Trackpad

# fast trackpad
defaults write "Apple Global Domain" com.apple.trackpad.scaling 3
# tap-to-click
defaults write "com.apple.AppleMultitouchTrackpad" Clicking 1
# enable Exposé swipe down gesture
defaults write "com.apple.dock" showAppExposeGestureEnabled 1
# swipe between full-screen spaces with four fingers
defaults write "com.apple.AppleMultitouchTrackpad" TrackpadThreeFingerHorizSwipeGesture 0
# navigate back/forward between pages (three-finger swipe left/right)
defaults write "Apple Global Domain" AppleEnableSwipeNavigateWithScrolls 0
defaults write "com.apple.AppleMultitouchTrackpad" TrackpadThreeFingerHorizSwipeGesture 1
defaults write "com.apple.driver.AppleBluetoothMultitouch.trackpad" TrackpadThreeFingerHorizSwipeGesture 1
# disable Notification Center gesture (two-finger swipe left from right edge)
defaults write "com.apple.AppleMultitouchTrackpad" TrackpadTwoFingerFromRightEdgeSwipeGesture 0
defaults write "com.apple.driver.AppleBluetoothMultitouch.trackpad" TrackpadTwoFingerFromRightEdgeSwipeGesture 0

### Dock

# remove app shortcuts from dock
defaults delete com.apple.dock persistent-apps
# don't show recents in dock
defaults write com.apple.dock show-recents 0
# auto-hide dock
defaults write com.apple.dock autohide 1
# instantly hide
defaults write com.apple.dock "autohide-time-modifier" -float "0"
# instantly show
defaults write com.apple.dock "autohide-delay" -float "0"

killall Dock

### Finder

# show all file extensions
defaults write "Apple Global Domain" AppleShowAllExtensions 1
# don't warn before changing an extension
defaults write "com.apple.finder" FXEnableExtensionChangeWarning 0
# sort folders above files
defaults write "com.apple.finder" _FXSortFoldersFirst 1
# set default search scope to current directory
defaults write "com.apple.finder" FXDefaultSearchScope SCcf
# show hidden files
defaults write "com.apple.finder" AppleShowAllFiles 1
# show path bar
defaults write "com.apple.finder" ShowPathbar 0

# doesn't seem to work:
# # default to list view
# defaults write com.apple.finder "FXPreferredViewStyle" -string "Nlsv"

killall Finder

