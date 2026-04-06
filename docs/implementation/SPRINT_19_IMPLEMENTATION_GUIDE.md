# Sprint 19 Implementation Guide

## Summary
Sprint 19 is complete. SDDM now uses a simple custom theme that matches the desktop's generated dark palette, bundles the current wallpaper as a local theme asset for reliable background rendering, and shares its visual language with hyprlock so the greeter and lock screen feel consistent.

## Files Added
- `docs/implementation/SPRINT_19_IMPLEMENTATION_GUIDE.md`
- `config/sddm/hyprland-setup/Main.qml`
- `config/sddm/hyprland-setup/metadata.desktop`
- `config/sddm/hyprland-setup/theme.conf`
- `config/sddm/hyprland-setup/background.jpg`
- `config/theme/sddm/theme.conf.template`
- `config/sddm/sddm.conf.d/10-hyprland-setup-theme.conf`
- `scripts/check-sddm-theme.sh`
- `scripts/verify-sddm-theme.sh`

## Files Updated
- `docs/sprints/SPRINT_19_SDDM.md`
- `README.md`
- `scripts/apply-generated-theme.sh`
- `config/theme/hyprlock/hyprlock.conf.template`
- `config/sddm/hyprland-setup/Main.qml`

## Decisions
- Keep Sprint 19 limited to a simple custom QML SDDM theme.
- Reuse the existing wallpaper and dark palette direction so the greeter matches the desktop.
- Stage the theme in the repo and provide the system config file needed to enable it, without adding installer automation yet.
- Render the SDDM theme colors from the generated `matugen` palette so SDDM and hyprlock share the same tokens and can adapt cleanly across dark and light palette modes.
- Bundle the wallpaper into the SDDM theme directory because local theme assets render more reliably in the greeter than system wallpaper paths.
- Align hyprlock to the SDDM card layout using generated palette tokens so both entry points share the same typography, panel, border, and muted text treatment.

## Validation
1. Copy the theme directory into `/usr/share/sddm/themes/`.
2. Copy the SDDM config drop-in into `/etc/sddm.conf.d/`.
3. Run `bash scripts/apply-generated-theme.sh`.
4. Run `bash scripts/check-sddm-theme.sh`.
5. Run `bash scripts/verify-sddm-theme.sh`.
6. Restart SDDM or reboot and confirm the greeter matches the desktop theme.
7. Run `hyprlock` and confirm it visually matches the SDDM theme.

## Deferred Work
- no animation polish
- no avatar/session switch styling beyond the simple layout
- no install automation
