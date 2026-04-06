#!/usr/bin/env bash
set -euo pipefail

palette_file="${1:-$HOME/.cache/matugen/colors-dark.json}"
repo_root="/home/joe/hyrpland-setup"
wallpaper_env="${XDG_CACHE_HOME:-$HOME/.cache}/matugen/source.env"

python - "$palette_file" "$repo_root" "$wallpaper_env" <<'PY'
import json
import sys
from pathlib import Path

palette_path = Path(sys.argv[1]).expanduser()
repo_root = Path(sys.argv[2])
wallpaper_env = Path(sys.argv[3]).expanduser()

if not palette_path.is_file():
    print(f"ERROR: palette file not found: {palette_path}", file=sys.stderr)
    sys.exit(1)

wallpaper_path = "/usr/share/wallpapers/cachyos-wallpapers/CachyOS_Moon.jpg"
if wallpaper_env.is_file():
    for line in wallpaper_env.read_text().splitlines():
        if line.startswith("WALLPAPER="):
            wallpaper_path = line.split("=", 1)[1]
            break

data = json.loads(palette_path.read_text())
mode = data.get("mode", "dark")
colors = data["colors"]

def get(name):
    return colors[name][mode]["color"]

def rgba_no_hash(name):
    return get(name).lstrip("#") + "ff"

def rgba_alpha(name, alpha):
    return get(name).lstrip("#") + alpha

def argb_alpha(name, alpha):
    return alpha + get(name).lstrip("#")

tokens = {
    "primary": get("primary"),
    "on_primary": get("on_primary"),
    "primary_container": get("primary_container"),
    "on_primary_container": get("on_primary_container"),
    "background": get("background"),
    "surface": get("surface"),
    "surface_container": get("surface_container"),
    "surface_container_high": get("surface_container_high"),
    "on_surface": get("on_surface"),
    "outline": get("outline"),
    "error": get("error"),
    "wallpaper_path": wallpaper_path,
    "overlay_rgba": rgba_alpha("background", "cc"),
    "panel_rgba": rgba_alpha("surface_container", "d9"),
    "field_rgba": rgba_alpha("background", "f0"),
    "overlay_argb": argb_alpha("background", "cc"),
    "panel_argb": argb_alpha("surface_container_high", "ff"),
    "field_argb": argb_alpha("background", "f0"),
    "background_rgba": rgba_no_hash("background"),
    "outline_rgba": rgba_no_hash("outline"),
    "surface_container_rgba": rgba_no_hash("surface_container"),
    "surface_container_high_rgba": rgba_no_hash("surface_container_high"),
    "on_surface_rgba": rgba_no_hash("on_surface"),
    "primary_rgba": rgba_no_hash("primary"),
    "error_rgba": rgba_no_hash("error"),
}

targets = [
    (repo_root / "config/theme/waybar/style.css.template", Path.home() / ".config/waybar/style.css"),
    (repo_root / "config/theme/rofi/theme.rasi.template", Path.home() / ".config/rofi/theme.rasi"),
    (repo_root / "config/theme/mako/config.template", Path.home() / ".config/mako/config"),
    (repo_root / "config/theme/hyprlock/hyprlock.conf.template", Path.home() / ".config/hypr/hyprlock.conf"),
    (repo_root / "config/theme/sddm/theme.conf.template", repo_root / "config/sddm/hyprland-setup/theme.conf"),
]

for template_path, output_path in targets:
    content = template_path.read_text()
    for key, value in tokens.items():
        content = content.replace("{{" + key + "}}", value)
    output_path.parent.mkdir(parents=True, exist_ok=True)
    output_path.write_text(content)
    print(f"Wrote {output_path}")

(repo_root / "config/sddm/hyprland-setup").mkdir(parents=True, exist_ok=True)
target_wallpaper = repo_root / "config/sddm/hyprland-setup/background.jpg"
target_wallpaper.write_bytes(Path(wallpaper_path).read_bytes())
print(f"Copied {wallpaper_path} -> {target_wallpaper}")
PY

pkill waybar 2>/dev/null || true
nohup waybar >/tmp/waybar.log 2>&1 &
pkill mako 2>/dev/null || true
nohup mako >/tmp/mako.log 2>&1 &
