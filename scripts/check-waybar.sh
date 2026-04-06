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

printf 'Sprint 09 validation\n'
printf '====================\n'

print_status 'waybar installed' 'pacman -Q waybar'
print_status 'repo Waybar config present' 'test -f config/waybar/config.jsonc'
print_status 'user Waybar config present' 'test -f "$HOME/.config/waybar/config.jsonc"'
print_status 'waybar binary available' 'command -v waybar'
print_status 'Hyprland autostart launches waybar' "grep -Fq 'waybar' \"$HOME/.config/hypr/modules/30-autostart.conf\""
print_status 'Waybar process running' 'pgrep -x waybar'
print_status 'audio click action configured' "grep -Fq '\"on-click\": \"pavucontrol\"' \"$HOME/.config/waybar/config.jsonc\""
print_status 'bluetooth click action configured' "grep -Fq '\"on-click\": \"blueman-manager\"' \"$HOME/.config/waybar/config.jsonc\""
print_status 'network click action configured' "grep -Fq '\"on-click\": \"nm-connection-editor\"' \"$HOME/.config/waybar/config.jsonc\""
print_status 'power click action configured' "grep -Fq '\"on-click\": \"/home/joe/hyrpland-setup/scripts/power-menu.sh\"' \"$HOME/.config/waybar/config.jsonc\""

printf '\nManual checks still required:\n'
printf '1. Confirm the bar renders on screen.\n'
printf '2. Confirm workspace and window title modules update.\n'
printf '3. Confirm audio, bluetooth, network, clock, and power modules appear and clicks work.\n'
