#!/usr/bin/env bash
# Battery percentage for macOS
pmset -g batt | grep -Eo "\d+%" | cut -d% -f1
