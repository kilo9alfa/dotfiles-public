#!/bin/bash
# Sync Obsidian config from master vault (DPx) to other vaults
# Usage: ./sync-obsidian-config.sh

set -euo pipefail

MASTER_VAULT="/Users/david/Library/Mobile Documents/iCloud~md~obsidian/Documents/DPx"
MASTER_OBSIDIAN="$MASTER_VAULT/.obsidian"

# List of vaults to sync TO (add your other vaults here)
TARGET_VAULTS=(
    "/Users/david/Library/Mobile Documents/iCloud~md~obsidian/Documents/DavidMasterFile"
    # Add more vaults as needed:
    # "/path/to/another/vault"
)

# Files to sync (excluding workspace.json which is session-specific)
SYNC_FILES=(
    "appearance.json"
    "community-plugins.json"
    "core-plugins.json"
    "hotkeys.json"
    "app.json"
)

echo "Syncing Obsidian config from DPx master vault..."

for vault in "${TARGET_VAULTS[@]}"; do
    if [[ -d "$vault/.obsidian" ]]; then
        echo "  → Syncing to: $(basename "$vault")"

        for file in "${SYNC_FILES[@]}"; do
            if [[ -f "$MASTER_OBSIDIAN/$file" ]]; then
                cp "$MASTER_OBSIDIAN/$file" "$vault/.obsidian/$file"
            fi
        done

        # Sync snippets folder
        if [[ -d "$MASTER_OBSIDIAN/snippets" ]]; then
            mkdir -p "$vault/.obsidian/snippets"
            cp -r "$MASTER_OBSIDIAN/snippets/"* "$vault/.obsidian/snippets/" 2>/dev/null || true
        fi

        echo "    ✓ Done"
    else
        echo "  ✗ Skipping (not found): $vault"
    fi
done

echo ""
echo "Sync complete! Restart Obsidian to apply changes."
