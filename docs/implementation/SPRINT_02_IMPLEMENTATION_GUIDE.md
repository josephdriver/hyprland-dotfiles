# Sprint 02 Implementation Guide

## Summary
Sprint 02 is complete. NetworkManager backend setup and `nm-connection-editor` validation are in place, with `NetworkManager.service` enabled for boot and active in the current system, and manual checks confirming the editor launches and WiFi reconnects across reboot.

## Files Added
- `docs/implementation/SPRINT_02_IMPLEMENTATION_GUIDE.md`
- `packages/sprint-02-network.txt`
- `scripts/enable-networkmanager.sh`
- `scripts/check-networkmanager.sh`

## Files Updated
- `docs/sprints/SPRINT_02_NETWORK.md`
- `README.md`

## Decisions
- Keep Sprint 02 limited to NetworkManager backend setup and GUI editor validation.
- Use a dedicated NetworkManager script instead of expanding Sprint 01 scripts, to preserve sprint boundaries.
- Validate service enablement, active state, and GUI command availability, leaving reboot persistence as a manual acceptance check.

## Validation
1. Install the packages listed in `packages/sprint-02-network.txt`.
2. Run `sudo bash scripts/enable-networkmanager.sh`.
3. Run `bash scripts/check-networkmanager.sh`.
4. Launch `nm-connection-editor` from a terminal.
5. Connect to WiFi and confirm it reconnects after reboot.

## Deferred Work
- no Waybar network integration
- no theming or icon work
- no Bluetooth setup
- no audio setup
- no install automation
