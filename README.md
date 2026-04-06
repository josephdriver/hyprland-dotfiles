# Hyprland Setup

Repo scaffold for a clean, modern, lightweight Hyprland desktop environment on CachyOS/Arch.

This repository is structured for LLM-assisted implementation and is intended to be built sprint-by-sprint.

## Included
- `PROJECT_SPEC.md` — master project specification
- `AGENTS.md` — instructions for human/LLM contributors
- `docs/sprints/` — ordered sprint specs for implementation
- `docs/implementation/SPRINT_01_IMPLEMENTATION_GUIDE.md` — implementation record for Sprint 01
- `packages/` — package manifests, starting with Sprint 01
- `scripts/` — feature-scoped helper and validation scripts
- `config/` — config snippets and placeholders

## Current Implementation Status
- Sprint docs scaffolded: 01–21
- Sprint 01 complete
- Sprint 02 complete
- Sprint 03 complete
- Sprint 04 complete
- Sprint 05 complete
- Sprint 06 complete
- Sprint 07 complete
- Sprint 08 complete
- Sprint 09 complete
- Sprint 10 complete
- Sprint 11 complete
- Sprint 12 complete
- Sprint 13 complete
- Sprint 14 complete
- Sprint 15 complete
- Sprint 16 complete
- Sprint 17 complete
- Sprint 18 complete
- Sprint 19 complete
- Install script intentionally deferred to the final sprint

## Progress

- [x] Sprint 01 - Core Infrastructure
- [x] Sprint 02 - Network Integration
- [x] Sprint 03 - Bluetooth Integration
- [x] Sprint 04 - Audio System
- [x] Sprint 05 - Notifications
- [x] Sprint 06 - Launcher
- [x] Sprint 07 - Power Menu
- [x] Sprint 08 - Hyprland Config Structure
- [x] Sprint 09 - Status Bar
- [x] Sprint 10 - Lock & Idle
- [x] Sprint 11 - Wallpaper System
- [x] Sprint 12 - Clipboard
- [x] Sprint 13 - Screenshot & Recording
- [x] Sprint 14 - Core Applications
- [x] Sprint 15 - System Features
- [x] Sprint 16 - Base Theme
- [x] Sprint 17 - Dynamic Theming
- [x] Sprint 18 - Theme Integration
- [x] Sprint 19 - SDDM Theming

## Sprint 01 Files
- `packages/sprint-01-core.txt`
- `scripts/verify-env.sh`
- `scripts/enable-services.sh`
- `scripts/check-uwsm-session.sh`
- `scripts/post-install-check.sh`
- `config/hypr/snippets/sprint-01-core.conf.example`

## Notes
- Theming is intentionally scheduled late, after core functionality is stable.
- Sprint 01 is validated and complete; later sprints should continue from this baseline without pulling in future-scope features early.
- Sprint 10 lock and idle behavior currently locks after 5 minutes of inactivity, powers displays off 30 seconds later, wakes them back to the lock screen on keyboard or mouse input, and powers them off again after 30 seconds if the session remains locked.
