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
    local latest=$(\ls -1t docs/*.EndOfSessionSummary.md 2>/dev/null | head -1)
    if [ -n "$latest" ]; then
        echo "📋 Last session: $latest"
        local session_id=$(sed -n 's/.*claude --resume \([^ ]*\).*/\1/p' "$latest" | head -1)
        if [ -n "$session_id" ]; then
            echo "🔗 Resume ID: $session_id"
        fi
        claude --dangerously-skip-permissions \
            --append-system-prompt "$(cat -- "$latest")" "$@"
    else
        claude --dangerously-skip-permissions "$@"
    fi
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
