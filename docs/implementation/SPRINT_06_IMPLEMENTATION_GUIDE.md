# Sprint 06 Implementation Guide

## Summary
Sprint 06 is complete. `rofi` is installed and configured in `drun` mode, the active Hyprland config uses it as the launcher, and manual validation confirmed applications launch through `SUPER + D`.

## Files Added
- `docs/implementation/SPRINT_06_IMPLEMENTATION_GUIDE.md`
- `packages/sprint-06-launcher.txt`
- `config/rofi/config.rasi`
- `config/hypr/snippets/sprint-06-launcher.conf.example`
- `scripts/check-launcher.sh`

## Files Updated
- `docs/sprints/SPRINT_06_LAUNCHER.md`
- `README.md`
- `~/.config/hypr/hyprland.conf`

## Decisions
- Keep Sprint 06 limited to `rofi` in `drun` mode only.
- Replace the existing launcher command in the active Hyprland config instead of adding a parallel launcher workflow.
- Use a minimal `rofi` config with no theming or extra modes.

## Validation
1. Install the packages listed in `packages/sprint-06-launcher.txt`.
2. Copy `config/rofi/config.rasi` to `~/.config/rofi/config.rasi`.
3. Reload Hyprland config or start a fresh session.
4. Run `bash scripts/check-launcher.sh`.
5. Press `SUPER + D` and confirm apps launch through `rofi`.

## Deferred Work
- no theming
- no power menu
- no extra rofi modes
- no install automation
