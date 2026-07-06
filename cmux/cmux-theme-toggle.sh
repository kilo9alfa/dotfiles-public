#!/bin/bash
# Toggle cmux between light and dark appearance.
# Flips app.appearance in ~/.config/cmux/cmux.json and reloads cmux in place.
# Bound to Ctrl+T inside cmux via Karabiner (see karabiner.json).
set -euo pipefail

CONFIG="$HOME/.config/cmux/cmux.json"
CMUX="/Applications/cmux.app/Contents/Resources/bin/cmux"

if grep -q '"appearance" : "light"' "$CONFIG"; then
    sed -i '' 's/"appearance" : "light"/"appearance" : "dark"/' "$CONFIG"
elif grep -q '"appearance" : "dark"' "$CONFIG"; then
    sed -i '' 's/"appearance" : "dark"/"appearance" : "light"/' "$CONFIG"
else
    # No explicit override yet (appearance = system): flip away from the
    # current macOS appearance and insert a managed app block.
    if defaults read -g AppleInterfaceStyle >/dev/null 2>&1; then
        target="light"
    else
        target="dark"
    fi
    sed -i '' "s/\"schemaVersion\": 1,/\"schemaVersion\": 1,\\
\\
  \"app\" : { \"appearance\" : \"$target\" },/" "$CONFIG"
fi

"$CMUX" reload-config
