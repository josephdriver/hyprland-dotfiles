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

portal_logs_clean() {
  local logs
  local since

  since="$(systemctl --user show -p ActiveEnterTimestamp --value xdg-desktop-portal.service 2>/dev/null || true)"
  if [[ -z "$since" ]]; then
    since='5 minutes ago'
  fi

  logs="$(journalctl --user -u xdg-desktop-portal.service -u xdg-desktop-portal-hyprland.service --since "$since" --no-pager 2>/dev/null || true)"

  if [[ -z "$logs" ]]; then
    return 0
  fi

  if printf '%s\n' "$logs" | grep -Eiq '\b(error|failed|segfault|traceback)\b'; then
    return 1
  fi

  return 0
}

printf 'Sprint 01 validation\n'
printf '====================\n'

print_status 'polkit-gnome installed' 'pacman -Q polkit-gnome'
print_status 'polkit agent binary present' 'test -x /usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1'
print_status 'polkit agent running' "pgrep -f '/polkit-gnome-authentication-agent-1'"
print_status 'portal backend installed' 'pacman -Q xdg-desktop-portal-hyprland'
print_status 'uwsm installed' 'command -v uwsm'
print_status 'user portal service active' 'systemctl --user is-active xdg-desktop-portal.service'
print_status 'user portal backend active' 'systemctl --user is-active xdg-desktop-portal-hyprland.service'
print_status 'portal logs clean today' 'portal_logs_clean'
print_status 'Hyprland binary present' 'command -v Hyprland'

printf '\nManual checks still required:\n'
printf '1. Run pkexec env and confirm a GUI auth dialog appears.\n'
printf '2. Open a portal-aware app and confirm file picker behavior.\n'
printf '3. Test screen sharing in a browser or app that uses portals.\n'
