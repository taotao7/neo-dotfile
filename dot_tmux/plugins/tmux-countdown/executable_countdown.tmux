#!/usr/bin/env bash
# tmux-countdown plugin entry point.
# Loaded from tmux.conf via:  run-shell "~/.tmux/plugins/tmux-countdown/countdown.tmux"
#
# It (1) exposes the `countdown` CLI on PATH, (2) initialises the display
# options, and (3) starts the async updater daemon in the background so the
# status bar only ever reads a tmux option — it never blocks on a subprocess.

CURRENT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
CLI="${CURRENT_DIR}/scripts/countdown.sh"

# Make `countdown` available on PATH (best-effort).
if [[ -d "${HOME}/.local/bin" ]]; then
  ln -sf "$CLI" "${HOME}/.local/bin/countdown"
fi

# Hidden until a goal is set.
tmux set -gq @countdown_display ""
tmux set -gq @countdown_active 0

# Start the async daemon (singleton; runs in the background, non-blocking).
tmux run-shell -b "'${CLI}' daemon"
