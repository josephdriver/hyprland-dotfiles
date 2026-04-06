#!/usr/bin/env bash
set -euo pipefail

pid_file="${XDG_RUNTIME_DIR:-/tmp}/wf-recorder.pid"
dir="${XDG_VIDEOS_DIR:-$HOME/Videos}/Recordings"
mkdir -p "$dir"

if [[ -f "$pid_file" ]] && kill -0 "$(cat "$pid_file")" 2>/dev/null; then
  kill -INT "$(cat "$pid_file")"
  rm -f "$pid_file"
  exit 0
fi

file="$dir/recording-$(date +%Y%m%d-%H%M%S).mp4"
wf-recorder -g "$(slurp)" -f "$file" >/dev/null 2>&1 &
echo $! > "$pid_file"
