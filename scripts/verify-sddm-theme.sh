#!/usr/bin/env bash
set -euo pipefail

theme_path="${1:-/home/joe/hyrpland-setup/config/sddm/hyprland-setup}"
log_file="${XDG_CACHE_HOME:-$HOME/.cache}/sddm-theme-test.log"

test -d "$theme_path" || {
  printf 'ERROR: theme path not found: %s\n' "$theme_path" >&2
  exit 1
}

test -f "$theme_path/background.jpg" || {
  printf 'ERROR: theme background asset missing: %s/background.jpg\n' "$theme_path" >&2
  exit 1
}

timeout 5s sddm-greeter-qt6 --test-mode --theme "$theme_path" >"$log_file" 2>&1 || true

if grep -Eiq 'cannot assign|Error loading theme config|Failed to find|QML|file is not a valid image|failed to create' "$log_file"; then
  printf 'SDDM theme verification failed. Log: %s\n' "$log_file" >&2
  exit 1
fi

printf 'SDDM theme verification passed. Log: %s\n' "$log_file"
