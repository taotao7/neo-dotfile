# tmux-countdown

A fixed-width **goal countdown** for the tmux status bar. Set a target time and
the bar shows the remaining `⏳ DDd HH:MM:SS name` until it's reached.

Rendering is **async**: a background daemon recomputes the value once per second
and writes it into tmux options, so the status bar only ever reads a variable —
it never blocks on a subprocess (same non-blocking idea as tmux-cpu / battery).

## Usage

```bash
countdown set launch '2026-06-20 18:00'   # absolute date + time
countdown set standup '09:30'             # today (rolls to tomorrow if passed)
countdown set break '+90m'                # relative: +Ns / +Nm / +Nh / +Nd
countdown clear                           # remove the goal (widget disappears)
```

Re-running `set` replaces the existing goal — that's how you change the target/date.

## How it loads

`countdown.tmux` is run from `tmux.conf`:

```tmux
run-shell "~/.tmux/plugins/tmux-countdown/countdown.tmux"
```

It starts the daemon and exposes the `countdown` CLI (symlinked into
`~/.local/bin`). The status bar reads two options the daemon maintains:

| option               | meaning                                |
|----------------------|----------------------------------------|
| `@countdown_display` | rendered text (icon + clock + name)    |
| `@countdown_active`  | `1` when a goal is set, else `0`        |

Status segment (gated so it's hidden when no goal is set):

```tmux
set -ga status-right "#{?#{==:#{@countdown_active},1},#[fg=#{@tape_orange}] #{@countdown_display}#[fg=#{@tape_gray}] │ ,}"
```

Goal state is stored in `~/.tmux/countdown.state`. macOS / BSD `date`.
