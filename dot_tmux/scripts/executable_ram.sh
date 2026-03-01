#!/usr/bin/env bash
# RAM percentage for macOS
vm_stat | awk '
  /Pages active/ { active = $3 }
  /Pages wired/ { wired = $4 }
  /Pages free/ { free = $3 }
  END {
    gsub(/\./,"",active)
    gsub(/\./,"",wired)
    gsub(/\./,"",free)
    total = active + wired + free
    used = active + wired
    if (total > 0) {
      printf "%.0f%%", (used / total) * 100
    } else {
      print "N/A"
    }
  }
'
