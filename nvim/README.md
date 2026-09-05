# Neovim config

Lua config managed by [lazy.nvim](https://github.com/folke/lazy.nvim). Stowed to `~/.config/nvim` on every machine; plugins and treesitter parsers are per-machine state under `~/.local/share/nvim/` (not tracked). `lazy-lock.json` pins plugin versions so each machine gets the same set. Keymap reference: [cheatsheet.html](cheatsheet.html).

## Requirements

| Tool | Why | macOS | Debian 12 |
|---|---|---|---|
| Neovim ≥ 0.11 (0.12 used) | `vim.lsp.enable`, treesitter `main` branch, `foldtext=""` | `brew install neovim` | apt ships 0.7 — use the release tarball (below) |
| tree-sitter CLI ≥ 0.26 | nvim-treesitter `main` builds parsers with it | `brew install tree-sitter-cli` | no prebuilt binary runs on glibc 2.36 — build with cargo (below) |
| C compiler | compiles parsers | Xcode CLT | `apt install build-essential` |
| ripgrep, fd, fzf | telescope / snacks pickers | brew | `apt install ripgrep fd-find fzf` + `ln -s $(which fdfind) ~/.local/bin/fd` |
| stow | symlinks the config | brew | `apt install stow` |

## Linux setup

```bash
sudo apt-get install -y ripgrep fd-find fzf stow build-essential libclang-dev
ln -sf "$(which fdfind)" ~/.local/bin/fd

# Neovim: official tarball into /opt/nvim, on PATH via /usr/local/bin
V=v0.12.5
curl -sSL -o /tmp/nvim.tar.gz https://github.com/neovim/neovim/releases/download/$V/nvim-linux-x86_64.tar.gz
sudo rm -rf /opt/nvim && sudo mkdir -p /opt/nvim && sudo tar -xzf /tmp/nvim.tar.gz -C /opt/nvim --strip-components=1
sudo ln -sf /opt/nvim/bin/nvim /usr/local/bin/nvim

# tree-sitter CLI: npm and GitHub release binaries need glibc 2.39, so compile it (several minutes)
curl -sSf https://sh.rustup.rs | sh -s -- -y --profile minimal --no-modify-path
~/.cargo/bin/cargo install tree-sitter-cli --version 0.26.9 --root ~/.local   # needs libclang-dev

# config
git clone git@github.com:<you>/dotfiles.git ~/code/dotfiles
cd ~/code/dotfiles && stow -t ~ nvim
nvim --headless "+Lazy! restore" +qa          # plugins at lazy-lock.json versions; parsers build on first start
```

Upgrade Neovim later by repeating the tarball block with a newer `V`. Upgrade tree-sitter with the same `cargo install` line and a newer version.

## Machine-specific behaviour

| Feature | Mac | Linux |
|---|---|---|
| obsidian.nvim | active, 3 iCloud vaults | auto-disabled (`plugins/obsidian.lua` checks the vault paths exist) |
| `<leader>oo` etc. | vault commands | no-op |
| Clipboard (`unnamedplus`) | pbcopy | OSC 52 through SSH — needs `set -g set-clipboard on` + `allow-passthrough on` in `~/.tmux.conf` |
| Truecolor | native | tmux: `default-terminal tmux-256color` + `terminal-features ...:RGB` |
| tsc LSP | per-project `node_modules` | same |
