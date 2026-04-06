# Sprint 07 Implementation Guide

## Summary
Sprint 07 is complete. A simple rofi-based power menu script is in place, `SUPER + M` opens it from the active Hyprland config, and manual validation confirmed the available actions work.

## Files Added
- `docs/implementation/SPRINT_07_IMPLEMENTATION_GUIDE.md`
- `packages/sprint-07-power-menu.txt`
- `scripts/power-menu.sh`
- `scripts/check-power-menu.sh`
- `config/hypr/snippets/sprint-07-power-menu.conf.example`

## Files Updated
- `docs/sprints/SPRINT_07_POWER_MENU.md`
- `README.md`
- `~/.config/hypr/hyprland.conf`
- `scripts/power-menu.sh`

## Decisions
- Keep Sprint 07 limited to a simple bash script launched through `rofi -dmenu`.
- Reuse the existing `rofi` package from Sprint 06 instead of introducing another menu tool.
- Replace the current `SUPER + M` action with the power menu, since this sprint explicitly introduces the power UI.
- Prefer `hyprlock` directly for the Lock action when available, with `loginctl` only as a fallback, so locking is reliable in the current Hyprland session.

## Validation
1. Ensure the packages listed in `packages/sprint-07-power-menu.txt` are installed.
2. Run `bash scripts/check-power-menu.sh`.
3. Press `SUPER + M` and confirm the menu opens.
4. Test each power action and confirm it triggers the intended command.

## Deferred Work
- no styling
- no confirmation dialog
- no bar integration
- no install automation
