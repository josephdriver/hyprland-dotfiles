# Sprint 17 Implementation Guide

## Summary
Sprint 17 is complete. `matugen` now generates light and dark palette files from the current wallpaper, records the source image used for generation, and provides a terminal preview script for inspecting key colors, without integrating the palette into application configs yet.

## Files Added
- `docs/implementation/SPRINT_17_IMPLEMENTATION_GUIDE.md`
- `packages/sprint-17-matugen.txt`
- `config/matugen/config.toml`
- `scripts/generate-palette.sh`
- `scripts/check-matugen.sh`
- `scripts/preview-palette.sh`

## Files Updated
- `docs/sprints/SPRINT_17_MATUGEN.md`
- `README.md`

## Decisions
- Keep Sprint 17 limited to palette generation only.
- Use the current wallpaper as the source image for `matugen`.
- Generate outputs into a dedicated cache/output path so later integration sprints can consume them without rewriting app configs yet.

## Validation
1. Install the packages listed in `packages/sprint-17-matugen.txt`.
2. Copy `config/matugen/config.toml` to `~/.config/matugen/config.toml`.
3. Run `bash scripts/generate-palette.sh`.
4. Run `bash scripts/check-matugen.sh`.
5. Run `bash scripts/preview-palette.sh`.
6. Confirm a palette and generated files are produced.

## Deferred Work
- no app integration yet
- no live wallpaper hooks
- no automatic reload flow
- no install automation
