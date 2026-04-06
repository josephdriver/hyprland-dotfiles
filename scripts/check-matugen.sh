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

printf 'Sprint 17 validation\n'
printf '====================\n'

print_status 'matugen installed' 'pacman -Q matugen'
print_status 'repo matugen config present' 'test -f config/matugen/config.toml'
print_status 'user matugen config present' 'test -f "$HOME/.config/matugen/config.toml"'
print_status 'generate palette script present' 'test -x scripts/generate-palette.sh'
print_status 'preview palette script present' 'test -x scripts/preview-palette.sh'
print_status 'matugen available' 'command -v matugen'
print_status 'dark palette generated' 'test -f "$HOME/.cache/matugen/colors-dark.json"'
print_status 'light palette generated' 'test -f "$HOME/.cache/matugen/colors-light.json"'
print_status 'source wallpaper recorded' 'test -f "$HOME/.cache/matugen/source.env"'

printf '\nManual checks still required:\n'
 printf '1. Inspect generated JSON palette files in ~/.cache/matugen.\n'
 printf '2. Confirm colors were generated from the current wallpaper.\n'
 printf '3. Run scripts/preview-palette.sh and confirm swatches render in the terminal.\n'
 printf '4. Confirm no app configs were integrated yet.\n'
