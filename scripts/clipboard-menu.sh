#!/usr/bin/env bash
set -euo pipefail

selection="$(cliphist list | rofi -dmenu -p 'Clipboard')"

if [[ -z "$selection" ]]; then
  exit 0
fi

cliphist decode <<<"$selection" | wl-copy
