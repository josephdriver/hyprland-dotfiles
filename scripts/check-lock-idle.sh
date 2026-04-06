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

printf 'Sprint 10 validation\n'
printf '====================\n'

print_status 'hyprlock installed' 'pacman -Q hyprlock'
print_status 'hypridle installed' 'pacman -Q hypridle'
print_status 'hyprlock config present in repo' 'test -f config/hypr/hyprlock.conf'
print_status 'hypridle config present in repo' 'test -f config/hypr/hypridle.conf'
print_status 'user hyprlock config present' 'test -f "$HOME/.config/hypr/hyprlock.conf"'
print_status 'user hypridle config present' 'test -f "$HOME/.config/hypr/hypridle.conf"'
print_status 'hyprlock binary available' 'command -v hyprlock'
print_status 'hypridle binary available' 'command -v hypridle'
print_status 'Hyprland autostart launches hypridle' "grep -Fq 'hypridle' \"$HOME/.config/hypr/modules/30-autostart.conf\""
print_status 'hypridle running' 'pgrep -x hypridle'

printf '\nManual checks still required:\n'
printf '1. Run hyprlock and confirm the lock screen appears.\n'
printf '2. Wait for the idle timeout and confirm the session locks.\n'
printf '3. Stay idle for 30 more seconds and confirm the displays power off.\n'
printf '4. Move the mouse or press a key and confirm the displays wake back up to the lock screen.\n'
