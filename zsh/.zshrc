# David's ZSH Configuration
# Managed with GNU Stow - https://github.com/kilo9alfa/dotfiles

# ===========================================
# Homebrew
# ===========================================
export PATH="$HOME/.local/bin:$PATH"
eval "$(/opt/homebrew/bin/brew shellenv)"

# ===========================================
# Plugin Manager: Antidote
# ===========================================
if [ -f "$HOMEBREW_PREFIX/opt/antidote/share/antidote/antidote.zsh" ]; then
    source $HOMEBREW_PREFIX/opt/antidote/share/antidote/antidote.zsh
    antidote load ${ZDOTDIR:-$HOME}/.zsh_plugins.txt
fi

# ===========================================
# Modern CLI Tools
# ===========================================
# Zoxide - smart cd
command -v zoxide >/dev/null 2>&1 && eval "$(zoxide init zsh)"

# Starship prompt
command -v starship >/dev/null 2>&1 && eval "$(starship init zsh)"

# fzf key bindings
[ -f "$HOMEBREW_PREFIX/opt/fzf/shell/key-bindings.zsh" ] && source "$HOMEBREW_PREFIX/opt/fzf/shell/key-bindings.zsh"
[ -f "$HOMEBREW_PREFIX/opt/fzf/shell/completion.zsh" ] && source "$HOMEBREW_PREFIX/opt/fzf/shell/completion.zsh"

# ===========================================
# Aliases
# ===========================================
# Editor
if [[ -n $SSH_CONNECTION ]]; then
    export EDITOR='vim'
else
    export EDITOR='code'
fi

# Modern replacements (if installed)
if command -v eza >/dev/null; then
    alias ls="eza -l --icons --git -a"
    alias lt="eza --tree --level=2 --long --icons --git"
    alias ltree="eza --tree --level=2 --icons --git"
else
    alias ls="ls -la"
fi

if command -v bat >/dev/null; then
    alias cat="bat --style=auto"
fi

# Markdown preview: live-render a file with glow, refreshing on save
# (e.g. Ctrl-S in micro). Pair with a cmux split. glow -s auto matches the
# current light/dark terminal background.
if command -v glow >/dev/null && command -v entr >/dev/null; then
    mdview() { echo "$1" | entr -c glow -s auto "$1"; }
fi

# Navigation
cx() { cd "$@" && ls; }
alias ..="cd .."
alias ...="cd ../.."
alias ....="cd ../../.."

# Git shortcuts
alias gs="git status"
alias gc="git commit -m"
alias gp="git push origin HEAD"
alias gpu="git pull origin"
alias glog="git log --graph --oneline -10"
alias gco="git checkout"
alias gb="git branch"
alias ga="git add"
alias gd="git diff"

# Utilities
alias reload="source ~/.zshrc"
alias clr="clear"
alias cpwd='pwd | pbcopy'

# Docs vault — rebuild ~/code/_docs symlinks to repo docs / CLAUDE.md / .claude
#   updatedocs            rebuild all repos (default)
#   updatedocs -all       rebuild all repos
#   updatedocs -repo NAME rebuild one repo
updatedocs() { ~/code/_docs/link-repos.sh "$@"; }

# cmux + neovim — open a file for editing in a new split pane beside the terminal.
#   cn <file>
# Markdown/mdx also gets a live cmux preview split (edit│preview, Obsidian-style);
# code files open in the editor split alone. Outside cmux, falls back to plain nvim.
cn() {
    emulate -L zsh
    local f="$1"
    if [[ -z "$f" ]]; then
        print -u2 "usage: cn <file>"; return 1
    fi
    local abs="${f:A}"                       # absolute path — robust across panes/cwd

    # Not inside cmux (or no cmux CLI)? Just edit right here.
    if [[ -z "$CMUX_SURFACE_ID" ]] || ! command -v cmux >/dev/null; then
        command nvim "$abs"; return
    fi

    local uuid='[0-9A-Fa-f]{8}-[0-9A-Fa-f]{4}-[0-9A-Fa-f]{4}-[0-9A-Fa-f]{4}-[0-9A-Fa-f]{12}'

    # Editor pane to the right, focused so you land in nvim.
    local eid
    eid=$(cmux new-split right --focus true --id-format uuids 2>/dev/null | grep -oE "$uuid" | head -1)
    if [[ -z "$eid" ]]; then
        print -u2 "cn: could not create cmux split — editing here instead"
        command nvim "$abs"; return
    fi
    cmux send --surface "$eid" "nvim ${(q)abs}\n"

    # Markdown → add a live cmux preview split beside the editor.
    case "${f:e:l}" in
        md|markdown|mdx)
            [[ -f "$abs" ]] || return   # nothing to preview for a not-yet-created file
            local pid
            pid=$(cmux new-split right --surface "$eid" --focus false --id-format uuids 2>/dev/null | grep -oE "$uuid" | head -1)
            if [[ -n "$pid" ]]; then
                cmux open "$abs" --surface "$pid" --no-focus >/dev/null 2>&1
                cmux close-surface --surface "$pid" >/dev/null 2>&1   # drop the placeholder shell behind the preview
            fi
            ;;
    esac
}

# Claude Code
clauded() {
    export CLAUDE_CODE_NO_FLICKER=1
    if [[ "$1" == fork:* ]]; then
        local fork_id="${1#fork:}"
        echo "🔀 Forking session: $fork_id"
        claude --dangerously-skip-permissions --resume "$fork_id" --fork-session
        return
    fi
    if [[ "$1" == id:* ]]; then
        local resume_id="${1#id:}"
        echo "🔗 Resuming session: $resume_id"
        claude --dangerously-skip-permissions --resume "$resume_id"
        return
    fi
    if [[ "$1" == artifact* ]]; then
        # Load artifact channel for interactive HTML feedback
        # Usage: clauded artifact              (kilo9alfa root)
        #        clauded artifact:b2026        (cd to source repo)
        #        clauded artifact:bru2025_maxdis
        local artifact_project="${1#artifact}"
        artifact_project="${artifact_project#:}"
        local k9a_dir="/Users/david/code/kilo9alfa"

        # Map project keys to their source directories.
        # When a project is specified, Claude's session runs from the source
        # repo so it edits the right files and has the project's CLAUDE.md.
        local work_dir="$k9a_dir"
        case "$artifact_project" in
            b2026)           work_dir="/Users/david/code/b2026" ;;
            bru2025_maxdis)  work_dir="/Users/david/code/bru2025" ;;
            bru2025)         work_dir="/Users/david/code/bru2025" ;;
            x)               work_dir="$k9a_dir" ;;  # source is Obsidian, serve from k9a
            "")              work_dir="$k9a_dir" ;;
        esac

        echo "🎨 Starting artifact channel${artifact_project:+ (project: $artifact_project)}"
        echo "   Working dir: $work_dir"
        local open_url="http://localhost:3000${artifact_project:+/${artifact_project}/}"
        echo "   Preview: $open_url"
        echo "   Tip: click 💬 Feedback on any element to send comments to Claude"
        # Kill any existing artifact server to avoid port conflict
        lsof -ti:3000 | xargs kill 2>/dev/null
        # Open browser after delay — server needs ~4s to start via MCP
        (sleep 5 && open "$open_url") &
        # Pass MCP config inline so it only runs for artifact sessions
        local mcp_json='{"mcpServers":{"artifact":{"command":"/Users/david/.bun/bin/bun","args":["/Users/david/code/kilo9alfa/artifacts/channel.ts"]}}}'
        cd "$work_dir" && claude --dangerously-skip-permissions \
               --mcp-config "$mcp_json" \
               --dangerously-load-development-channels server:artifact \
               "${@:2}"
        return
    fi
    # Prefer lean CurrentState.md; fall back to latest EndOfSessionSummary.md
    local context_file="docs/CurrentState.md"
    if [ ! -f "$context_file" ]; then
        context_file=$(\ls -1t docs/*.EndOfSessionSummary.md 2>/dev/null | head -1)
    fi
    if [ -n "$context_file" ] && [ -f "$context_file" ]; then
        echo "📋 Loading context: $context_file"
        local session_id=$(sed -n 's/.*claude --resume \([^ ]*\).*/\1/p' "$context_file" | head -1)
        if [ -n "$session_id" ]; then
            echo "🔗 Resume ID: $session_id"
        fi
        claude --dangerously-skip-permissions \
            --append-system-prompt "$(cat -- "$context_file")" "$@"
    else
        claude --dangerously-skip-permissions "$@"
    fi
}

# nucclauded — run Nuclaw's clauded inside tmux, survives SSH drops.
# Usage:
#   nucclauded <project> [clauded-args...]    e.g. nucclauded localr5
#                                                 nucclauded investingwithclaude id:abc-123
# Reattach later: ssh -t r5c-1 'tmux a -t <project>'
nucclauded() {
    if [ -z "$1" ]; then
        echo "usage: nucclauded <project> [clauded args...]" >&2
        echo "  reattach: ssh -t r5c-1 'tmux a -t <project>'" >&2
        return 1
    fi
    local project="$1"; shift
    ssh -t r5c-1 "tmux new -A -s '$project' \"bash -lic 'cd ~/code/$project && clauded $*'\""
}

# nlr5 — force-reattach the localr5 tmux session on Nuclaw, kicking any other client.
nlr5() {
    ssh -t r5c-1 'tmux attach -d -t localr5'
}

# ===========================================
# Development Environments
# ===========================================
# Rust
[ -s "$HOME/.cargo/env" ] && \. "$HOME/.cargo/env"

# Node (nvm)
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"

# Python (uv or pyenv)
# Uncomment if using uv:
# eval "$(uv generate-shell-completion zsh)"

# ===========================================
# Startup
# ===========================================
# Show system info on new terminal (optional)
# command -v fastfetch >/dev/null 2>&1 && fastfetch

# bun completions
[ -s "/Users/david/.bun/_bun" ] && source "/Users/david/.bun/_bun"

# bun
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"

# Vaultwarden (bw) session — auto-loaded so bw get password works without re-unlocking
# Same pattern as Nuclaw ~/.bashrc. Revoke: bw logout && rm ~/.config/bw-session
[ -r "$HOME/.config/bw-session" ] && export BW_SESSION="$(cat "$HOME/.config/bw-session")"
