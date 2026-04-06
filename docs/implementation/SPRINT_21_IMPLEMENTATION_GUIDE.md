# Sprint 21 Implementation Guide

## Summary
Sprint 21 is in progress. The repo now has a first-pass public installer flow with a full package manifest, a user-facing `install.sh`, a `bootstrap.sh` entrypoint for future `curl | bash` use, portable config templates, timestamped config backups, and optional SDDM theme installation.

## Files Added
- `docs/implementation/SPRINT_21_IMPLEMENTATION_GUIDE.md`
- `packages/default.txt`
- `packages/sddm.txt`
- `config/waybar/config.jsonc.template`
- `bootstrap.sh`
- `install.sh`

## Files Updated
- `docs/sprints/SPRINT_21_INSTALL_SCRIPT.md`
- `README.md`
- `config/hypr/modules/10-monitors.conf.example`
- `config/hypr/modules/30-autostart.conf.example`
- `config/hypr/modules/60-look-and-feel.conf.example`
- `config/hypr/modules/70-input.conf.example`
- `config/hypr/modules/80-keybinds.conf.example`
- `config/hypr/hyprpaper.conf`
- `config/hypr/snippets/sprint-07-power-menu.conf.example`
- `config/hypr/snippets/sprint-12-clipboard.conf.example`
- `config/waybar/config.jsonc`
- `scripts/generate-palette.sh`
- `scripts/apply-generated-theme.sh`
- `scripts/verify-sddm-theme.sh`
- `scripts/check-waybar.sh`
- `scripts/check-power-menu.sh`
- `scripts/check-screenshot-recording.sh`
- `scripts/check-clipboard.sh`

## Decisions
- Archive sprint-era development docs instead of deleting them outright.
- Support a `curl | bash` bootstrap entrypoint for end users.
- Install a full desktop profile by default.
- Generate a safe single-monitor default config during install.
- Make SDDM theming optional instead of mandatory.
- Manage installed repo content from `~/.local/share/hyrpland-setup` and link active user config from there.
- Keep theme rendering in the existing helper scripts, but remove hardcoded local repo paths so the same scripts work after installation.

## Validation
1. Ran `bash -n install.sh`.
2. Ran `bash -n bootstrap.sh`.
3. Ran `bash -n scripts/apply-generated-theme.sh`.
4. Ran `bash -n scripts/generate-palette.sh`.
5. Ran `bash -n scripts/verify-sddm-theme.sh`.
6. Ran `bash -n scripts/check-waybar.sh`.
7. Ran `bash -n scripts/check-power-menu.sh`.
8. Ran `bash -n scripts/check-screenshot-recording.sh`.
9. Ran `bash -n scripts/check-clipboard.sh`.
10. Searched the repo for remaining `/home/joe/hyrpland-setup`, `DP-2`, `firefox`, and `epic-mouse-v1` references in active install assets.

## Deferred Work
- Move sprint-oriented docs into an archive path so the main repo surface is fully public-facing.
- Final VM validation matrix execution on Arch minimal and CachyOS Hyprland.
- Tighten bootstrap UX once the public repo URL is finalized.
- Add a dry-run or explicit noninteractive mode if needed after VM testing.
