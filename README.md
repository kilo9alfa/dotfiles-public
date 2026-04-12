# Dotfiles

macOS configuration files managed with [GNU Stow](https://www.gnu.org/software/stow/). Each folder is an independent package — pick and choose what you want.

## Quick Start

```bash
# Clone
git clone https://github.com/kilo9alfa/dotfiles-public.git ~/dotfiles
cd ~/dotfiles

# Install everything
./bootstrap.sh

# Or pick individual packages
stow zsh          # shell config
stow starship     # prompt
stow karabiner    # keyboard remapping (use --no-folding)
```

## Packages

| Package | What's in it | Stow? |
|---------|-------------|-------|
| `zsh/` | `.zshrc`, plugin list (antidote) | `stow zsh` |
| `starship/` | Starship prompt config | `stow starship` |
| `karabiner/` | Karabiner-Elements key remapping (Spanish ISO keyboard) | `stow --no-folding karabiner` |
| `code/` | VS Code settings, keybindings, extensions list | manual copy (see below) |
| `brew/` | Homebrew packages (Brewfile) | `brew bundle --file=brew/Brewfile` |
| `macos/` | macOS defaults (Dock, Finder, screenshots, etc.) | `./macos/defaults.sh` |
| `obsidian/` | Obsidian vault config, CSS snippets, Kindle scripts | manual copy |
| `keyboard-shortcuts.md` | Full keyboard shortcuts reference | reference doc |

## Cherry-Picking

You don't need everything. Each folder is self-contained:

```bash
# Just want the shell config?
stow zsh

# Just the prompt?
stow starship

# Just Homebrew packages?
brew bundle --file=brew/Brewfile

# Just macOS defaults?
./macos/defaults.sh
```

## VS Code Setup

VS Code on macOS stores settings outside `~/.config`, so stow doesn't work directly:

```bash
# Copy settings
cp code/.config/Code/User/settings.json ~/Library/Application\ Support/Code/User/
cp code/.config/Code/User/keybindings.json ~/Library/Application\ Support/Code/User/

# Install extensions
cat code/extensions.txt | xargs -L 1 code --install-extension
```

## Obsidian

The `obsidian/` folder contains:
- `.obsidian/` config files (plugins, hotkeys, appearance)
- CSS snippets for editing
- Send-to-Kindle scripts (convert markdown to EPUB and email to Kindle)

Copy what you need into your vault's `.obsidian/` folder.

### Send to Kindle

Convert any markdown note to EPUB and wirelessly deliver to Kindle:

```bash
# Setup
cp obsidian/scripts/.kindle-config.template obsidian/scripts/.kindle-config
# Edit .kindle-config with your Kindle email and Gmail app password

# Usage
./obsidian/scripts/ConvertToEpub.sh /path/to/note.md
```

Requires: `pandoc` (included in Brewfile), Gmail app password.

## Font

The VS Code config uses **IoskeleyMono Nerd Font**. Install via Homebrew:

```bash
brew install --cask font-ioskeley-mono
```

## Key Remapping (Karabiner)

Custom rules for a Spanish ISO keyboard:
- Left Option + specific keys (N, R, S, arrows) to Control+Option combos (for VS Code shortcuts)
- Left Option + 1-9 to Control + 1-9 (for macOS Space switching)

See `keyboard-shortcuts.md` for the full shortcuts reference.

## Requirements

- macOS
- [Homebrew](https://brew.sh)
- [GNU Stow](https://www.gnu.org/software/stow/) (`brew install stow`)

## License

MIT
