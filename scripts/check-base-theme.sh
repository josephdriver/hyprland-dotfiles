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

printf 'Sprint 16 validation\n'
printf '====================\n'

print_status 'nwg-look installed' 'pacman -Q nwg-look'
print_status 'qt6ct installed' 'pacman -Q qt6ct'
print_status 'kvantum installed' 'pacman -Q kvantum'
print_status 'papirus installed' 'pacman -Q papirus-icon-theme'
print_status 'GTK3 settings present' 'test -f "$HOME/.config/gtk-3.0/settings.ini"'
print_status 'GTK4 settings present' 'test -f "$HOME/.config/gtk-4.0/settings.ini"'
print_status 'qt6ct config present' 'test -f "$HOME/.config/qt6ct/qt6ct.conf"'
print_status 'Kvantum config present' 'test -f "$HOME/.config/Kvantum/kvantum.kvconfig"'
print_status 'qt6ct environment set' "grep -Fq 'QT_QPA_PLATFORMTHEME,qt6ct' \"$HOME/.config/hypr/modules/40-environment.conf\""
print_status 'qt style environment set' "grep -Fq 'QT_STYLE_OVERRIDE,kvantum' \"$HOME/.config/hypr/modules/40-environment.conf\""

printf '\nManual checks still required:\n'
printf '1. Open GTK apps and confirm Adwaita + Papirus + Noto Sans are applied.\n'
printf '2. Open Qt apps and confirm qt6ct/Kvantum settings are applied.\n'
printf '3. Confirm the theme baseline is static and not using dynamic colors.\n'
