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

printf 'Sprint 19 validation\n'
printf '====================\n'

print_status 'sddm installed' 'pacman -Q sddm'
print_status 'repo SDDM Main.qml present' 'test -f config/sddm/hyprland-setup/Main.qml'
print_status 'repo SDDM metadata present' 'test -f config/sddm/hyprland-setup/metadata.desktop'
print_status 'repo SDDM theme.conf present' 'test -f config/sddm/hyprland-setup/theme.conf'
print_status 'repo SDDM background asset present' 'test -f config/sddm/hyprland-setup/background.jpg'
print_status 'repo SDDM config drop-in present' 'test -f config/sddm/sddm.conf.d/10-hyprland-setup-theme.conf'
print_status 'wallpaper path exists' 'test -f /usr/share/wallpapers/cachyos-wallpapers/CachyOS_Moon.jpg'
print_status 'SDDM verify script present' 'test -x scripts/verify-sddm-theme.sh'

printf '\nManual checks still required:\n'
 printf '1. Copy config/sddm/hyprland-setup to /usr/share/sddm/themes/hyprland-setup.\n'
 printf '2. Copy config/sddm/sddm.conf.d/10-hyprland-setup-theme.conf to /etc/sddm.conf.d/.\n'
 printf '3. Run bash scripts/verify-sddm-theme.sh before copying the theme system-wide.\n'
 printf '4. Restart SDDM or reboot and confirm the greeter matches the desktop theme.\n'
