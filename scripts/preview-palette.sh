#!/usr/bin/env bash
set -euo pipefail

palette_file="${1:-$HOME/.cache/matugen/colors-dark.json}"

python - "$palette_file" <<'PY'
import json
import sys
from pathlib import Path

palette_path = Path(sys.argv[1]).expanduser()
if not palette_path.is_file():
    print(f"ERROR: palette file not found: {palette_path}", file=sys.stderr)
    sys.exit(1)

data = json.loads(palette_path.read_text())
mode = data.get("mode", "dark")
colors = data["colors"]

keys = [
    "source_color",
    "primary",
    "secondary",
    "tertiary",
    "background",
    "surface",
    "surface_container",
    "outline",
    "error",
]

def hex_to_rgb(value: str):
    value = value.lstrip("#")
    return tuple(int(value[i:i+2], 16) for i in (0, 2, 4))

print(f"Palette preview: {palette_path}")
print(f"Mode: {mode}")
print()

for key in keys:
    color = colors[key][mode]["color"]
    r, g, b = hex_to_rgb(color)
    swatch = f"\033[48;2;{r};{g};{b}m        \033[0m"
    print(f"{key:20} {color:10} {swatch}")
PY
