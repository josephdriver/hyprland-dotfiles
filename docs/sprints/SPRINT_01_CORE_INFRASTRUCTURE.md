# Sprint 01 – Core Infrastructure

## Status
- State: Complete
- Last updated: 2026-03-24

## Goal
Establish foundational services required for a functional Wayland desktop.

## Components
- polkit-gnome
- xdg-desktop-portal-hyprland
- uwsm (validation)

## Tasks
1. Install required packages
2. Ensure polkit agent runs on session start
3. Ensure portal backend is active
4. Validate session environment

## Acceptance Criteria
- `pkexec` triggers GUI auth prompt
- File picker works in apps
- Screen sharing works
- No portal errors in logs

## Constraints
- No UI configuration
- No theming
- No Hyprland config refactor

## LLM Notes
Keep everything minimal and standard. Do not introduce abstractions.
