#!/usr/bin/env bash
set -euo pipefail

repo_url="${HYPRLAND_SETUP_REPO_URL:-}"
branch="${HYPRLAND_SETUP_BRANCH:-main}"
tmp_dir="$(mktemp -d)"

cleanup() {
  rm -rf "$tmp_dir"
}

trap cleanup EXIT

if [[ -z "$repo_url" ]]; then
  printf 'ERROR: HYPRLAND_SETUP_REPO_URL is not set.\n' >&2
  printf 'Set HYPRLAND_SETUP_REPO_URL to the public git URL, or clone the repo and run install.sh directly.\n' >&2
  exit 1
fi

if command -v git >/dev/null 2>&1; then
  git clone --depth 1 --branch "$branch" "$repo_url" "$tmp_dir/repo"
else
  printf 'ERROR: git is required for bootstrap installation.\n' >&2
  exit 1
fi

exec "$tmp_dir/repo/install.sh" "$@"
