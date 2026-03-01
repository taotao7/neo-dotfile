#!/usr/bin/env bash
# Network status
if ping -c 1 -W 1 8.8.8.8 &> /dev/null; then
    echo ""
else
    echo ""
fi
