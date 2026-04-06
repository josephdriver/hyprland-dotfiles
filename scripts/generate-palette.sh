#!/usr/bin/env bash
set -euo pipefail

config_file="$HOME/.config/matugen/config.toml"
output_dir="$HOME/.cache/matugen"
wallpaper_file="$HOME/.config/hypr/hyprpaper.conf"

read_wallpaper_path() {
  local pattern="$1"

  grep -E "$pattern" "$wallpaper_file" 2>/dev/null | head -n 1 || true
}

mkdir -p "$output_dir"

if [[ ! -f "$wallpaper_file" ]]; then
  printf 'ERROR: hyprpaper config not found at %s\n' "$wallpaper_file" >&2
  exit 1
fi

wallpaper_line="$(read_wallpaper_path '^\s*path\s*=')"
wallpaper_path="$(printf '%s' "$wallpaper_line" | cut -d '=' -f 2- | tr -d ' ' )"

if [[ -z "$wallpaper_path" ]]; then
  wallpaper_line="$(read_wallpaper_path '^\s*preload\s*=')"
  wallpaper_path="$(printf '%s' "$wallpaper_line" | cut -d '=' -f 2- | sed 's/^ *//' )"
fi

if [[ -z "$wallpaper_path" ]]; then
  wallpaper_line="$(read_wallpaper_path '^\s*wallpaper\s*=')"
  wallpaper_path="$(printf '%s' "$wallpaper_line" | cut -d '=' -f 2- | cut -d ',' -f 2- | sed 's/^ *//' )"
fi

if [[ -z "$wallpaper_path" || ! -f "$wallpaper_path" ]]; then
  printf 'ERROR: wallpaper path could not be resolved from %s\n' "$wallpaper_file" >&2
  exit 1
fi

matugen image "$wallpaper_path" --config "$config_file" -m dark -j hex --source-color-index 0 > "$output_dir/colors-dark.json"
matugen image "$wallpaper_path" --config "$config_file" -m light -j hex --source-color-index 0 > "$output_dir/colors-light.json"

printf 'WALLPAPER=%s\n' "$wallpaper_path" > "$output_dir/source.env"
printf 'Generated palette files in %s\n' "$output_dir"
