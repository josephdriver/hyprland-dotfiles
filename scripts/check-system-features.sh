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

printf 'Sprint 15 validation\n'
printf '====================\n'

print_status 'brightnessctl installed' 'pacman -Q brightnessctl'
print_status 'hyprsunset installed' 'pacman -Q hyprsunset'
print_status 'power-profiles-daemon installed' 'pacman -Q power-profiles-daemon'
print_status 'brightnessctl available' 'command -v brightnessctl'
print_status 'hyprsunset available' 'command -v hyprsunset'
print_status 'powerprofilesctl available' 'command -v powerprofilesctl'
print_status 'brightness up bind present' "grep -Fq 'brightnessctl -e4 -n2 set 5%+' \"$HOME/.config/hypr/modules/80-keybinds.conf\""
print_status 'brightness down bind present' "grep -Fq 'brightnessctl -e4 -n2 set 5%-' \"$HOME/.config/hypr/modules/80-keybinds.conf\""
print_status 'night light start script present' 'test -x scripts/start-night-light.sh'
print_status 'night light stop script present' 'test -x scripts/stop-night-light.sh'
print_status 'power profile status script present' 'test -x scripts/current-power-profile.sh'
print_status 'power profile toggle script present' 'test -x scripts/toggle-power-profile.sh'
print_status 'Waybar power profile module configured' "grep -Fq 'custom/powerprofile' \"$HOME/.config/waybar/config.jsonc\""

printf '\nManual checks still required:\n'
printf '1. Run brightnessctl commands or brightness keys and confirm brightness changes.\n'
printf '2. Run start-night-light.sh and stop-night-light.sh and confirm color temperature changes.\n'
printf '3. Run powerprofilesctl set power-saver|balanced|performance and confirm profile changes.\n'
printf '4. Click the Waybar power profile module and confirm it cycles through the three profiles.\n'
