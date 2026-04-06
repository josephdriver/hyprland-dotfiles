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
[[ "$EUID" -eq 0 ]] || fail 'Run this script as root so it can enable bluetooth.service.'

systemctl enable --now bluetooth.service
info 'Enabled and started bluetooth.service.'

if systemctl --quiet is-enabled bluetooth.service; then
  info 'bluetooth.service is enabled for boot.'
fi

if systemctl --quiet is-active bluetooth.service; then
  info 'bluetooth.service is active.'
fi
