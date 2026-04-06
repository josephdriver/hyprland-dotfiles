# Sprint 18 Implementation Guide

## Summary
Sprint 18 is complete. The generated dark `matugen` palette is now applied across Waybar, rofi, mako, and hyprlock through template-driven user config generation, with follow-up tuning to improve rofi container backgrounds, selected-item contrast, and border consistency with mako notifications.

## Files Added
- `docs/implementation/SPRINT_18_IMPLEMENTATION_GUIDE.md`
- `scripts/apply-generated-theme.sh`
- `scripts/check-theme-integration.sh`
- `config/theme/waybar/style.css.template`
- `config/theme/rofi/theme.rasi.template`
- `config/theme/mako/config.template`
- `config/theme/hyprlock/hyprlock.conf.template`

## Files Updated
- `docs/sprints/SPRINT_18_THEME_INTEGRATION.md`
- `README.md`
- `config/rofi/config.rasi`
- `~/.config/rofi/config.rasi`

## Decisions
- Keep Sprint 18 limited to applying the existing generated palette to shell-facing UI components only.
- Use generated user config files from templates instead of directly editing app configs by hand.
- Apply the dark palette only in this sprint to avoid mixing static light and dark outputs prematurely.

## Validation
1. Ensure Sprint 17 palette files exist.
2. Run `bash scripts/apply-generated-theme.sh`.
3. Run `bash scripts/check-theme-integration.sh`.
4. Reload or restart affected apps.
5. Confirm Waybar, rofi, mako, and hyprlock share the generated palette.
6. Confirm rofi uses the imported generated theme and highlighted entries remain readable.
7. Confirm mako border width and color match the adjusted rofi border.

## Deferred Work
- no SDDM theming yet
- no light/dark mode switching
- no automatic wallpaper-triggered regeneration
- no install automation
