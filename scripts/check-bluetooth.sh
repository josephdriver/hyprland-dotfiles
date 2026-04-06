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

printf 'Sprint 03 validation\n'
printf '====================\n'

print_status 'bluez installed' 'pacman -Q bluez'
print_status 'bluez-utils installed' 'pacman -Q bluez-utils'
print_status 'blueman installed' 'pacman -Q blueman'
print_status 'bluetooth service enabled on boot' 'systemctl is-enabled bluetooth.service'
print_status 'bluetooth service active' 'systemctl is-active bluetooth.service'
print_status 'bluetoothctl available' 'command -v bluetoothctl'
print_status 'blueman-manager available' 'command -v blueman-manager'
print_status 'bluetooth controller detected' 'bluetoothctl list | grep -q Controller'

printf '\nManual checks still required:\n'
printf '1. Launch blueman-manager from a terminal and confirm the UI opens.\n'
printf '2. Scan for a Bluetooth device and confirm pairing works.\n'
