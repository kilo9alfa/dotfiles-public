# Obsidian Configuration

Master Obsidian vault configuration from DPx.

## Structure

```
obsidian/
├── .obsidian/           # Core Obsidian settings
│   ├── appearance.json  # Theme, fonts, UI settings
│   ├── community-plugins.json  # Installed plugins list
│   ├── core-plugins.json       # Built-in plugin toggles
│   ├── hotkeys.json     # Custom keyboard shortcuts
│   ├── app.json         # App settings
│   └── snippets/        # CSS snippets
├── scripts/             # Shell commands & automation
│   ├── pull-conf.sh     # Confluence → Obsidian importer
│   ├── ConvertToEpub.sh # Markdown → Kindle pipeline
│   ├── send-to-kindle.py
│   ├── patch-vscode-editor.sh  # Reapply vscode-editor font-size clamp
│   └── ...
└── sync-obsidian-config.sh  # Sync to other vaults
```

## Installed Plugins (34)

Key plugins:
- **chatmd-custom** - AI chat integration
- **dataview** - Query notes like a database
- **obsidian-tasks-plugin** - Task management
- **quickadd** - Quick capture & templates
- **obsidian-shellcommands** - Run shell scripts
- **meld-encrypt** - Encrypt notes
- **obsidian-kindle-plugin** - Kindle highlights

## Key Hotkeys

| Shortcut | Action |
|----------|--------|
| `Alt+A` | Call ChatGPT API |
| `Alt+L` | Select AI model |
| `Alt+S` | Infer title from content |
| `Alt+I` | Shell command triggers |
| `Ctrl+Alt+Cmd+E` | Encrypt note |
| `Ctrl+Alt+Cmd+K` | Send to Kindle |

## Syncing to Other Vaults

```bash
./sync-obsidian-config.sh
```

Edit the script to add your vault paths.

## Plugin patches

Some community plugins have local fixes applied to their `main.js`. **Plugin updates overwrite these** — see [`plugin-patches.md`](plugin-patches.md) for what is patched and how to reapply.

Currently patched: `vscode-editor` (clamps runaway pinch-to-zoom font size). Reapply with `./scripts/patch-vscode-editor.sh`.

## Note

- `workspace.json` is NOT synced (session-specific)
- Plugin settings are per-vault in `plugins/` folder
- Credentials are in `.kindle-config` (not tracked)
