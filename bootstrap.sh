#!/bin/bash
# Bootstrap script for new Mac setup
# Usage: ./bootstrap.sh

set -euo pipefail

echo "🚀 David's Mac Bootstrap Script"
echo "================================"
echo ""

DOTFILES_DIR="$(cd "$(dirname "$0")" && pwd)"

# Colors
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

step() { echo -e "${GREEN}▶ $1${NC}"; }
warn() { echo -e "${YELLOW}⚠ $1${NC}"; }

# ===========================================
# 1. Homebrew
# ===========================================
step "Checking Homebrew..."
if ! command -v brew &> /dev/null; then
    echo "Installing Homebrew..."
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    eval "$(/opt/homebrew/bin/brew shellenv)"
else
    echo "Homebrew already installed"
fi

# ===========================================
# 2. Install all packages from Brewfile
# ===========================================
step "Installing Homebrew packages (this may take a while)..."
brew bundle --file="$DOTFILES_DIR/brew/Brewfile"

# ===========================================
# 3. Backup existing configs
# ===========================================
step "Backing up existing configs..."
BACKUP_DIR="$HOME/.dotfiles-backup-$(date +%Y%m%d-%H%M%S)"
mkdir -p "$BACKUP_DIR"

for file in .zshrc .gitconfig .config/starship.toml .config/karabiner/karabiner.json; do
    if [ -f "$HOME/$file" ] && [ ! -L "$HOME/$file" ]; then
        mkdir -p "$BACKUP_DIR/$(dirname $file)"
        mv "$HOME/$file" "$BACKUP_DIR/$file"
        echo "  Backed up: $file"
    fi
done

# ===========================================
# 4. Stow shell configs
# ===========================================
step "Stowing shell configurations..."
cd "$DOTFILES_DIR"
stow -t ~ zsh
stow -t ~ git
stow -t ~ starship
stow --no-folding -t ~ karabiner
echo "  ✓ zsh, git, starship, karabiner stowed"

# ===========================================
# 5. Git config (prompt for email)
# ===========================================
step "Setting up Git..."
if ! git config --global user.email &> /dev/null; then
    read -p "Enter your Git email: " git_email
    read -p "Enter your Git name: " git_name
    git config --global user.email "$git_email"
    git config --global user.name "$git_name"
fi

# ===========================================
# 6. BetterTouchTool presets
# ===========================================
step "Setting up BetterTouchTool..."
if [ -d "/Applications/BetterTouchTool.app" ]; then
    echo "  Opening BTT presets folder..."
    echo "  → Import presets manually: BTT → Presets → Import"
    open "$DOTFILES_DIR/btt"
else
    warn "BetterTouchTool not installed. Run: brew install --cask bettertouchtool"
fi

# ===========================================
# 7. Obsidian
# ===========================================
step "Setting up Obsidian..."
OBSIDIAN_VAULT="$HOME/Library/Mobile Documents/iCloud~md~obsidian/Documents/YourVault"
if [ -d "$OBSIDIAN_VAULT" ]; then
    echo "  Obsidian vault found. Config will sync via iCloud."
else
    warn "Obsidian vault not found. After setting up iCloud:"
    echo "    1. Open Obsidian"
    echo "    2. Open vault from iCloud"
    echo "    3. Or copy config: cp -r $DOTFILES_DIR/obsidian/.obsidian/* <vault>/.obsidian/"
fi

# ===========================================
# 8. Global npm packages
# ===========================================
step "Installing global npm packages..."
npm install -g @hackmd/hackmd-cli 2>/dev/null
echo "  ✓ hackmd-cli installed"

# ===========================================
# 9. macOS Defaults
# ===========================================
step "Setting macOS defaults..."

# Screenshot shortcuts (macOS defaults)
# ⇧⌘3 → Save full screen as file
# ⇧⌃⌘3 → Copy full screen to clipboard
# ⇧⌘4 → Save selected area as file
# ⇧⌃⌘4 → Copy selected area to clipboard
# ⇧⌘5 → Screenshot and recording options
defaults write com.apple.symbolichotkeys AppleSymbolicHotKeys -dict-add 28 '{ enabled = 1; value = { parameters = (51, 20, 1179648); type = standard; }; }'
defaults write com.apple.symbolichotkeys AppleSymbolicHotKeys -dict-add 29 '{ enabled = 1; value = { parameters = (51, 20, 1441792); type = standard; }; }'
defaults write com.apple.symbolichotkeys AppleSymbolicHotKeys -dict-add 30 '{ enabled = 1; value = { parameters = (52, 21, 1179648); type = standard; }; }'
defaults write com.apple.symbolichotkeys AppleSymbolicHotKeys -dict-add 31 '{ enabled = 1; value = { parameters = (52, 21, 1441792); type = standard; }; }'
echo "  ✓ Screenshot shortcuts configured (macOS defaults)"

# Finder: Show hidden files
defaults write com.apple.finder AppleShowAllFiles -bool true
echo "  ✓ Finder: Show hidden files"

# Finder: Show path bar
defaults write com.apple.finder ShowPathbar -bool true
echo "  ✓ Finder: Show path bar"

# Finder: List view by default
defaults write com.apple.finder FXPreferredViewStyle -string "Nlsv"
echo "  ✓ Finder: List view by default"

# Finder: Copy as Pathname shortcut (Ctrl+Option+Cmd+C, matches Left Option via Karabiner)
defaults write com.apple.finder NSUserKeyEquivalents -dict-add "Copy as Pathname" "^~@c"
echo "  ✓ Finder: Copy as Pathname → ⌃⌥⌘C (L⌥⌘C)"

# Spaces: Single space spans all displays (all monitors switch together)
defaults write com.apple.spaces spans-displays -bool true
echo "  ✓ Spaces: Displays have separate Spaces disabled (requires logout)"

# Mission Control: Enable ctrl+1 through ctrl+9 for switching Spaces
for i in $(seq 0 8); do
    key=$((118 + i))
    num=$((i + 18))
    defaults write com.apple.symbolichotkeys AppleSymbolicHotKeys -dict-add "$key" "
    <dict>
        <key>enabled</key>
        <true/>
        <key>value</key>
        <dict>
            <key>parameters</key>
            <array>
                <integer>$((i + 49))</integer>
                <integer>$num</integer>
                <integer>262144</integer>
            </array>
            <key>type</key>
            <string>standard</string>
        </dict>
    </dict>"
done
echo "  ✓ Mission Control: Space switching shortcuts (ctrl+1-9) enabled"

# Dock: Keep auto-hide off
defaults write com.apple.dock autohide -bool false
echo "  ✓ Dock: Auto-hide disabled"

# Dock: Icon size
defaults write com.apple.dock tilesize -int 39
echo "  ✓ Dock: Icon size 39"

# Hot Corners: Bottom-right → Quick Note
defaults write com.apple.dock wvous-br-corner -int 14
defaults write com.apple.dock wvous-br-modifier -int 0
echo "  ✓ Hot Corners: Bottom-right → Quick Note"


# Keyboard: Disable press-and-hold for accented chars (enables key repeat instead)
defaults write -g ApplePressAndHoldEnabled -bool false
echo "  ✓ Keyboard: Press-and-hold disabled (key repeat works everywhere)"

# Dock: Zero delay before auto-hide kicks in
defaults write com.apple.dock autohide-delay -float 0
echo "  ✓ Dock: No auto-hide delay"

# Dock: Faster show/hide animation
defaults write com.apple.dock autohide-time-modifier -float 0.25
echo "  ✓ Dock: Fast auto-hide animation"

# Animations: Disable window open/close animations (snappier UX)
defaults write -g NSAutomaticWindowAnimationsEnabled -bool false
echo "  ✓ Animations: Window open/close animations disabled"

# Windows: Drag from anywhere by holding Ctrl+Cmd and clicking any part of the window
defaults write -g NSWindowShouldDragOnGesture -bool true
echo "  ✓ Windows: Drag from anywhere enabled (Ctrl+Cmd+click)"

# Trackpad: Double-tap to drag (without drag lock)
defaults write com.apple.AppleMultitouchTrackpad Dragging -bool true
defaults write com.apple.AppleMultitouchTrackpad DragLock -bool false
defaults write com.apple.AppleMultitouchTrackpad TrackpadThreeFingerDrag -bool false
defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad Dragging -bool true
defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad DragLock -bool false
defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad TrackpadThreeFingerDrag -bool false
echo "  ✓ Trackpad: Double-tap to drag enabled"

# Restart affected apps
killall Finder 2>/dev/null || true
killall Dock 2>/dev/null || true

# Apply keyboard shortcut settings
/System/Library/PrivateFrameworks/SystemAdministration.framework/Resources/activateSettings -u

# ===========================================
# 10. Reload shell
# ===========================================
step "Reloading shell..."
source "$HOME/.zshrc" 2>/dev/null || true

echo ""
echo "================================"
echo "✅ Bootstrap complete!"
echo ""
echo "Next steps:"
echo "  1. Log out and back in (required for screenshot shortcut changes)"
echo "  2. Import BTT presets (folder should be open)"
echo "  3. Open Obsidian and connect to iCloud vault"
echo ""
echo "Backups saved to: $BACKUP_DIR"
