#!/usr/bin/env bash
# Reapply the vscode-editor font-size clamp after a plugin update.
# See ../plugin-patches.md for why this is needed.
set -uo pipefail

OLD='let delta=0<event.deltaY?1:-1;this.plugin.settings.fontSize+=delta;'
NEW='let delta=0<event.deltaY?1:-1;this.plugin.settings.fontSize=Math.min(40,Math.max(6,this.plugin.settings.fontSize+delta));'

VAULTS=(
  "$HOME/code/_docs"
  "$HOME/Library/Mobile Documents/iCloud~md~obsidian/Documents/YourVault"
)

for vault in "${VAULTS[@]}"; do
  f="$vault/.obsidian/plugins/vscode-editor/main.js"
  if [ ! -f "$f" ]; then
    echo "skip (not installed): $vault"
    continue
  fi
  if grep -qF "$NEW" "$f"; then
    echo "already patched: $vault"
  elif grep -qF "$OLD" "$f"; then
    cp "$f" "$f.orig"
    python3 - "$f" "$OLD" "$NEW" <<'PY'
import sys, pathlib
f, old, new = pathlib.Path(sys.argv[1]), sys.argv[2], sys.argv[3]
f.write_text(f.read_text().replace(old, new))
PY
    echo "patched: $vault"
  else
    echo "PATTERN NOT FOUND (plugin changed?): $vault"
  fi
done

echo
echo "Reload Obsidian (Cmd+P -> 'Reload app without saving') for changes to take effect."
