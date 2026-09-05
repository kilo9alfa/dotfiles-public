# The cheatsheet page — how it works, and when to update it

`nvim/cheatsheet.html` is David's single browsable reference for **every keyboard binding on this Mac**. One self-contained HTML file, no dependencies, opened with:

```bash
cmux browser open file://$HOME/code/dotfiles/nvim/cheatsheet.html
```

## The rule

**Whenever a new tool, plugin, alias, hotkey or slash command is added — update this page in the same session that adds it.** A shortcut that isn't on the page effectively doesn't exist, because this is where David looks. Treat it the way you'd treat a test: the change isn't finished until the page reflects it.

Update `keyboard-shortcuts.md` too — for anything that is **actually a key**. That file is the editable source of truth for keybindings; the HTML is the readable face of it. They are maintained by hand in parallel — there is no generator, deliberately, because the HTML carries explanation and emphasis that a generated table cannot.

**CLI commands live only in the HTML.** The `Terminal` and `git & gh` tabs document commands and aliases, not keypresses, so they have no counterpart in `keyboard-shortcuts.md`. Don't bloat that file with them.

## Structure

| Piece | What it does |
|---|---|
| `<nav id="tabs">` | One `<button data-app="…">` per tool. Order here sets the tab order. |
| `<div class="panel" data-app="…">` | One panel per tool, holding a `.grid` of `<section>` cards. All but the first carry `hidden`. |
| `<section data-app="…">` | One card. **The `data-app` must match its panel** — search uses it to label and count results. |
| `<span class="appchip">Name</span>` | Inside each card's `<h2>`. Hidden normally; shown during a search so a result says which app it came from. |
| `.lede` | Optional green intro box per panel. Hidden during search. |
| `<p class="foot">` | Small grey note under a card's table — for caveats and "why". |

## Conventions that make it useful

- **Keys in `<kbd>`, commands and paths in `<code>`.** Shifted keys are written as they are pressed: `z⇧R`, not `zR`.
- **`<span class="star">★</span>`** marks the handful worth memorising. Used sparingly — roughly one per card.
- **`<em>` inside a description** is the muted aside: *(your custom key)*, *(needs Shift)*.
- **Explain the trap, not just the key.** The `⌘D does not work in an ssh-tmux workspace` note is worth more than the row above it.
- **Only document what has been verified**, in the config or by running it. No plausible-looking rows.

## Adding a new tool

1. Add a `<button data-app="newtool">Name</button>` to `<nav>`.
2. Add `<div class="panel hidden" data-app="newtool">` with a `.grid` inside.
3. Add `<section data-app="newtool">` cards, each with an `.appchip` in its `<h2>`.
4. Read the bindings from the tool's **actual config file** — never from memory.
5. Add the same content to `keyboard-shortcuts.md`.
6. Reload and check the search: type a key that should match and confirm the new tab shows a count.

Adding rows to an existing tool is just steps 3–6.

## Behaviour worth preserving

- **Search spans every tab.** Typing reveals matching cards from all panels at once, adds a hit count to each tab button, and shows the app chips. This is the feature that makes the page a lookup tool rather than six lists — don't scope search to the active tab.
- `/` focuses the search box, `Esc` clears it.
- The selected tab persists in `localStorage`, wrapped in `try/catch`.
- The page prints: every panel expands, nav and search box are hidden.
- Light/dark follows the system, defined with CSS custom properties on `:root`.

## Known wart

The file still lives in `nvim/` from when it was nvim-only. **Leave it there** — David has the URL. Moving it would break his bookmark for no gain.

## Related

| File | Role |
|---|---|
| `keyboard-shortcuts.md` | Markdown source of truth; also symlinked into the Obsidian vault at `!/PER/keyboard-shortcuts.md` |
| `nvim/cheatsheet.html` | This page |
| `nvim/README.md` | nvim setup notes (install, Linux/Nuclaw) |
