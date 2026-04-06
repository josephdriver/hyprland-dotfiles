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

printf 'Sprint 07 validation\n'
printf '====================\n'

print_status 'rofi installed' 'pacman -Q rofi'
print_status 'power menu script present' 'test -f scripts/power-menu.sh'
print_status 'power menu script executable' 'test -x scripts/power-menu.sh'
print_status 'rofi binary available' 'command -v rofi'
print_status 'SUPER+M binding present' "grep -Fq 'bind = \$mainMod, M, exec, '$HOME'/.local/share/hyprland-setup/scripts/power-menu.sh' \"$HOME/.config/hypr/modules/80-keybinds.conf\""

printf '\nManual checks still required:\n'
printf '1. Press SUPER + M and confirm the power menu opens.\n'
printf '2. Test Lock, Logout, Reboot, and Shutdown carefully.\n'
