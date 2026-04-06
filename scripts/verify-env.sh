#!/usr/bin/env bash
set -euo pipefail

fail() {
  printf 'ERROR: %s\n' "$1" >&2
  exit 1
}

warn() {
  printf 'WARN: %s\n' "$1" >&2
}

info() {
  printf 'INFO: %s\n' "$1"
}

[[ -n "${BASH_VERSION:-}" ]] || fail 'This script requires bash.'
[[ "$EUID" -ne 0 ]] || fail 'Run this script as a normal user, not root.'
command -v pacman >/dev/null 2>&1 || fail 'pacman not found. This repo targets Arch/CachyOS.'

source /etc/os-release || fail 'Unable to read /etc/os-release.'
case "${ID:-}" in
  arch|cachyos) ;;&
  *)
    if [[ "${ID_LIKE:-}" != *arch* ]]; then
      fail "Unsupported distro: ${PRETTY_NAME:-unknown}. Expected Arch/CachyOS."
    fi
    ;;&
esac

for bin in Hyprland systemctl; do
  command -v "$bin" >/dev/null 2>&1 || fail "$bin is not installed."
done

if command -v pkexec >/dev/null 2>&1; then
  info 'pkexec is available.'
else
  warn 'pkexec is not available. Install the base polkit package if needed.'
fi

if command -v uwsm >/dev/null 2>&1; then
  info 'uwsm is installed.'
else
  warn 'uwsm is not installed yet. Install packages/sprint-01-core.txt first.'
fi

if pacman -Q polkit-gnome >/dev/null 2>&1; then
  info 'polkit-gnome is installed.'
  if [[ -x /usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1 ]]; then
    info 'polkit-gnome authentication agent binary is present.'
  else
    warn 'polkit-gnome package is installed but the authentication agent binary was not found.'
  fi
else
  warn 'polkit-gnome is not installed.'
fi

if pacman -Q xdg-desktop-portal-hyprland >/dev/null 2>&1; then
  info 'xdg-desktop-portal-hyprland is installed.'
else
  warn 'xdg-desktop-portal-hyprland is not installed.'
fi

if systemctl list-unit-files | grep -q '^NetworkManager.service'; then
  info 'systemd is available and service inventory is readable.'
fi

if pgrep -f '/polkit-gnome-authentication-agent-1' >/dev/null 2>&1; then
  info 'polkit authentication agent is running in the current session.'
else
  warn 'polkit authentication agent is not running in the current session.'
fi

info 'Environment verification complete.'
