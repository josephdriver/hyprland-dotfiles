# Sprint 15 Implementation Guide

## Summary
Sprint 15 is complete. Brightness control, night light, and power profile management are working through CLI-focused tools, and a minimal Waybar power-profile toggle was added as the documented implementation exception requested during this sprint.

## Files Added
- `docs/implementation/SPRINT_15_IMPLEMENTATION_GUIDE.md`
- `packages/sprint-15-system-features.txt`
- `scripts/start-night-light.sh`
- `scripts/stop-night-light.sh`
- `scripts/check-system-features.sh`
- `scripts/current-power-profile.sh`
- `scripts/toggle-power-profile.sh`

## Files Updated
- `docs/sprints/SPRINT_15_SYSTEM_FEATURES.md`
- `README.md`
- `config/hypr/modules/80-keybinds.conf.example`
- `~/.config/hypr/modules/80-keybinds.conf`
- `config/waybar/config.jsonc`
- `~/.config/waybar/config.jsonc`

## Decisions
- Keep Sprint 15 limited to CLI-accessible system features only.
- Reuse `brightnessctl` media-key-style binds already present in Hyprland instead of adding a separate brightness script.
- Use small helper scripts for `hyprsunset` start and stop so night light remains easy to test from the command line.
- Add a small Waybar power profile module as a user-requested exception so profiles can be cycled directly from the bar.

## Validation
1. Install the packages listed in `packages/sprint-15-system-features.txt`.
2. Reload Hyprland or start a fresh session.
3. Run `bash scripts/check-system-features.sh`.
4. Test brightness controls, start and stop night light, and switch power profiles with CLI commands.
5. Click the Waybar power-profile module and confirm it cycles through `power-saver`, `balanced`, and `performance`.

## Deferred Work
- no schedule automation
- no install automation
