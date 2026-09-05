# cmux

Two things live here, and they are handled differently.

| Path | What | How it reaches the Mac |
|---|---|---|
| `.config/cmux/cmux.json` | cmux settings — shortcuts, appearance, pane borders | **Stowed**: `stow --no-folding -t ~ cmux` |
| `cmux-nuclaw.sh`, `cmux-theme-toggle.sh` | Helper scripts Karabiner invokes | **Not stowed** — they stay in the repo and are called by absolute path |

`.stow-local-ignore` keeps the scripts out of `$HOME`. Karabiner calls them at `~/code/dotfiles/cmux/…`, so they must not move.

```bash
cd ~/code/dotfiles
stow --no-folding -t ~ cmux
```

## The risk to watch: cmux may replace the symlink

cmux writes `cmux.json` itself whenever settings change in the UI. Most apps write *through* a symlink, which is what we want — edits land in the repo. Some apps instead write a new file and rename it into place, which **silently replaces the symlink with a plain file**, and from then on your edits in dotfiles no longer reach the live config.

Karabiner already does exactly this — see the note in the root `CLAUDE.md`.

**So check occasionally:**

```bash
ls -la ~/.config/cmux/cmux.json     # should print  -> ../../code/dotfiles/cmux/...
```

If it has become a real file, copy it back and re-stow:

```bash
cp ~/.config/cmux/cmux.json ~/code/dotfiles/cmux/.config/cmux/cmux.json
rm ~/.config/cmux/cmux.json
cd ~/code/dotfiles && stow --no-folding -t ~ cmux
```

## Do not reformat this file

`cmux-theme-toggle.sh` (⌃T) flips the theme with `grep` + `sed` on the literal string `"appearance" : "light"` — **cmux's own spacing, with spaces around the colon.** Rewriting `cmux.json` with a JSON pretty-printer produces `"appearance": "light"` and silently breaks the toggle: both greps miss, and the fallback branch inserts a duplicate `app` block.

Edit by hand, or with `sed`, preserving the spacing. Never round-trip it through `json.dump`/`jq`.

## Editing

Back up first — the root `CLAUDE.md` rule for this file:

```bash
cp ~/.config/cmux/cmux.json ~/.config/cmux/cmux.json.bak-$(date +%Y%m%d-%H%M%S)
```

Then edit `cmux/.config/cmux/cmux.json` in the repo and apply without restarting:

```bash
cmux reload-config    # reloads BOTH cmux.json and the Ghostty config
```

Schema and docs:

```bash
cmux docs settings
curl -fsSL https://raw.githubusercontent.com/manaflow-ai/cmux/main/web/data/cmux.schema.json
```

## What's currently set

| Key | Value | Why |
|---|---|---|
| `app.appearance` | `dark` | Toggled at runtime with ⌃T via `cmux-theme-toggle.sh` |
| `shortcuts.bindings.toggleSidebar` | ⌃`<` | Reclaims pane width — useful when a remote tmux window is wider than the visible pane |
| `shortcuts.bindings.browserZoomIn` | ⌘`+` | |
| `sidebarAppearance.matchTerminalBackground` | `true` | |
| `workspaceColors.indicatorStyle` | `solidFill` | |
| `paneBorderColor` | `#8A8F98` | Divider between panes — mid grey, reads on light and dark |
| `activePaneBorderColor` | `#2F6F4E` | Outline around the **focused** pane, so it's obvious where keystrokes go |

cmux offers **colour only** for pane borders — there is no width or thickness setting. To make them stronger, raise the contrast: `#B0B6C0` for a brighter divider, `#4C8DFF` or `#E0A45E` for a louder active outline.

These are cmux's own pane boundaries. Ghostty's internal splits are separate and unaffected — terminal behaviour (font, transparency, keybinds) lives in `~/.config/ghostty/config`.
