# Sprint 10 Implementation Guide

## Summary
Sprint 10 is complete. `hyprlock` and `hypridle` are configured with functional lock and idle settings, `hypridle` starts from the Hyprland autostart module, and the idle flow now powers displays off 30 seconds after locking while waking them back to the lock screen on keyboard or mouse activity. If the displays are woken while the session remains locked, the display-off timer continues to run and powers them off again after another 30 seconds.

## Files Added
- `docs/implementation/SPRINT_10_IMPLEMENTATION_GUIDE.md`
- `packages/sprint-10-lock-idle.txt`
- `config/hypr/hypridle.conf`
- `config/hypr/hyprlock.conf`
- `scripts/check-lock-idle.sh`

## Files Updated
- `docs/sprints/SPRINT_10_LOCK_IDLE.md`
- `README.md`
- `config/hypr/modules/30-autostart.conf.example`
- `~/.config/hypr/modules/30-autostart.conf`
- `config/hypr/hypridle.conf`
- `~/.config/hypr/hypridle.conf`

## Decisions
- Keep Sprint 10 limited to default functional `hyprlock` and `hypridle` behavior.
- Start `hypridle` from the existing Hyprland autostart module instead of introducing a separate launcher path.
- Use simple timeout listeners only, with no styling or advanced power actions in this sprint.
- Trigger `hyprlock` directly from the idle timeout so lock behavior is consistent with the current Hyprland session.
- Turn displays off through `hypridle` 30 seconds after the lock timeout, because `hyprlock` itself does not manage DPMS and `hypridle` can wake displays cleanly on input.
- Set `ignore_inhibit = true` only on the DPMS listener so the screen-off timer keeps working while the lock screen is active, without changing the normal lock timeout behavior.

## Validation
1. Install the packages listed in `packages/sprint-10-lock-idle.txt`.
2. Copy `config/hypr/hyprlock.conf` to `~/.config/hypr/hyprlock.conf`.
3. Copy `config/hypr/hypridle.conf` to `~/.config/hypr/hypridle.conf`.
4. Reload Hyprland or start a fresh session.
5. Run `bash scripts/check-lock-idle.sh`.
6. Confirm manual lock works and idle locking triggers.
7. Confirm displays power off 30 seconds after locking.
8. Confirm keyboard or mouse input wakes the displays back to the lock screen.
9. Confirm that if the displays are woken but the session stays locked, they power off again after another 30 seconds.

## Deferred Work
- no styling
- no suspend integration
- no custom unlock visuals
- no install automation
