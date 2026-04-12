#!/usr/bin/env bash
# macOS defaults - restore system preferences on a fresh Mac
# Run: ./macos/defaults.sh
# Then log out and back in (or reboot) for all changes to take effect.

###############################################################################
# General UI/UX                                                               #
###############################################################################

# Dark mode
defaults write NSGlobalDomain AppleInterfaceStyle -string "Dark"

# Languages: English (US) primary, Spanish (Spain) secondary
defaults write NSGlobalDomain AppleLanguages -array "en-US" "es-ES"
defaults write NSGlobalDomain AppleLocale -string "en_US@rg=eszzzz"

# Disable press-and-hold for keys (enable key repeat)
defaults write NSGlobalDomain ApplePressAndHoldEnabled -bool false

# Show menu bar in fullscreen
defaults write NSGlobalDomain AppleMenuBarVisibleInFullscreen -bool true

# Don't minimize on double-click
defaults write NSGlobalDomain AppleMiniaturizeOnDoubleClick -bool false

# Prefer tabs: always
defaults write NSGlobalDomain AppleWindowTabbingMode -string "always"

# Scroll bar: jump to clicked spot
defaults write NSGlobalDomain AppleScrollerPagingBehavior -int 1

# Disable window animations
defaults write NSGlobalDomain NSAutomaticWindowAnimationsEnabled -bool false

# Calendar: show week numbers
defaults write NSGlobalDomain NSCalendarShowWeekNumbers -bool true

# Enable drag windows from anywhere (Ctrl+Cmd click)
defaults write NSGlobalDomain NSWindowShouldDragOnGesture -bool true

# Disable UI sound effects
defaults write NSGlobalDomain "com.apple.sound.uiaudio.enabled" -bool false

# Trackpad: force click enabled
defaults write NSGlobalDomain "com.apple.trackpad.forceClick" -bool true

# Trackpad: tracking speed
defaults write NSGlobalDomain "com.apple.trackpad.scaling" -float 1

# Switch to app's space when activating it
defaults write NSGlobalDomain AppleSpacesSwitchOnActivate -bool true

# Disable swipe navigation with scroll
defaults write NSGlobalDomain AppleEnableSwipeNavigateWithScrolls -bool false

###############################################################################
# Trackpad - Built-in                                                         #
###############################################################################

defaults write com.apple.AppleMultitouchTrackpad Clicking -bool true
defaults write com.apple.AppleMultitouchTrackpad Dragging -bool true
defaults write com.apple.AppleMultitouchTrackpad DragLock -bool false
defaults write com.apple.AppleMultitouchTrackpad TrackpadThreeFingerDrag -bool false
defaults write com.apple.AppleMultitouchTrackpad TrackpadRightClick -bool true
defaults write com.apple.AppleMultitouchTrackpad TrackpadCornerSecondaryClick -int 0
defaults write com.apple.AppleMultitouchTrackpad TrackpadPinch -bool true
defaults write com.apple.AppleMultitouchTrackpad TrackpadRotate -bool true
defaults write com.apple.AppleMultitouchTrackpad TrackpadTwoFingerDoubleTapGesture -int 1
defaults write com.apple.AppleMultitouchTrackpad TrackpadTwoFingerFromRightEdgeSwipeGesture -int 3
defaults write com.apple.AppleMultitouchTrackpad TrackpadThreeFingerHorizSwipeGesture -int 2
defaults write com.apple.AppleMultitouchTrackpad TrackpadThreeFingerVertSwipeGesture -int 2
defaults write com.apple.AppleMultitouchTrackpad TrackpadThreeFingerTapGesture -int 0
defaults write com.apple.AppleMultitouchTrackpad TrackpadFourFingerHorizSwipeGesture -int 2
defaults write com.apple.AppleMultitouchTrackpad TrackpadFourFingerVertSwipeGesture -int 2
defaults write com.apple.AppleMultitouchTrackpad TrackpadFourFingerPinchGesture -int 2
defaults write com.apple.AppleMultitouchTrackpad TrackpadFiveFingerPinchGesture -int 2
defaults write com.apple.AppleMultitouchTrackpad FirstClickThreshold -int 1
defaults write com.apple.AppleMultitouchTrackpad SecondClickThreshold -int 1
defaults write com.apple.AppleMultitouchTrackpad ForceSuppressed -bool false

###############################################################################
# Trackpad - Bluetooth                                                        #
###############################################################################

defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad Clicking -bool true
defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad Dragging -bool true
defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad DragLock -bool false
defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad TrackpadThreeFingerDrag -bool false
defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad TrackpadRightClick -bool true
defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad TrackpadCornerSecondaryClick -int 0
defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad TrackpadPinch -bool true
defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad TrackpadRotate -bool true
defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad TrackpadTwoFingerDoubleTapGesture -int 1
defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad TrackpadTwoFingerFromRightEdgeSwipeGesture -int 3
defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad TrackpadThreeFingerHorizSwipeGesture -int 2
defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad TrackpadThreeFingerVertSwipeGesture -int 2
defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad TrackpadThreeFingerTapGesture -int 0
defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad TrackpadFourFingerHorizSwipeGesture -int 2
defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad TrackpadFourFingerVertSwipeGesture -int 2
defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad TrackpadFourFingerPinchGesture -int 2
defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad TrackpadFiveFingerPinchGesture -int 2

###############################################################################
# Dock                                                                        #
###############################################################################

# Dock icon size
defaults write com.apple.dock tilesize -int 39

# Don't auto-hide Dock
defaults write com.apple.dock autohide -bool false

# Speed up auto-hide animation
defaults write com.apple.dock autohide-time-modifier -float 0.25

# No auto-hide delay
defaults write com.apple.dock autohide-delay -float 0

# Don't rearrange Spaces based on most recent use
defaults write com.apple.dock mru-spaces -bool false

# Disable enter Mission Control by dragging to top
defaults write com.apple.dock enterMissionControlByTopWindowDrag -bool false

# Hot corner: bottom-right → Quick Note
defaults write com.apple.dock wvous-br-corner -int 14

###############################################################################
# Finder                                                                      #
###############################################################################

# Show all filename extensions
defaults write NSGlobalDomain AppleShowAllExtensions -bool true

# Show path bar
defaults write com.apple.finder ShowPathbar -bool true

# Show status bar
defaults write com.apple.finder ShowStatusBar -bool true

# Default to list view
defaults write com.apple.finder FXPreferredViewStyle -string "Nlsv"

# Keep folders on top when sorting by name
defaults write com.apple.finder _FXSortFoldersFirst -bool true

# Search current folder by default
defaults write com.apple.finder FXDefaultSearchScope -string "SCcf"

# Disable warning when changing file extension
defaults write com.apple.finder FXEnableExtensionChangeWarning -bool false

###############################################################################
# Screenshots                                                                 #
###############################################################################

# Screenshot style: selection
defaults write com.apple.screencapture style -string "selection"

# Save to file (not clipboard) by default
defaults write com.apple.screencapture target -string "file"

# Enable video recording
defaults write com.apple.screencapture video -bool true

# Custom screenshot shortcuts (remapped from defaults):
# Key 28 = Save screen as file → ⇧⌘2
defaults write com.apple.symbolichotkeys AppleSymbolicHotKeys -dict-add 28 '{"enabled" = 1; "value" = {"parameters" = (50, 19, 1179648); "type" = "standard";}; }'
# Key 29 = Copy screen to clipboard → ⇧⌘3
defaults write com.apple.symbolichotkeys AppleSymbolicHotKeys -dict-add 29 '{"enabled" = 1; "value" = {"parameters" = (51, 20, 1179648); "type" = "standard";}; }'
# Key 30 = Save selection as file → ⇧⌘5
defaults write com.apple.symbolichotkeys AppleSymbolicHotKeys -dict-add 30 '{"enabled" = 1; "value" = {"parameters" = (53, 23, 1179648); "type" = "standard";}; }'
# Key 31 = Copy selection to clipboard → ⇧⌘4
defaults write com.apple.symbolichotkeys AppleSymbolicHotKeys -dict-add 31 '{"enabled" = 1; "value" = {"parameters" = (52, 21, 1179648); "type" = "standard";}; }'

###############################################################################
# Window Manager                                                              #
###############################################################################

# Disable Stage Manager
defaults write com.apple.WindowManager GloballyEnabled -bool false
defaults write com.apple.WindowManager StageManagerEnabled -bool false

# Don't hide desktop items
defaults write com.apple.WindowManager HideDesktop -bool false

# Don't hide widgets
defaults write com.apple.WindowManager StageManagerHideWidgets -bool false
defaults write com.apple.WindowManager StandardHideWidgets -bool false

###############################################################################
# Menu Bar / Clock                                                            #
###############################################################################

# Clock: show date, day of week, AM/PM
defaults write com.apple.menuextra.clock ShowDate -int 1
defaults write com.apple.menuextra.clock ShowDayOfWeek -bool true
defaults write com.apple.menuextra.clock ShowAMPM -bool true
defaults write com.apple.menuextra.clock IsAnalog -bool false

# Control Center: show Battery, WiFi, Shortcuts; hide others
defaults write com.apple.controlcenter "NSStatusItem Visible Battery" -bool true
defaults write com.apple.controlcenter "NSStatusItem Visible WiFi" -bool true
defaults write com.apple.controlcenter "NSStatusItem Visible Shortcuts" -bool true
defaults write com.apple.controlcenter "NSStatusItem Visible Sound" -bool false
defaults write com.apple.controlcenter "NSStatusItem Visible Display" -bool false
defaults write com.apple.controlcenter "NSStatusItem Visible FocusModes" -bool false
defaults write com.apple.controlcenter "NSStatusItem Visible NowPlaying" -bool false
defaults write com.apple.controlcenter "NSStatusItem Visible ScreenMirroring" -bool false

###############################################################################
# Text Replacements                                                           #
###############################################################################

# Note: Text replacements are synced via iCloud. These are backed up here
# for reference but may need to be re-added manually in System Settings >
# Keyboard > Text Replacements if iCloud sync doesn't restore them.
#
# Shortcut        → Replacement
# #tt              → #today
# chp              → Proof read. After, add a list of the changes you made...
# otk              → - [ ]
# nts              → Note to self →
# fb               → YOUR_FEEDBIN_EMAIL
# rar              → →
# lar              → ←
# omw              → On my way!
# DB               → DataBeacon

###############################################################################
# Kill affected apps                                                          #
###############################################################################

for app in "Dock" "Finder" "SystemUIServer"; do
    killall "$app" &>/dev/null
done

echo "macOS defaults applied. Log out and back in for all changes to take effect."
