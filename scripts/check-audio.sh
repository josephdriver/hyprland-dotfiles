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

printf 'Sprint 04 validation\n'
printf '====================\n'

print_status 'pipewire installed' 'pacman -Q pipewire'
print_status 'wireplumber installed' 'pacman -Q wireplumber'
print_status 'pavucontrol installed' 'pacman -Q pavucontrol'
print_status 'pipewire-pulse installed' 'pacman -Q pipewire-pulse'
print_status 'pipewire service active' 'systemctl --user is-active pipewire.service'
print_status 'pipewire-pulse service active' 'systemctl --user is-active pipewire-pulse.service'
print_status 'wireplumber service active' 'systemctl --user is-active wireplumber.service'
print_status 'wpctl available' 'command -v wpctl'
print_status 'pavucontrol available' 'command -v pavucontrol'
print_status 'default audio sink available' 'wpctl status | grep -q "Sinks:"'

printf '\nManual checks still required:\n'
printf '1. Launch pavucontrol from a terminal and confirm the UI opens.\n'
printf '2. Play audio and confirm output works.\n'
printf '3. Change volume and switch devices to confirm both work.\n'
