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

printf 'Sprint 13 validation\n'
printf '====================\n'

print_status 'grim installed' 'pacman -Q grim'
print_status 'slurp installed' 'pacman -Q slurp'
print_status 'wf-recorder installed' 'pacman -Q wf-recorder'
print_status 'wl-clipboard installed' 'pacman -Q wl-clipboard'
print_status 'grim available' 'command -v grim'
print_status 'slurp available' 'command -v slurp'
print_status 'wf-recorder available' 'command -v wf-recorder'
print_status 'screenshot script present' 'test -f scripts/take-screenshot.sh'
print_status 'recording script present' 'test -f scripts/toggle-recording.sh'
print_status 'screenshot bind present' "grep -Fq 'bind = \$mainMod ALT, S, exec, '$HOME'/.local/share/hyprland-setup/scripts/take-screenshot.sh' \"$HOME/.config/hypr/modules/80-keybinds.conf\""
print_status 'recording bind present' "grep -Fq 'bind = \$mainMod ALT, R, exec, '$HOME'/.local/share/hyprland-setup/scripts/toggle-recording.sh' \"$HOME/.config/hypr/modules/80-keybinds.conf\""

printf '\nManual checks still required:\n'
printf '1. Press SUPER+ALT+S and confirm a screenshot is saved.\n'
printf '2. Press SUPER+ALT+R to start recording and press it again to stop.\n'
printf '3. Confirm the saved video plays correctly.\n'
