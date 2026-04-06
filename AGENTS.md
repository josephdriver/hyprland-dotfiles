# AGENTS.md

## Purpose

This file defines how humans and LLM agents must work within this repository.

The goal is to ensure:

* consistent progress across sprints
* no drift between plan and implementation
* clean, modular, and reproducible system design
* safe, scoped changes without breaking other features

---

## Core Principle

Every sprint must keep **four sources of truth in sync**:

1. Sprint Definition → `docs/sprints/SPRINT_XX_*.md`
2. Implementation Record → `docs/implementation/SPRINT_XX_IMPLEMENTATION_GUIDE.md`
3. Actual Code → `config/`, `scripts/`, `packages/`
4. Project State → `README.md` progress + `PROJECT_SPEC.md` (if needed)

If any of these diverge, the project is considered **out of sync**.

---

## Repository Intent
- Stable, lightweight, modern Hyprland environment
- Consistent UX and visual language
- LLM-friendly implementation workflow

---

## Working Rules
1. Implement features strictly in sprint order unless a dependency requires otherwise.
2. Do not combine multiple sprint scopes into one implementation step.
3. Prefer official Arch/CachyOS repository packages in the base profile.
4. Avoid Hyprland plugins in v1 unless explicitly approved.
5. Keep configs modular and easy to diff.
6. Favor small scripts over large monolithic scripts.
7. Do not introduce theming changes before the theming sprints.
8. The install script must be implemented last.

---

## Coding Preferences
- Keep shell scripts POSIX-compliant where practical; use bash when necessary.
- Use clear comments only when they add real value.
- Avoid unnecessary abstraction.
- Keep generated files separate from source templates.

---

## Non-Goals for v1
- No AUR dependency in base profile
- No Hyprland plugins
- No heavy desktop shell frameworks
- No installer implementation before the final sprint

---

## Required Workflow (MANDATORY)

For every sprint, follow this exact sequence:

---

### Step 1 — Read Context

Before making changes, ALWAYS read:

* `PROJECT_SPEC.md`
* Current sprint file (`docs/sprints/...`)
* Previous sprint implementation guide
* Relevant config/scripts already in repo

DO NOT assume anything outside these files.

---

### Step 2 — Set Sprint Status

Update sprint file:

```md
## Status
- State: In Progress
- Last updated: YYYY-MM-DD
```

---

### Step 3 — Create Implementation Guide

Create:

```
docs/implementation/SPRINT_XX_IMPLEMENTATION_GUIDE.md
```

This file is REQUIRED before writing code.

---

### Step 4 — Implement ONLY Sprint Scope

You MUST:

* Only implement what is defined in the sprint
* Avoid touching future sprint features
* Avoid adding polish, theming, or UX improvements unless explicitly required

#### Strictly Forbidden:

* Adding Waybar integration during network sprint
* Adding theming before theming sprints
* Adding keybinds outside relevant sprint
* Combining multiple sprint concerns

---

### Step 5 — Update Repo Files

Changes must be **minimal and scoped**:

#### Allowed:

* `packages/sprint-XX-*.txt`
* `scripts/*` (only relevant ones)
* `config/*` (only relevant sections or snippets)
* new docs

#### Avoid:

* modifying unrelated configs
* refactoring other sprint work
* global restructuring

---

### Step 6 — Update Implementation Guide

Every implementation guide MUST include:

```md
# Sprint XX Implementation Guide

## Summary
What was implemented

## Files Added
- ...

## Files Updated
- ...

## Decisions
- Why choices were made

## Validation
- Commands to test

## Deferred Work
- What is intentionally postponed to later sprints
```

---

### Step 7 — Validate Against Acceptance Criteria

Check ONLY what the sprint defines.

#### Do NOT:

* validate future integrations
* validate styling
* validate unrelated systems

---

### Step 8 — Update README Progress

Update:

```md
## Progress

- [x] Sprint 01 – Core Infrastructure
- [ ] Sprint 02 – Network Integration
```

---

### Step 9 — Update Project Spec (IF REQUIRED)

Only update `PROJECT_SPEC.md` if:

* architecture changed
* package choice changed
* design principle changed

Otherwise DO NOT modify it.

---

### Step 10 — Mark Sprint Complete

Update sprint file:

```md
## Status
- State: Complete
- Last updated: YYYY-MM-DD
```

---

## File Responsibilities

### `PROJECT_SPEC.md`

* Authoritative system design
* Updated ONLY for architectural changes

---

### `docs/sprints/`

* Defines intended work
* Never rewritten mid-sprint (only status updated)

---

### `docs/implementation/`

* Records what actually happened
* Always created per sprint
* Critical for LLM continuity

---

### `packages/`

* Installation inputs
* Use sprint-specific manifests during development
* Merge later into final manifests

---

### `scripts/`

* Small, focused utilities
* One responsibility per script

---

### `config/`

* Modular configs
* Prefer snippets over monolithic files

---

### `README.md`

* Current state of project
* Sprint progress tracker

---

## Sprint Boundaries (CRITICAL)

Each sprint must remain **strictly isolated**.

### Example:

During Sprint 02 (Network):

#### Allowed:

* install NetworkManager
* verify connectivity
* add network scripts

#### NOT allowed:

* Waybar network module
* themed icons
* click handlers
* Bluetooth setup
* audio setup

---

## Theming Rule

Theming is **DEFERRED until late sprints**.

Before theming sprints:

* NO colors
* NO styling
* NO visual polish

Only functionality is implemented.

---

## LLM Usage Rules

When using an LLM:

Always provide:

1. `PROJECT_SPEC.md`
2. Current sprint file
3. Previous sprint implementation guide
4. Relevant repo files

### Prompt Example:

> Implement Sprint 02 using the sprint file. Do not modify anything outside scope. Follow AGENTS.md rules strictly.

---

## Anti-Patterns (STRICTLY AVOID)

* Mixing multiple sprint features
* Early theming
* Over-engineering scripts
* Refactoring unrelated code
* Introducing AUR dependencies in base system
* Using Hyprland plugins

---

## Definition of "Synced"

The project is synced when:

* Sprint doc matches implementation
* Implementation guide exists and is complete
* Repo contains only expected files
* README reflects actual progress
* No hidden or undocumented changes exist

---

## Final Rule

If unsure:

> Do less, not more.

Keep changes minimal, scoped, and documented.

This is what keeps the system clean and maintainable.

