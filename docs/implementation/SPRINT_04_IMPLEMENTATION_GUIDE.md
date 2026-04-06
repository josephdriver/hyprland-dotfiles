# Sprint 04 Implementation Guide

## Summary
Sprint 04 is complete. PipeWire audio, WirePlumber session management, and `pavucontrol` GUI access are in place, the required user services are enabled and active, and manual checks confirmed playback, volume control, and device switching work correctly.

## Files Added
- `docs/implementation/SPRINT_04_IMPLEMENTATION_GUIDE.md`
- `packages/sprint-04-audio.txt`
- `scripts/enable-audio.sh`
- `scripts/check-audio.sh`

## Files Updated
- `docs/sprints/SPRINT_04_AUDIO.md`
- `README.md`

## Decisions
- Keep Sprint 04 limited to PipeWire, WirePlumber, and `pavucontrol`.
- Use a dedicated audio enable script instead of changing earlier sprint scripts.
- Validate package presence, user service state, default sink availability, and `pavucontrol` command availability, leaving playback and device switching as manual acceptance checks.

## Validation
1. Install the packages listed in `packages/sprint-04-audio.txt`.
2. Run `bash scripts/enable-audio.sh`.
3. Run `bash scripts/check-audio.sh`.
4. Launch `pavucontrol` from a terminal.
5. Confirm audio playback works, volume changes apply, and devices switch correctly.

## Deferred Work
- no keybinds
- no bar integration
- no theming or icon work
- no install automation
