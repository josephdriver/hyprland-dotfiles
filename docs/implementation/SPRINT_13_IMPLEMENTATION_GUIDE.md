# Sprint 13 Implementation Guide

## Summary
Sprint 13 is complete. Region screenshots and recordings now work through `grim`, `slurp`, and `wf-recorder` with keyboard-driven binds, and output is saved into the user's screenshots and recordings directories without adding a UI.

## Files Added
- `docs/implementation/SPRINT_13_IMPLEMENTATION_GUIDE.md`
- `packages/sprint-13-screenshot.txt`
- `scripts/take-screenshot.sh`
- `scripts/toggle-recording.sh`
- `scripts/check-screenshot-recording.sh`

## Files Updated
- `docs/sprints/SPRINT_13_SCREENSHOT.md`
- `README.md`
- `config/hypr/modules/80-keybinds.conf.example`
- `~/.config/hypr/modules/80-keybinds.conf`

## Decisions
- Keep Sprint 13 limited to direct keybind-driven screenshot and recording commands.
- Use `grim`, `slurp`, and `wf-recorder` only, with output saved to the standard user pictures and videos directories.
- Use a toggle script for recording so the same bind can start and stop capture without a UI.

## Validation
1. Install the packages listed in `packages/sprint-13-screenshot.txt`.
2. Reload Hyprland or start a fresh session.
3. Run `bash scripts/check-screenshot-recording.sh`.
4. Trigger `SUPER + ALT + S` and confirm an image is saved.
5. Trigger `SUPER + ALT + R` twice and confirm a video is saved.

## Deferred Work
- no screenshot UI
- no annotation tools
- no status indicator
- Dolphin may continue prompting for an app to open image and video files even after remembering the selection; MIME defaults were updated, but this behavior is still noted for later cleanup.
- no install automation
