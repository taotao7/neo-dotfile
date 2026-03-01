#!/usr/bin/env bash
# CPU percentage for macOS
top -l 2 | grep "CPU usage" | tail -1 | awk '{print $3}' | sed 's/%//'
