# Brewfile — state, drift and upkeep

`brew/Brewfile` is the list of everything Homebrew should install on a new Mac. It is a **wish list, not a mirror**: it says what should be there, and drifts from what actually is as packages age.

```bash
brew bundle check   --file=~/code/dotfiles/brew/Brewfile   # what's out of step
brew bundle install --file=~/code/dotfiles/brew/Brewfile   # bring the Mac up to the file
brew bundle dump    --file=~/code/dotfiles/brew/Brewfile --force   # bring the file up to the Mac
```

`brew bundle check` says only *"needs to be installed or updated"* — it never distinguishes **missing** from **merely old**, which makes its output look far more alarming than it is. The classification below is the useful version.

## Drift snapshot — 2026.09.05

47 entries flagged. Almost all are simply behind:

| Category | Count | Meaning |
|---|---|---|
| **Installed but outdated** | 42 | Working fine, newer version exists. Cosmetic. |
| **Genuinely missing** | 1 | `fzf` — see below, this one costs you something |
| **Mac App Store, detection issue** | 3 | Present on disk, `mas` can't see them |
| **Mac App Store, really absent** | 1 | Xcode |

### The one that matters: `fzf`

`fzf` is in the Brewfile and **is not installed**. `zsh/.zshrc` lines 28–29 source its key bindings behind an `[ -f … ]` guard, so they fail silently — you lose <kbd>Ctrl-R</kbd> fuzzy history search and <kbd>Ctrl-T</kbd> fuzzy file insert, with no error to tell you why.

```bash
brew install fzf
```

### Mac App Store entries are unreliable

`mas` cannot reliably detect installed App Store apps on current macOS — it depends on Spotlight indexing. Verified by hand:

| Brewfile entry | Reality |
|---|---|
| `mas "Hyper Cursor"` | Present in `/Applications` — mas just can't see it |
| `mas "NordPass…"` | Present in `/Applications` — same |
| `mas "Kindle", id: 302584613` | Present, but Amazon **renamed it to `Amazon Kindle.app`**, so the entry no longer matches |
| `mas "Xcode"` | Genuinely not installed |

Treat every `App … needs to be installed` line as unproven until you look in `/Applications`.

### The 42 outdated

`awscli · bitwarden-cli · blackhole-2ch · btop · cloudflared · dust · fastfetch · fd · ffmpeg · font-meslo-lg-nerd-font · gh · ghostscript · git-lfs · gitleaks · glow · go · gum · imagemagick · kubernetes-cli · libpq · maccy · mas · mise · neovim · node · openslide · pandoc · rclone · ripgrep · ruby · starship · supacode · television · terragrunt · tmux · tree-sitter-cli · typst · vips · xcodegen · yt-dlp · zerotier-one · zoxide`

Upgrading is optional and occasionally disruptive — `node`, `go` and `ruby` can break projects pinned to a version. To upgrade everything:

```bash
brew upgrade            # formulae
brew upgrade --cask     # apps
```

Or one at a time, which is safer for the language runtimes.

## Two standing warnings

**Circular dependency.** Homebrew reports `libtiff, webp` as circular — stale metadata in installed keg tabs, harmless. If it becomes noisy:

```bash
brew update
brew uninstall --ignore-dependencies --force libtiff webp
brew install libtiff webp
```

**Tap trust.** Newer Homebrew asks you to trust third-party taps: `ngs/tap`, `nikitabobko/tap`, `vicentereig/tap`. Either trust them explicitly or ignore the notice — do **not** set `HOMEBREW_NO_REQUIRE_TAP_TRUST=1`, which disables the check globally.

```bash
brew trust ngs/tap nikitabobko/tap vicentereig/tap
```

## When you install something new

1. `brew install …` / `brew install --cask …`
2. Add the line to `brew/Brewfile` **with its one-line comment**, in the right block (formulae, then casks, then `mas`)
3. Commit to `kilo9alfa/dotfiles`, and copy to `dotfiles-public` — the Brewfile is a both-repos file
4. If it adds keyboard shortcuts, document them: see [`../cheatsheet.md`](../cheatsheet.md)

Prefer hand-editing the Brewfile over `brew bundle dump --force`: the dump discards the comments and the grouping, and sweeps in every transitive dependency.
