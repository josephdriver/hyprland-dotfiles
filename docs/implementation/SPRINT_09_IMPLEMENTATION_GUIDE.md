# Sprint 09 Implementation Guide

## Summary
Sprint 09 is complete. Waybar now provides the core bar functionality with built-in modules for workspaces, active window, audio, Bluetooth, network, clock, and power actions, while staying unthemed. During validation, the active Hyprland monitor config was also corrected to disable `DP-3` and keep `DP-2` at `3840x2160@240` so workspace switching behaves correctly on the main display.

## Files Added
- `docs/implementation/SPRINT_09_IMPLEMENTATION_GUIDE.md`
- `config/waybar/config.jsonc`
- `scripts/check-waybar.sh`

## Files Updated
- `docs/sprints/SPRINT_09_WAYBAR.md`
- `README.md`
- `config/hypr/modules/10-monitors.conf.example`
- `~/.config/hypr/modules/10-monitors.conf`

## Decisions
- Keep Sprint 09 limited to built-in Waybar modules only.
- Reuse the existing Hyprland autostart entry that already launches `waybar`.
- Avoid adding CSS in this sprint so the bar remains functional and unthemed.
- Keep the status bar functional-first by wiring click actions to existing Sprint 04, Sprint 03, Sprint 02, and Sprint 07 tools rather than adding new helper scripts.

## Validation
1. Ensure `waybar` is installed.
2. Copy `config/waybar/config.jsonc` to `~/.config/waybar/config.jsonc`.
3. Start a fresh Hyprland session or restart Waybar.
4. Run `bash scripts/check-waybar.sh`.
5. Confirm the bar renders and workspace/window modules update.
6. Confirm audio, Bluetooth, network, clock, and power modules appear and their click actions work.

## Deferred Work
- no styling
- no custom scripts
- no extra modules beyond current sprint scope
- no install automation
