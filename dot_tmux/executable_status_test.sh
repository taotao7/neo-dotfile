#!/bin/bash

# Test script to check what's working

echo "=== Plugin Status Check ==="

# Check CPU
if command -v top &> /dev/null; then
    cpu=$(top -l 1 | grep "CPU usage" | awk '{print $3}' | sed 's/%//')
    echo "CPU: ${cpu}%"
fi

# Check RAM
if command -v vm_stat &> /dev/null; then
    ram=$(vm_stat | grep "Pages active" | awk '{print $3}' | sed 's/\.//')
    echo "RAM: Available"
fi

# Check Battery
if command -v pmset &> /dev/null; then
    battery=$(pmset -g batt | grep -Eo "\d+%" | cut -d% -f1)
    echo "Battery: ${battery}%"
fi

# Check Network
if ping -c 1 8.8.8.8 &> /dev/null; then
    echo "Network: Online"
else
    echo "Network: Offline"
fi

# Check Uptime
uptime_info=$(uptime | awk '{print $3}' | sed 's/,//')
echo "Uptime: ${uptime_info}"

echo ""
echo "=== Icon Display Test ==="
echo "Session:  "
echo "CPU: 󰻠"
echo "RAM: "
echo "Network: "
echo "Uptime: "
echo "Battery: "
echo "Weather: "
echo "Clock: "
echo "Terminal: "
