# Changelog

All notable changes to KAFI AI-DLC will be documented in this file. Format based on [Keep a Changelog](https://keepachangelog.com/en/1.1.0/) · this project adheres to [Semantic Versioning](https://semver.org/).

## [Unreleased]

### Planned for v0.4
- Test artifacts stage + template
- Compliance verification stage
- Operations stages expanded from placeholder to concrete specs
- Project extension YAML examples
- CI parity check (semantic diff, not just word count)

## [0.3] · 2026-05-15

### Added
- **Kiro IDE edition** — full port of v0.3 to Kiro IDE conventions
  - `AGENTS.md` root file (universal agents.md spec)
  - `.kiro/steering/` library with YAML `inclusion: always|manual` front-matter
  - `.kiro/specs/_template/` for Kiro-native spec-driven workflows (4 files: spec.json + requirements.md + design.md + tasks.md)
  - 39 steering files with 8 always-loaded + 31 manual-loaded inclusion modes
  - Companion `KAFI-AIDLC-Introduction-Kiro.html` and `KAFI-AIDLC-Handbook-Kiro.html`
- Visual walkthrough section in Handbook showing Kiro UI moments (project layout, agent startup, role loading)
- Kiro spec mode section in Handbook explaining native feature-scoped pattern alongside full AI-DLC lifecycle

### Changed
- Both editions ship as separate downloadable packages in `releases/v0.3/`
- Cross-reference between Introduction, Handbook, and package zip clarified per platform

### Source migration · Claude Code → Kiro IDE
- `CLAUDE.md` → `AGENTS.md`
- `.claude/skills/kafi/` → `.kiro/steering/`
- `.claude/settings.json` → `.kiro/settings/config.json`
- `aidlc-rule-details/` → `.kiro/steering/` (folder structure preserved)
- `aidlc-rule-details/templates/` → `.kiro/templates/`
- All internal cross-references rewritten

## [0.2] · Pre-public

Internal Transformation Office iterations · not released.

## [0.1] · Pre-public

Initial AWS AI-DLC adaptation · internal experimentation.
