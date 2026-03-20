#!/bin/bash
CACHE_FILE="/tmp/tmux-weather-cache"
CACHE_MAX_AGE=1800  # 30 minutes

# Chengdu coordinates
LAT=30.57
LON=104.07

if [ -f "$CACHE_FILE" ]; then
  last_modified=$(stat -f %m "$CACHE_FILE" 2>/dev/null)
  now=$(date +%s)
  age=$(( now - last_modified ))
  if [ "$age" -lt "$CACHE_MAX_AGE" ]; then
    cat "$CACHE_FILE"
    exit 0
  fi
fi

json=$(curl -s --max-time 5 "https://api.open-meteo.com/v1/forecast?latitude=${LAT}&longitude=${LON}&current=temperature_2m,weather_code" 2>/dev/null)

if [ -z "$json" ]; then
  [ -f "$CACHE_FILE" ] && cat "$CACHE_FILE" || echo "N/A"
  exit 0
fi

temp=$(echo "$json" | grep -o '"temperature_2m":[0-9.-]*' | tail -1 | cut -d: -f2)
code=$(echo "$json" | grep -o '"weather_code":[0-9]*' | tail -1 | cut -d: -f2)

if [ -n "$temp" ]; then
  temp_int=$(printf "%.0f" "$temp")
  result="${temp_int}°C"
  echo "$result" > "$CACHE_FILE"
  echo "$result"
elif [ -f "$CACHE_FILE" ]; then
  cat "$CACHE_FILE"
else
  echo "N/A"
fi
