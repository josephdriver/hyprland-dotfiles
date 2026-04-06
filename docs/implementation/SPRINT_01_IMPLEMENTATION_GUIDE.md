# Sprint 01 Implementation Guide

## Summary
Sprint 01 is complete. Core infrastructure was validated with `polkit-gnome`, `xdg-desktop-portal-hyprland`, and `uwsm`, and the active Hyprland config now loads the Sprint 01 autostart snippet for the polkit agent and portal environment.

## Files Added
- `packages/sprint-01-core.txt`
- `scripts/verify-env.sh`
- `scripts/enable-services.sh`
- `scripts/post-install-check.sh`
- `scripts/check-uwsm-session.sh`
- `config/hypr/snippets/sprint-01-core.conf.example`
- `config/xdg-desktop-portal/README.md`

## Files Updated
- `docs/sprints/SPRINT_01_CORE_INFRASTRUCTURE.md`
- `docs/implementation/SPRINT_01_IMPLEMENTATION_GUIDE.md`
- `scripts/verify-env.sh`
- `scripts/post-install-check.sh`

## Decisions
- Keep Sprint 01 focused on `polkit-gnome`, `xdg-desktop-portal-hyprland`, and `uwsm` validation only.
- Use the existing helper scripts as the primary validation path before adding new Sprint 01 code.
- Avoid custom portal preference files in this sprint unless validation proves they are necessary.
- Strengthen the existing validation scripts so they check the polkit agent state and portal log health directly.

## Validation
1. Install the packages listed in `packages/sprint-01-core.txt`.
2. Run `scripts/verify-env.sh`.
3. Merge `config/hypr/snippets/sprint-01-core.conf.example` into the active Hyprland autostart config if needed.
4. Run `scripts/enable-services.sh`.
5. Log out and back in, or restart the user session.
6. Run `scripts/check-uwsm-session.sh`.
7. Run `scripts/post-install-check.sh`.
8. Perform the manual acceptance tests from the sprint document.
9. Confirm `polkit-gnome` is installed and the authentication agent is running.
10. Confirm `pkexec` shows a GUI auth prompt, portal file picking works, and screen sharing works.

## Deferred Work
- no network setup
- no bluetooth setup
- no bar
- no notifications
- no theming
- no install automation
