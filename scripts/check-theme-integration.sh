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

printf 'Sprint 18 validation\n'
printf '====================\n'

print_status 'matugen dark palette exists' 'test -f "$HOME/.cache/matugen/colors-dark.json"'
print_status 'Waybar themed CSS exists' 'test -f "$HOME/.config/waybar/style.css"'
print_status 'rofi theme exists' 'test -f "$HOME/.config/rofi/theme.rasi"'
print_status 'mako themed config exists' 'test -f "$HOME/.config/mako/config"'
print_status 'hyprlock themed config exists' 'test -f "$HOME/.config/hypr/hyprlock.conf"'
print_status 'Waybar uses generated CSS colors' "grep -Fq '#80d5d2' \"$HOME/.config/waybar/style.css\" || grep -Fq '#006a68' \"$HOME/.config/waybar/style.css\""
print_status 'rofi uses generated colors' "grep -Fq '#80d5d2' \"$HOME/.config/rofi/theme.rasi\" || grep -Fq '#006a68' \"$HOME/.config/rofi/theme.rasi\""
print_status 'mako uses generated colors' "grep -Fq 'background-color=' \"$HOME/.config/mako/config\""
print_status 'hyprlock uses generated colors' "grep -Fq 'outer_color = rgba(' \"$HOME/.config/hypr/hyprlock.conf\""

printf '\nManual checks still required:\n'
printf '1. Confirm Waybar, rofi, mako, and hyprlock share the generated palette.\n'
printf '2. Confirm no SDDM theming was added yet.\n'
