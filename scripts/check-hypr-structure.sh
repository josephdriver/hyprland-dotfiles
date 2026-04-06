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

printf 'Sprint 08 validation\n'
printf '====================\n'

print_status 'Hyprland config root exists' 'test -f "$HOME/.config/hypr/hyprland.conf"'
print_status 'modules directory exists' 'test -d "$HOME/.config/hypr/modules"'
print_status 'monitor module present' 'test -f "$HOME/.config/hypr/modules/10-monitors.conf"'
print_status 'programs module present' 'test -f "$HOME/.config/hypr/modules/20-programs.conf"'
print_status 'autostart module present' 'test -f "$HOME/.config/hypr/modules/30-autostart.conf"'
print_status 'keybinds module present' 'test -f "$HOME/.config/hypr/modules/80-keybinds.conf"'
print_status 'root config uses source includes' 'grep -Fq "source = ~/.config/hypr/modules/10-monitors.conf" "$HOME/.config/hypr/hyprland.conf"'
print_status 'Sprint 01 include preserved' 'grep -Fq "source = ~/.config/hypr/sprint-01-core.conf" "$HOME/.config/hypr/hyprland.conf"'
print_status 'Sprint 05 include preserved' 'grep -Fq "source = ~/.config/hypr/sprint-05-notifications.conf" "$HOME/.config/hypr/hyprland.conf"'

printf '\nManual checks still required:\n'
printf '1. Reload Hyprland and confirm the config loads cleanly.\n'
