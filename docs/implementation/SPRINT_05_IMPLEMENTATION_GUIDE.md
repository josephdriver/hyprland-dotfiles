# Sprint 05 Implementation Guide

## Summary
Sprint 05 is complete. Desktop notifications are provided with `mako`, the minimal config and Hyprland autostart snippet are in place, and validation confirmed the daemon runs cleanly and notifications appear in session.

## Files Added
- `docs/implementation/SPRINT_05_IMPLEMENTATION_GUIDE.md`
- `packages/sprint-05-notifications.txt`
- `config/mako/config`
- `config/hypr/snippets/sprint-05-notifications.conf.example`
- `scripts/check-notifications.sh`

## Files Updated
- `docs/sprints/SPRINT_05_NOTIFICATIONS.md`
- `README.md`

## Decisions
- Keep Sprint 05 limited to `mako` installation, a minimal config, and Hyprland autostart.
- Use a config file and Hyprland snippet instead of introducing any styling or extra notification tooling.
- Validate package presence, config presence, process availability, and log health, leaving visible notification delivery as a manual acceptance check.

## Validation
1. Install the packages listed in `packages/sprint-05-notifications.txt`.
2. Copy `config/mako/config` to `~/.config/mako/config`.
3. Merge `config/hypr/snippets/sprint-05-notifications.conf.example` into the active Hyprland autostart config if needed.
4. Start a fresh Hyprland session or launch `mako` manually.
5. Run `bash scripts/check-notifications.sh`.
6. Send a test notification and confirm it appears.

## Deferred Work
- no styling
- no bar integration
- no action scripting
- no install automation
