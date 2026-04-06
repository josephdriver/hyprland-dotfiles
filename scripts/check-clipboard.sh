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

printf 'Sprint 12 validation\n'
printf '====================\n'

print_status 'cliphist installed' 'pacman -Q cliphist'
print_status 'wl-clipboard installed' 'pacman -Q wl-clipboard'
print_status 'cliphist binary available' 'command -v cliphist'
print_status 'wl-paste available' 'command -v wl-paste'
print_status 'wl-copy available' 'command -v wl-copy'
print_status 'clipboard menu script present' 'test -f scripts/clipboard-menu.sh'
print_status 'clipboard menu script executable' 'test -x scripts/clipboard-menu.sh'
print_status 'text clipboard watcher configured' "grep -Fq 'wl-paste --type text --watch cliphist store' \"$HOME/.config/hypr/modules/30-autostart.conf\""
print_status 'primary clipboard watcher configured' "grep -Fq 'wl-paste --primary --type text --watch cliphist store' \"$HOME/.config/hypr/modules/30-autostart.conf\""
print_status 'clipboard keybind present' "grep -Fq 'bind = \$mainMod, X, exec, '$HOME'/.local/share/hyprland-setup/scripts/clipboard-menu.sh' \"$HOME/.config/hypr/modules/80-keybinds.conf\""

printf '\nManual checks still required:\n'
printf '1. Copy text and confirm cliphist stores it.\n'
printf '2. Press SUPER + X and confirm rofi shows clipboard history.\n'
printf '3. Select an entry and confirm it is copied back to the clipboard.\n'
