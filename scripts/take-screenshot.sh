#!/usr/bin/env bash
set -euo pipefail

dir="${XDG_PICTURES_DIR:-$HOME/Pictures}/Screenshots"
mkdir -p "$dir"

file="$dir/screenshot-$(date +%Y%m%d-%H%M%S).png"
grim -g "$(slurp)" - | tee "$file" | wl-copy
