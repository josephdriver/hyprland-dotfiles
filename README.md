# Hyprland Setup

Reproducible Hyprland desktop setup for Arch Linux and CachyOS.

This repo installs a full Hyprland environment with:
- `uwsm` session management
- Waybar, rofi, mako, hyprlock, hypridle, hyprpaper
- NetworkManager, Bluetooth, PipeWire, clipboard, screenshots, recording
- GTK/Qt theming with `matugen`
- optional SDDM theming

## Status
- Core desktop profile: implemented
- One-step installer: implemented
- Optional SDDM theme install: implemented
- VM validation: planned for Arch minimal and CachyOS Hyprland

## Install
Clone the repo and run:

```sh
bash install.sh
```

To also install and enable the bundled SDDM theme:

```sh
bash install.sh --with-sddm-theme
```

The installer:
- verifies Arch/CachyOS
- installs missing packages from official repositories
- backs up existing managed config directories
- installs a single-monitor safe default Hyprland config
- enables required system and user services
- generates and applies the theme

## Bootstrap
`bootstrap.sh` is included for `curl | bash` style installs, but it expects `HYPRLAND_SETUP_REPO_URL` to be set until the final public repo URL is fixed.

Example:

```sh
curl -fsSL <bootstrap-url> | HYPRLAND_SETUP_REPO_URL=<git-url> bash
```

## Package Profiles
- `packages/default.txt` contains the full desktop profile
- `packages/sddm.txt` contains the optional SDDM profile

## Repo Layout
- `config/` static config, templates, and theme assets
- `packages/` install manifests
- `scripts/` runtime helpers, theme scripts, and validation helpers
- `install.sh` main installer
- `bootstrap.sh` remote bootstrap entrypoint

## Notes
- The installer manages config under `~/.local/share/hyprland-setup` and links active config from there.
- Existing managed config directories are backed up under `${XDG_STATE_HOME:-~/.local/state}/hyprland-setup/backups/`.
- SDDM is optional because it changes system-wide login behavior.
- Legacy sprint-oriented development docs are still present in `docs/` while the public repo cleanup is in progress.
