# Keyboard Shortcuts Map

Single source of truth for all custom keyboard shortcuts.

## How modifiers work

```
Physical key press          What the system sees         Who responds
─────────────────           ────────────────────         ────────────
L⌥ + N/R/S/↑/←/→    →      ⌃⌥ + key                   → VS Code (specific keys only)
L⌥ + 1-9             →      ⌃ + 1-9                    → macOS (switch Space)
R⌥ + key             →      ⌥ + key                    → Obsidian, VS Code, macOS
Cmd / Ctrl / Shift   →      unchanged                  → all apps normally
```

**Symbols:** ⌘ Command · ⌥ Option · ⌃ Control · ⇧ Shift

## All Shortcuts

| Physical press                                | System sees | macOS                          | Obsidian                 | VS Code                  | Notes    |
| --------------------------------------------- | ----------- | ------------------------------ | ------------------------ | ------------------------ | -------- |
| **L⌥ (Left Option → Space switching)**        |             |                                |                          |                          |          |
| L⌥ + 1-9                                      | ⌃1-9        | Switch to Space 1-9            |                          |                          | Karabiner |
| **⌃ (Control)**                               |             |                                |                          |                          |          |
| ⌃↑                                            | ⌃↑          |                                | Table: Row before        |                          |          |
| ⌃↓                                            | ⌃↓          |                                | Table: Row after         |                          |          |
| ⌃Tab                                          | ⌃Tab        |                                | Next tab                 |                          |          |
| ⌃⇧Tab                                         | ⌃⇧Tab       |                                | Previous tab             |                          |          |
| **⌥ (Right Option)**                          |             |                                |                          |                          |          |
| ⌥-                                            | ⌥-          |                                | Toggle left sidebar      |                          |          |
| ⌥'                                            | ⌥'          | Finder: Copy as Pathname       | Copy full path           |                          | Karabiner (Finder only) |
| ⌥A                                            | ⌥A          |                                | ChatMD: Call API         |                          |          |
| ⌥C                                            | ⌥C          |                                | ChatMD: Stop streaming   | Terminal: Change color   |          |
| ⌥D                                            | ⌥D          |                                |                          | Toggle light/dark theme  |          |
| ⌥F                                            | ⌥F          |                                | Copy as HTML             |                          |          |
| ⌥H                                            | ⌥H          |                                | ChatGPT: Move to chat    |                          |          |
| ⌥I                                            | ⌥I          |                                | Shell command 1          |                          |          |
| ⌥L                                            | ⌥L          |                                | ChatMD: Select model     |                          |          |
| ⌥N                                            | ⌥N          |                                | ZK Prefixer              |                          |          |
| ⌥P                                            | ⌥P          |                                | Add metadata property    | Pin/Unpin editor         |          |
| ⌥S                                            | ⌥S          |                                | ChatMD: Infer title      |                          |          |
| ⌥X                                            | ⌥X          |                                | Extract URL: Import      |                          |          |
| ⌥Z                                            | ⌥Z          |                                | ChatGPT: Choose template |                          |          |
| ⌥→                                            | ⌥→          |                                | Split vertical           |                          |          |
| ⌥↑                                            | ⌥↑          |                                | Move to new window       |                          |          |
| **⌥⇧ (Right Option + Shift)**                 |             |                                |                          |                          |          |
| ⌥⇧I                                           | ⌥⇧I         |                                | Shell command (shift)    |                          |          |
| **⌃⌥ (Control + Option)**                      |             |                                |                          |                          |          |
| ⌃⌥N                                            | ⌃⌥N         |                                |                          | New terminal in editor   |          |
| ⌃⌥R                                            | ⌃⌥R         |                                |                          | TAM: Rename terminal     |          |
| ⌃⌥S                                            | ⌃⌥S         |                                |                          | TAM: Search terminals    |          |
| **⌥⌘ (Option + Cmd)**                         |             |                                |                          |                          |          |
| ⌥⌘                                            | ⌥⌘          |                                |                          | Claude: Accept diff      |          |
| **⌃⌥⌘ (Finder only)**                         |             |                                |                          |                          |          |
| ⌃⌥⌘C                                          | ⌃⌥⌘C        | Finder: Copy as Pathname       |                          |                          | Custom   |
| ⌥⌘I                                           | ⌥⌘I         |                                | Shell command (cmd)      |                          |          |
| ⌥⌘R                                           | ⌥⌘R         |                                | Open with default app    |                          |          |
| ⌥⌘T                                           | ⌥⌘T         |                                | Table control bar        |                          |          |
| ⌥⌘←                                           | ⌥⌘←         |                                |                          | Previous editor          |          |
| ⌥⌘→                                           | ⌥⌘→         |                                |                          | Next editor              |          |
| **⌥⌘⇧**                                       |             |                                |                          |                          |          |
| ⌥⌘⇧/                                          | ⌥⌘⇧/        |                                | Copy path                |                          |          |
| **⌃⌥⌘ (Ctrl + Option + Cmd)**                 |             |                                |                          |                          |          |
| ⌃⌥⌘D                                          | ⌃⌥⌘D        |                                | Delete file              |                          |          |
| ⌃⌥⌘E                                          | ⌃⌥⌘E        |                                | Meld encrypt             |                          |          |
| ⌃⌥⌘F                                          | ⌃⌥⌘F        |                                | Fold all                 |                          |          |
| ⌃⌥⌘G                                          | ⌃⌥⌘G        |                                | Collapse file explorer   |                          |          |
| ⌃⌥⌘H                                          | ⌃⌥⌘H        |                                | QuickAdd choice          |                          |          |
| ⌃⌥⌘I                                          | ⌃⌥⌘I        |                                | Shell command 3          |                          |          |
| ⌃⌥⌘K                                          | ⌃⌥⌘K        |                                | Shell command 4          |                          |          |
| ⌃⌥⌘R                                          | ⌃⌥⌘R        |                                | Reveal active file       |                          |          |
| ⌃⌥⌘T                                          | ⌃⌥⌘T        |                                | Shell command 5          | Create terminal editor   |          |
| ⌃⌥⌘X                                          | ⌃⌥⌘X        |                                | Whisper: Start/stop      |                          |          |
| ⌃⌥⌘←                                          | ⌃⌥⌘←        |                                | Navigate back            |                          |          |
| ⌃⌥⌘→                                          | ⌃⌥⌘→        |                                | Navigate forward         | Terminal: Split          |          |
| ⌃⌥⌘↓ ⌃⌥⌘↑                                     | chord       |                                |                          | Quick input: Accept bg   |          |
| **⇧⌘ (Shift + Cmd)**                          |             |                                |                          |                          |          |
| ⇧⌘2                                           | ⇧⌘2         | Screenshot: Save full screen   |                          |                          | Modified |
| ⇧⌘3                                           | ⇧⌘3         | Screenshot: Copy full screen   |                          |                          | Modified |
| ⇧⌘4                                           | ⇧⌘4         | Screenshot: Copy selection     |                          |                          | Modified |
| ⇧⌘5                                           | ⇧⌘5         | Screenshot: Save selection     |                          |                          | Modified |
| ⇧⌘6                                           | ⇧⌘6         | Screenshot & recording         |                          |                          |          |
| **⇧ (Shift)**                                 |             |                                |                          |                          |          |
| ⇧Enter                                        | ⇧Enter      |                                |                          | Terminal: Send esc+enter |          |

## BTT (floating menus, no keyboard shortcuts)

| Menu | App | Items |
|------|-----|-------|
| Mini Menu Left | Global | Insert date (yyyy.MM.dd), Insert DP.yyyy.MM.dd |
| code_menu | VS Code | /logissue, /getstatus, /logtask |
| obsidian_menu | Obsidian | C2O operations, tree operations |

## Source files

| Tool | Config file |
|------|-------------|
| Karabiner | `karabiner/.config/karabiner/karabiner.json` |
| Obsidian | `obsidian/.obsidian/hotkeys.json` |
| VS Code | `code/.config/Code/User/keybindings.json` |
| BTT | `btt/*.bttpreset` |
| macOS | `bootstrap.sh` (defaults write) |
