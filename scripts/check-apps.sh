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

printf 'Sprint 14 validation\n'
printf '====================\n'

print_status 'foot installed' 'pacman -Q foot'
print_status 'thunar installed' 'pacman -Q thunar'
print_status 'foot available' 'command -v foot'
print_status 'thunar available' 'command -v thunar'
print_status 'terminal default set to foot' "grep -Fq '\$terminal = foot' \"$HOME/.config/hypr/modules/20-programs.conf\""
print_status 'file manager default set to thunar' "grep -Fq '\$fileManager = thunar' \"$HOME/.config/hypr/modules/20-programs.conf\""

printf '\nManual checks still required:\n'
printf '1. Launch foot from rofi and confirm it opens.\n'
printf '2. Launch thunar from rofi and confirm it opens.\n'
printf '3. Confirm existing terminal and file manager keybinds use foot and thunar.\n'
