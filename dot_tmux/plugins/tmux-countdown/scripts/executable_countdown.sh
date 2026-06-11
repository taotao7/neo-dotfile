#!/usr/bin/env bash
# tmux-countdown — a goal countdown for the tmux status bar (macOS / BSD date).
#
# Async design: the status bar never runs this script inline. A background
# `daemon` loop (started by countdown.tmux) recomputes the remaining time once
# per second and pushes it into two tmux options that the status bar reads:
#
#     @countdown_display   the rendered text (icon + clock + name)
#     @countdown_active    1 when a goal is set, 0 otherwise (gates visibility)
#
# CLI:
#     countdown set <name> <when>   create/replace a goal
#     countdown clear               remove the goal
#     countdown show                print remaining once (manual/testing)
#     countdown daemon              run the async updater loop (internal)
#
# <when> accepts:
#     2026-06-20 18:00      absolute date + time
#     2026-06-20 18:00:00   absolute with seconds
#     18:00                 today at that time (tomorrow if already passed)
#     +90m  +2h  +3d  +45s  relative from now

STATE="${HOME}/.tmux/countdown.state"
PIDFILE="${HOME}/.tmux/.countdown-daemon.pid"
NAME_WIDTH=10   # name is truncated/padded to this for a fixed-width slot

die() { printf '%s\n' "$*" >&2; exit 1; }

# Parse a <when> string into an absolute epoch (echoes the epoch).
parse_when() {
  local when="$1" now epoch fmt n unit today
  now="$(date +%s)"

  if [[ "$when" =~ ^\+([0-9]+)([smhd])$ ]]; then
    n="${BASH_REMATCH[1]}"; unit="${BASH_REMATCH[2]}"
    case "$unit" in
      s) echo $(( now + n ));;
      m) echo $(( now + n * 60 ));;
      h) echo $(( now + n * 3600 ));;
      d) echo $(( now + n * 86400 ));;
    esac
    return 0
  fi

  for fmt in "%Y-%m-%d %H:%M:%S" "%Y-%m-%d %H:%M"; do
    if epoch="$(date -j -f "$fmt" "$when" +%s 2>/dev/null)"; then
      echo "$epoch"; return 0
    fi
  done

  if [[ "$when" =~ ^[0-9]{1,2}:[0-9]{2}$ ]]; then
    today="$(date +%Y-%m-%d)"
    epoch="$(date -j -f "%Y-%m-%d %H:%M" "$today $when" +%s 2>/dev/null)" \
      || die "could not parse time: $when"
    (( epoch <= now )) && epoch=$(( epoch + 86400 ))
    echo "$epoch"; return 0
  fi

  die "could not parse <when>: '$when' (try '2026-06-20 18:00', '18:00', or '+2h')"
}

# Render the current goal to stdout. Returns 0 when a goal is active, 1 when not.
render() {
  [[ -f "$STATE" ]] || return 1
  local epoch name now rem days hh mm ss
  IFS=$'\t' read -r epoch name < "$STATE"
  [[ "$epoch" =~ ^[0-9]+$ ]] || return 1
  now="$(date +%s)"; rem=$(( epoch - now ))
  name="$(printf '%-*.*s' "$NAME_WIDTH" "$NAME_WIDTH" "$name")"
  if (( rem <= 0 )); then
    printf '\360\237\216\211 %s reached!' "$name"     # 🎉
    return 0
  fi
  days=$(( rem / 86400 )); hh=$(( (rem % 86400) / 3600 ))
  mm=$(( (rem % 3600) / 60 )); ss=$(( rem % 60 ))
  printf '\342\217\263 %02dd %02d:%02d:%02d %s' "$days" "$hh" "$mm" "$ss" "$name"  # ⏳
  return 0
}

# Push current state into the tmux options the status bar reads.
# Returns non-zero if the tmux server is gone (so the daemon can exit).
push() {
  local out
  if out="$(render)"; then
    tmux set -gq @countdown_display "$out" 2>/dev/null || return 1
    tmux set -gq @countdown_active 1 2>/dev/null || return 1
  else
    tmux set -gq @countdown_display "" 2>/dev/null || return 1
    tmux set -gq @countdown_active 0 2>/dev/null || return 1
  fi
}

cmd_set() {
  local name="${1:-}"; shift || true
  local when="$*" epoch
  [[ -n "$name" && -n "$when" ]] || die "usage: countdown set <name> <when>"
  epoch="$(parse_when "$when")" || exit 1
  [[ "$epoch" =~ ^[0-9]+$ ]] || die "could not parse <when>: '$when'"
  printf '%s\t%s\n' "$epoch" "$name" > "$STATE"
  push   # instant feedback; daemon keeps it ticking
  printf 'Goal "%s" set for %s\n' "$name" "$(date -r "$epoch" '+%Y-%m-%d %H:%M:%S')"
}

cmd_clear() {
  rm -f "$STATE"
  push
  echo "Goal cleared."
}

cmd_daemon() {
  # Singleton: bail out if a live daemon already owns the pidfile.
  if [[ -f "$PIDFILE" ]] && kill -0 "$(cat "$PIDFILE" 2>/dev/null)" 2>/dev/null; then
    exit 0
  fi
  echo $$ > "$PIDFILE"
  trap 'rm -f "$PIDFILE"' EXIT
  while :; do
    push || break          # tmux server gone -> stop the loop
    sleep 1
  done
}

case "${1:-show}" in
  set)    shift; cmd_set "$@";;
  clear)  cmd_clear;;
  show)   render || true;;
  daemon) cmd_daemon;;
  *)      die "usage: countdown {set <name> <when>|clear|show|daemon}";;
esac
