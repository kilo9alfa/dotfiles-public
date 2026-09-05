# Keyboard Shortcuts Map

Single source of truth for all custom keyboard shortcuts.

## How modifiers work

```
Physical key press          What the system sees         Who responds
─────────────────           ────────────────────         ────────────
L⌥ + N/R/S/↑/←/→    →      ⌃⌥ + key                   → VS Code (specific keys only)
⌃⌥N (pressed directly) →    ⌃⌥N                       → cmux: mirror Nuclaw tmux (not in VS Code)
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
| ⌃T                                            | ⌃T          | cmux: toggle light/dark theme  |                          |                          | Karabiner (cmux only), runs `cmux/cmux-theme-toggle.sh` |
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
| ⌃⌥N                                            | ⌃⌥N         | cmux: mirror Nuclaw tmux (`ssh-tmux r5c-1`) |             | New terminal in editor   | Karabiner (all apps **except** VS Code), runs `cmux/cmux-nuclaw.sh`. Reached via physical ⌃⌥N — L⌥+N still goes to VS Code, since Karabiner does not re-process its own output. |
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

## nvim (Neovim)

Leader key is `Space`. Press `Space` alone and wait — which-key lists everything. These are the **custom** mappings only; for built-in vim keys (`dd`, `cw`, `/`, `.` …) see the full cheatsheet: `nvim/cheatsheet.html` — open with `cmux browser open file://$HOME/code/dotfiles/nvim/cheatsheet.html`.

| Key | Does | From |
|-----|------|------|
| `Space` `w` / `q` | Save / quit | `lua/keymaps.lua` |
| `Ctrl` `h` `j` `k` `l` | Move between splits | `lua/keymaps.lua` |
| `Esc` | Clear search highlight | `lua/keymaps.lua` |
| `<` / `>` (visual) | Indent left / right and keep selection | `lua/keymaps.lua` |
| `Space` `ff` / `fg` | Find files / search text in project | telescope |
| `Space` `fb` / `fr` / `fh` | Buffers / recent files / help | telescope |
| `Space` `z` | Zen mode | snacks |
| `Space` `mi` | Preview image under cursor | snacks |
| `Space` `oo` / `os` / `oq` | Obsidian: open in app / search vault / quick switch | obsidian.nvim |
| `Space` `on` / `od` / `oy` | Obsidian: new note / today / yesterday | obsidian.nvim |
| `Space` `ob` / `ot` / `op` | Obsidian: backlinks / tags / paste image | obsidian.nvim |
| `Space` `ol` (visual) | Obsidian: link selection | obsidian.nvim |

### LSP — only active in files a language server attaches to

| Key | Does |
|-----|------|
| `gd` or `F12` | Go to definition (`F12` mirrors VS Code) |
| `Ctrl` `o` | Jump back after `gd` (built-in) |
| `K` | Show type / docs under cursor |
| `gr` / `gi` / `gD` | References / implementation / declaration |
| `Space` `rn` | Rename symbol everywhere |
| `Space` `ca` | Code action |
| `Space` `e` | Show full diagnostic under cursor |
| `[d` / `]d` | Previous / next diagnostic |

TypeScript uses `tsc --lsp` (TypeScript 7's native server) from the project's own `node_modules`. Older projects need `ts_ls` uncommented in `lua/plugins/lsp.lua`.

### Git — gitsigns + snacks

| Key | Does |
|-----|------|
| `]c` / `[c` | Next / previous change |
| `Space` `gp` | Preview this change (popup) |
| `Space` `gd` | Side-by-side diff of this file |
| `Space` `gr` / `gR` | Undo this change / all changes in file |
| `Space` `gs` / `gu` | Stage / unstage this change |
| `Space` `gb` | Toggle line blame |
| `Space` `gg` | Pick from changed files |
| `Space` `fe` | File tree sidebar, coloured by git status |

`Space` `fe` rather than `Space` `e` — the LSP's buffer-local `Space` `e` (show diagnostic) would shadow it in any file with a language server.

## Claude Code slash commands (no keyboard shortcut)

| Command | Does | Notes |
|---------|------|-------|
| `/rn <name>` | Renames the cmux **tab**, the cmux **workspace** (group) and the **Claude session** to `<name>`, all in one go | cmux only. Runs `cmux rename-tab` + `cmux workspace rename`, then types `/rename <name>` back into the terminal via `cmux send`. Lives in `claude-personal/commands/rn.md`, symlinked to `~/.claude/commands/rn.md` |

## Source files

| Tool | Config file |
|------|-------------|
| Karabiner | `karabiner/.config/karabiner/karabiner.json` |
| Obsidian | `obsidian/.obsidian/hotkeys.json` |
| VS Code | `code/.config/Code/User/keybindings.json` |
| BTT | `btt/*.bttpreset` |
| macOS | `bootstrap.sh` (defaults write) |
| nvim | `nvim/.config/nvim/lua/keymaps.lua` + `lua/plugins/*.lua` |
| Claude Code commands | `~/code/claude-personal/commands/` (symlinked into `~/.claude/commands/`) |
