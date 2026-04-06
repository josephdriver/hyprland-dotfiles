#!/usr/bin/env bash
set -euo pipefail

current="$(powerprofilesctl get 2>/dev/null || true)"

case "$current" in
  power-saver)
    next="balanced"
    ;;
  balanced)
    next="performance"
    ;;
  performance)
    next="power-saver"
    ;;
  *)
    next="balanced"
    ;;
esac

powerprofilesctl set "$next"
pkill -RTMIN+8 waybar 2>/dev/null || true
