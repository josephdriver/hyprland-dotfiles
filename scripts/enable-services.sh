#!/usr/bin/env bash
set -euo pipefail

# Sprint 01 intentionally enables only portal-related user services.
# System services like NetworkManager are handled in later sprints.

info() {
  printf 'INFO: %s\n' "$1"
}

if systemctl --user --quiet is-enabled xdg-desktop-portal.service 2>/dev/null; then
  info 'xdg-desktop-portal.service is already enabled for the user.'
else
  systemctl --user enable xdg-desktop-portal.service
  info 'Enabled xdg-desktop-portal.service for the user.'
fi

# Start/restart immediately for validation in the current session.
systemctl --user restart xdg-desktop-portal.service || true

if systemctl --user list-unit-files | grep -q '^xdg-desktop-portal-hyprland.service'; then
  systemctl --user restart xdg-desktop-portal-hyprland.service || true
  info 'Restarted xdg-desktop-portal-hyprland.service.'
fi
