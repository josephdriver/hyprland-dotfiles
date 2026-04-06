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

printf 'Sprint 02 validation\n'
printf '====================\n'

print_status 'networkmanager installed' 'pacman -Q networkmanager'
print_status 'nm-connection-editor installed' 'pacman -Q nm-connection-editor'
print_status 'NetworkManager enabled on boot' 'systemctl is-enabled NetworkManager.service'
print_status 'NetworkManager active' 'systemctl is-active NetworkManager.service'
print_status 'nm-connection-editor available' 'command -v nm-connection-editor'

printf '\nManual checks still required:\n'
printf '1. Launch nm-connection-editor from a terminal and confirm the GUI opens.\n'
printf '2. Join a WiFi network and confirm it reconnects automatically after reboot.\n'
