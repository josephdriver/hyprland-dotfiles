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

printf 'Sprint 06 validation\n'
printf '====================\n'

print_status 'rofi installed' 'pacman -Q rofi'
print_status 'rofi config present in repo' 'test -f config/rofi/config.rasi'
print_status 'rofi config present in user config' 'test -f "$HOME/.config/rofi/config.rasi"'
print_status 'rofi binary available' 'command -v rofi'
print_status 'launcher set to rofi in Hyprland config' "grep -Fq '\$menu = rofi -show drun' \"$HOME/.config/hypr/hyprland.conf\""
print_status 'SUPER+D binding present' "grep -Fq 'bind = \$mainMod, D, exec, \$menu' \"$HOME/.config/hypr/hyprland.conf\""

printf '\nManual checks still required:\n'
printf '1. Press SUPER + D and confirm rofi opens in drun mode.\n'
printf '2. Launch an application from rofi and confirm it starts.\n'
