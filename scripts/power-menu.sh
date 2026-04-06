#!/usr/bin/env bash
set -euo pipefail

choice="$({
  printf 'Lock\n'
  printf 'Logout\n'
  printf 'Reboot\n'
  printf 'Shutdown\n'
} | rofi -dmenu -p 'Power')"

case "$choice" in
  Lock)
    if [[ -x /usr/bin/hyprlock ]]; then
      pkill -x hyprlock 2>/dev/null || true
      /usr/bin/hyprlock
    elif [[ -x /usr/bin/loginctl ]]; then
      /usr/bin/loginctl lock-session
    fi
    ;;
  Logout)
    hyprctl dispatch exit
    ;;
  Reboot)
    systemctl reboot
    ;;
  Shutdown)
    systemctl poweroff
    ;;
  '')
    exit 0
    ;;
esac
