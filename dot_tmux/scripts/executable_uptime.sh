#!/usr/bin/env bash
# Uptime in a readable format
uptime | awk '{
  if ($3 ~ /day/) {
    print $3 "d"
  } else {
    split($3, a, ":")
    print a[1] "h"
  }
}'
