#!/bin/bash

# Define theme paths
DARK_THEME="$HOME/.tmux/themes/dark.conf"
LIGHT_THEME="$HOME/.tmux/themes/light.conf"
STATE_FILE="$HOME/.tmux/theme_state"

# Check current state
if [ ! -f "$STATE_FILE" ]; then
    echo "dark" > "$STATE_FILE"
fi

CURRENT_THEME=$(cat "$STATE_FILE")

if [ "$CURRENT_THEME" == "dark" ]; then
    tmux source-file "$LIGHT_THEME"
    echo "light" > "$STATE_FILE"
    tmux display-message " ☀️  LIGHT MODE ACTIVATED"
else
    tmux source-file "$DARK_THEME"
    echo "dark" > "$STATE_FILE"
    tmux display-message " 🌙  DARK MODE ACTIVATED"
fi
