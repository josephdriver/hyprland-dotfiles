#!/usr/bin/env bash
set -euo pipefail

print_status() {
  local label="$1"
  local cmd="$2"

  if eval "$cmd" >/dev/null 2>&1; then
    printf '[OK] %s\n' "$label"
  else
    printf '[!!] %s\n' "$label"
  fi
}

printf 'Sprint 11 validation\n'
printf '====================\n'

print_status 'hyprpaper installed' 'pacman -Q hyprpaper'
print_status 'repo hyprpaper config present' 'test -f config/hypr/hyprpaper.conf'
print_status 'user hyprpaper config present' 'test -f "$HOME/.config/hypr/hyprpaper.conf"'
print_status 'hyprpaper binary available' 'command -v hyprpaper'
print_status 'Hyprland autostart launches hyprpaper' "grep -Fq 'hyprpaper' \"$HOME/.config/hypr/modules/30-autostart.conf\""
print_status 'wallpaper file exists' 'test -f /usr/share/wallpapers/cachyos-wallpapers/CachyOS_Moon.jpg'
print_status 'hyprpaper running' 'pgrep -x hyprpaper'

printf '\nManual checks still required:\n'
printf '1. Confirm the wallpaper is visible on startup.\n'
