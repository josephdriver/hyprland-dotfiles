# Sprint 14 Implementation Guide

## Summary
Sprint 14 is complete. `foot` and `thunar` are installed and working, Hyprland defaults now point to them for terminal and file manager actions, and validation confirmed they launch through rofi and existing keybinds. Cleanup of the previous `kitty` and `dolphin` packages is intentionally left optional so working systems are not disrupted unnecessarily.

## Files Added
- `docs/implementation/SPRINT_14_IMPLEMENTATION_GUIDE.md`
- `packages/sprint-14-apps.txt`
- `scripts/check-apps.sh`

## Files Updated
- `docs/sprints/SPRINT_14_APPS.md`
- `README.md`
- `config/hypr/modules/20-programs.conf.example`
- `~/.config/hypr/modules/20-programs.conf`

## Decisions
- Keep Sprint 14 limited to `foot` and `thunar` only.
- Update Hyprland program variables so existing launcher and keybind flows use the new defaults automatically.
- Leave MIME integration and any additional app selection outside this sprint.

## Validation
1. Install the packages listed in `packages/sprint-14-apps.txt`.
2. Reload Hyprland or start a fresh session.
3. Run `bash scripts/check-apps.sh`.
4. Launch both apps via `rofi` and confirm they start.
5. Confirm terminal and file manager keybinds use the new defaults.

## Deferred Work
- no theming
- no MIME cleanup
- no extra desktop apps
- optional removal of legacy `kitty` and `dolphin` packages after confirming the new workflow is stable
- Thunar terminal-helper integration may still need cleanup for future terminal-based file handlers beyond the custom markdown launcher workaround
- no install automation
