#!/bin/bash
# Open a remote host's tmux sessions as a mirrored cmux window (tmux -CC over SSH).
# Each remote tmux session becomes a cmux workspace, each window a tab.
# Bound to ⌃⌥N (outside VS Code) via Karabiner — see karabiner.json.
# Requires the "Remote tmux" beta enabled in cmux Settings.
set -euo pipefail

CMUX="/Applications/cmux.app/Contents/Resources/bin/cmux"
HOST="my-ssh-alias"   # any ~/.ssh/config alias or user@host

exec "$CMUX" ssh-tmux "$HOST"
