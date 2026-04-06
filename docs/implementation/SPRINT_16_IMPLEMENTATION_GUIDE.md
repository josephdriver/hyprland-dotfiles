# Sprint 16 Implementation Guide

## Summary
Sprint 16 is complete. A static dark GTK and Qt baseline is now in place using `Adwaita-dark`, `Papirus`, `Noto Sans`, `qt6ct`, and `Kvantum`, and validation confirmed GTK and Qt applications share the intended non-dynamic dark theme foundation.

## Files Added
- `docs/implementation/SPRINT_16_IMPLEMENTATION_GUIDE.md`
- `packages/sprint-16-base-theme.txt`
- `config/gtk/gtk-3.0/settings.ini`
- `config/gtk/gtk-4.0/settings.ini`
- `config/qt6ct/qt6ct.conf`
- `config/Kvantum/kvantum.kvconfig`
- `scripts/check-base-theme.sh`

## Files Updated
- `docs/sprints/SPRINT_16_BASE_THEME.md`
- `README.md`
- `config/hypr/modules/40-environment.conf.example`
- `~/.config/hypr/modules/40-environment.conf`

## Decisions
- Keep Sprint 16 limited to static theming only.
- Establish GTK and Qt defaults first, without touching dynamic color generation.
- Use a stable icon theme baseline and simple font defaults so later theming sprints can build on them consistently.
- Use a dark default baseline so the pre-integration desktop already aligns with the shell's dark appearance.

## Validation
1. Install the packages listed in `packages/sprint-16-base-theme.txt`.
2. Copy the repo theme configs into the matching user config directories.
3. Run `bash scripts/check-base-theme.sh`.
4. Open GTK and Qt apps and confirm they share the intended static theme baseline.

## Deferred Work
- no dynamic colors
- no template rendering
- no per-app styling polish
- no install automation
