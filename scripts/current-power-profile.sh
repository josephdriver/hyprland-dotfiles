#!/usr/bin/env bash
set -euo pipefail

profile="$(powerprofilesctl get 2>/dev/null || true)"

case "$profile" in
  power-saver)
    icon="󰌪"
    ;;
  balanced)
    icon="󱎴"
    ;;
  performance)
    icon="󰓅"
    ;;
  *)
    icon="?"
    ;;
esac

printf '{"text":" %s ","tooltip":"Power profile: %s"}\n' "$icon" "$profile"
