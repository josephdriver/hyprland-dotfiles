#!/usr/bin/env bash
set -euo pipefail

info() {
  printf 'INFO: %s\n' "$1"
}

fail() {
  printf 'ERROR: %s\n' "$1" >&2
  exit 1
}

command -v systemctl >/dev/null 2>&1 || fail 'systemctl not found.'
[[ "$EUID" -ne 0 ]] || fail 'Run this script as a normal user so it can manage user audio services.'

systemctl --user enable --now pipewire.service pipewire-pulse.service wireplumber.service
info 'Enabled and started PipeWire, PipeWire Pulse, and WirePlumber user services.'

for service in pipewire.service pipewire-pulse.service wireplumber.service; do
  if systemctl --user --quiet is-enabled "$service"; then
    info "$service is enabled for the user."
  fi

  if systemctl --user --quiet is-active "$service"; then
    info "$service is active."
  fi
done
