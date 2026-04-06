# Sprint 03 Implementation Guide

## Summary
Sprint 03 is complete. Bluetooth support is in place with `bluez` and `blueman`, `bluetooth.service` is enabled and active, and manual checks confirmed Blueman launches and device pairing works.

## Files Added
- `docs/implementation/SPRINT_03_IMPLEMENTATION_GUIDE.md`
- `packages/sprint-03-bluetooth.txt`
- `scripts/enable-bluetooth.sh`
- `scripts/check-bluetooth.sh`

## Files Updated
- `docs/sprints/SPRINT_03_BLUETOOTH.md`
- `README.md`

## Decisions
- Keep Sprint 03 limited to the Bluetooth service and Blueman UI validation.
- Use a dedicated Bluetooth enable script instead of mixing Bluetooth into earlier sprint scripts.
- Validate package presence, service state, controller availability, and Blueman command availability, leaving pairing as a manual acceptance check.

## Validation
1. Install the packages listed in `packages/sprint-03-bluetooth.txt`.
2. Run `sudo bash scripts/enable-bluetooth.sh`.
3. Run `bash scripts/check-bluetooth.sh`.
4. Launch `blueman-manager` from a terminal.
5. Scan for a Bluetooth device and confirm pairing works.

## Deferred Work
- no bar integration
- no theming or icon work
- no audio device workflow
- no install automation
