# Sprint 12 Implementation Guide

## Summary
Sprint 12 is complete. Clipboard history is now tracked with `cliphist`, stored through `wl-paste` watchers launched from the Hyprland autostart module, and exposed through a `rofi` menu on `SUPER + X`.

## Files Added
- `docs/implementation/SPRINT_12_IMPLEMENTATION_GUIDE.md`
- `packages/sprint-12-clipboard.txt`
- `scripts/clipboard-menu.sh`
- `scripts/check-clipboard.sh`
- `config/hypr/snippets/sprint-12-clipboard.conf.example`

## Files Updated
- `docs/sprints/SPRINT_12_CLIPBOARD.md`
- `README.md`
- `config/hypr/modules/30-autostart.conf.example`
- `~/.config/hypr/modules/30-autostart.conf`
- `config/hypr/modules/80-keybinds.conf.example`
- `~/.config/hypr/modules/80-keybinds.conf`

## Decisions
- Keep Sprint 12 limited to text clipboard history with `cliphist`, `wl-clipboard`, and `rofi`.
- Start clipboard watchers from the existing Hyprland autostart module instead of introducing a separate user service in this sprint.
- Use a small script to pipe `cliphist` output into `rofi` and decode the selected item back to the clipboard.

## Validation
1. Install the packages listed in `packages/sprint-12-clipboard.txt`.
2. Reload Hyprland or start a fresh session.
3. Run `bash scripts/check-clipboard.sh`.
4. Copy some text into the clipboard.
5. Press `SUPER + X` and confirm clipboard history opens and restores an entry.

## Deferred Work
- no image clipboard workflow
- no Waybar integration
- no extra clipboard actions
- no install automation
