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
[[ "$EUID" -eq 0 ]] || fail 'Run this script as root so it can enable NetworkManager.service.'

systemctl enable --now NetworkManager.service
info 'Enabled and started NetworkManager.service.'

if systemctl --quiet is-enabled NetworkManager.service; then
  info 'NetworkManager.service is enabled for boot.'
fi

if systemctl --quiet is-active NetworkManager.service; then
  info 'NetworkManager.service is active.'
fi
