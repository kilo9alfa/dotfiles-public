# Obsidian plugin patches

Local fixes applied on top of community plugins. **Plugin updates overwrite `main.js`, so every patch here has to be reapplied after an update.** Each entry lists a reapply command.

| Plugin | Issue | Patch | Reapply |
|---|---|---|---|
| `vscode-editor` (sunxvming, v1.0.5) | Pinch-to-zoom drives the stored font size below zero; editor sticks at 6px and looks frozen | Clamp font size to 6–40 in the mousewheel handler | `obsidian/scripts/patch-vscode-editor.sh` |

---

## vscode-editor — runaway pinch-to-zoom

**Symptom:** the embedded code editor renders at the smallest possible size and will not zoom back in. Cmd+= appears to do nothing.

**Cause:** the plugin's ctrl+scroll (= macOS trackpad pinch) handler adjusts the font size by ±1 per event with no bounds:

```js
let delta = 0 < event.deltaY ? 1 : -1;
this.plugin.settings.fontSize += delta;   // no min, no max
```

One pinch gesture fires dozens of events, so a single hard pinch-in can push `fontSize` far negative — it reached `-36` on 2026.09.01. Monaco clamps *rendering* to its own 6px floor but the stored number keeps falling, so zooming back in needs one scroll tick per unit before anything visibly changes.

**There is no keyboard zoom in this plugin.** It registers exactly one command, "Create new code file". Cmd+= / Cmd+− are Obsidian's app-wide zoom and never touch Monaco's font size. The shortcuts are not broken — they were never wired to this editor.

**The patch** clamps the same line to a sane range:

```js
this.plugin.settings.fontSize = Math.min(40, Math.max(6, this.plugin.settings.fontSize + delta));
```

**Applied to:** the local vaults listed in the script (2026.09.01). Backups saved alongside as `main.js.orig`.

**Recovery without the patch:** Settings → VSCode Editor → Font size slider (range 5–30) resets the stored value in a couple of seconds. Use this if the editor is unreadable and you don't want to touch files.

**After editing `data.json` by hand:** reload Obsidian (Cmd+P → "Reload app without saving") before doing anything else. The running plugin holds settings in memory and will write the old value back over your edit on the next settings change.

**Upstream:** worth reporting at https://github.com/sunxvming/obsidian-vscode-editor — not yet filed.
