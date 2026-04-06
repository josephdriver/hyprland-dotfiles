# Hyprland Environment – Project Specification

## Overview

This project defines a clean, modern, lightweight Hyprland-based desktop environment for CachyOS/Arch Linux.

The goal is to create a reproducible, minimal, and highly consistent system that provides the core features expected of a full desktop operating system, while maintaining simplicity, performance, and maintainability.

This project is designed to be:
- Fully reproducible via install script (final phase)
- Modular and easy to extend
- Consistent in visual design across all components
- Optimized for Wayland and Hyprland
- Compatible with official Arch/CachyOS repositories (no AUR in base profile)

---

## Design Principles

### 1. Stability First
- Avoid Hyprland plugins in base system
- Prefer official repo packages
- Avoid unnecessary complexity

### 2. Modularity
- Each feature is implemented independently
- Configs are separated by concern
- Easy to debug and extend

### 3. Consistent UX
- All UI elements share a unified theme
- Behavior is predictable and minimal
- Interactions follow standard patterns

### 4. LLM-Friendly Structure
- Each feature isolated into a sprint
- Minimal cross-dependencies
- Clear inputs/outputs per component

---

## Core Feature Set

### Session & Core
- Hyprland
- UWSM session management
- XDG portal integration
- Polkit agent

### Shell
- Lock screen
- Idle management
- Wallpaper system
- Status bar
- Notifications
- Launcher
- Power menu

### System Integration
- Network management
- Bluetooth management
- Audio management
- Clipboard history
- Screenshots & recording

### UI/UX
- Interactive status bar
- Rofi-based launcher + power menu
- Clean keybind system

### Theming
- GTK + Qt theming
- Icon + cursor themes
- Dynamic palette generation (matugen)
- Consistent styling across:
  - Waybar
  - Rofi
  - Mako
  - Hyprlock
  - SDDM

### Core Applications
- Terminal
- File manager

### System Features
- Night light
- Brightness control
- Power profiles

---

## Technology Stack

### Core
- hyprland
- uwsm
- xdg-desktop-portal-hyprland
- polkit-gnome

### Shell
- hyprlock
- hypridle
- hyprpaper
- waybar
- mako
- rofi

### System
- networkmanager
- bluez + blueman
- pipewire + wireplumber + pavucontrol

### Utilities
- cliphist
- grim + slurp
- wf-recorder

### Theming
- matugen
- nwg-look
- qt6ct
- kvantum
- papirus-icon-theme

### Apps
- thunar
- foot

### System Extras
- hyprsunset
- brightnessctl
- power-profiles-daemon

---

## Architecture

### Config Structure
- ~/.config/<app>
- Modular Hyprland config (split files)
- Central theme templates

### Scripts
- Feature-specific scripts
- No monolithic scripts
- Reusable utilities

### Theming Pipeline
1. Select wallpaper
2. Generate palette via matugen
3. Render templates
4. Apply to all components

---

## Non-Goals (v1)
- No AUR dependency
- No Hyprland plugins
- No heavy UI frameworks (AGS, Quickshell)
- No GUI settings app

---

## Deliverables

- Working Hyprland environment
- Config repository
- Modular scripts
- Final install script (last sprint)

---

## Development Strategy

Development is split into sequential sprints:

1. Core infrastructure
2. System integration
3. Shell components
4. UX features
5. Theming
6. Final integration
7. Install automation

Each sprint is isolated and independently testable.

---

## Definition of Done

The system is complete when:

- All core features work reliably
- UI is visually consistent across all components
- System can be installed from scratch via script
- No manual steps required post-install
