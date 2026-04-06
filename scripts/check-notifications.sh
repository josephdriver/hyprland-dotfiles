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

notification_logs_clean() {
  local logs
  logs="$(journalctl --user -u mako.service --since '10 minutes ago' --no-pager 2>/dev/null || true)"

  if [[ -z "$logs" ]]; then
    return 0
  fi

  if printf '%s\n' "$logs" | grep -Eiq '\b(error|failed|segfault|traceback)\b'; then
    return 1
  fi

  return 0
}

printf 'Sprint 05 validation\n'
printf '====================\n'

print_status 'mako installed' 'pacman -Q mako'
print_status 'libnotify installed' 'pacman -Q libnotify'
print_status 'mako config present in repo' 'test -f config/mako/config'
print_status 'Hyprland notifications snippet present' 'test -f config/hypr/snippets/sprint-05-notifications.conf.example'
print_status 'mako binary available' 'command -v mako'
print_status 'notify-send available' 'command -v notify-send'
print_status 'mako running' 'pgrep -x mako'
print_status 'mako logs clean' 'notification_logs_clean'

printf '\nManual checks still required:\n'
printf '1. Send a test notification and confirm it appears.\n'
printf '2. Confirm there are no visible notification errors in the session.\n'
