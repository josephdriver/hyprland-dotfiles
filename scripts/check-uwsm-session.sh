#!/usr/bin/env bash
set -euo pipefail

printf 'XDG_CURRENT_DESKTOP=%s\n' "${XDG_CURRENT_DESKTOP:-unset}"
printf 'XDG_SESSION_TYPE=%s\n' "${XDG_SESSION_TYPE:-unset}"
printf 'HYPRLAND_INSTANCE_SIGNATURE=%s\n' "${HYPRLAND_INSTANCE_SIGNATURE:-unset}"

if command -v uwsm >/dev/null 2>&1; then
  printf 'uwsm path=%s\n' "$(command -v uwsm)"
fi

if systemctl --user --quiet is-active xdg-desktop-portal.service; then
  printf 'portal service=active\n'
else
  printf 'portal service=inactive\n'
fi
