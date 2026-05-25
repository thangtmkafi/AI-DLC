# Changelog

All notable changes to KAFI AI-DLC will be documented in this file. Format based on [Keep a Changelog](https://keepachangelog.com/en/1.1.0/) · this project adheres to [Semantic Versioning](https://semver.org/).

## [Unreleased]

### Added · Cross-platform installer
- **`tools/install.sh`** (bash, macOS/Linux) + **`tools/install.ps1`** (PowerShell, Windows) — auto-detects install vs upgrade vs convert mode from current folder contents.
  - Install mode: moves existing files to `00-knowledge/references/` (configurable exclusion list), downloads latest release zip from GitHub API, unzips into cwd.
  - Upgrade mode: parses current version from `CLAUDE.md` / `AGENTS.md`, compares to latest, backs up package files to `.aidlc-backup-<timestamp>/`, replaces with new version. Preserves `00-knowledge/`, `aidlc-docs/`, `src/`, `adrs/`, `ai-dlc/`.
  - **Convert mode** (`--convert-to=claude-code|kiro` / `-ConvertTo`): switches editions while preserving user content. Backs up FROM-edition files to `.aidlc-backup-<ts>-from-<edition>/`, installs TO-edition at latest version. `00-knowledge/`, `aidlc-docs/`, `src/`, `adrs/`, `ai-dlc/` are edition-agnostic and pass through untouched. Customizations to rule/role/skill files are NOT auto-ported (paths + YAML frontmatter differ between editions); installer reminds user to diff backup against new edition and manually port.
  - Flags: `--mode`, `--edition`, `--version`, `--convert-to`, `--yes`, `--dry-run`, `--no-move`. 1-prompt summary before destructive actions.
  - Safety: refuses on `$HOME` / `~/Desktop` / `/` / `C:\Users`, mixed-state detection, atomic download → validate → unzip.
  - Invocation: `curl -fsSL <raw>/tools/install.sh | bash` (Mac/Linux) or `iwr -useb <raw>/tools/install.ps1 -OutFile install.ps1; .\install.ps1` (Windows).

### Added · Onboarding skill prompt templates
- 6 role-specific prompt templates in `.claude/skills/kafi/onboarding/prompts/` (Claude) and `.kiro/steering/kafi-aidlc-onboarding-prompts/` (Kiro) — loaded internally by `kafi-aidlc-onboarding` skill when Mode B detects a stage. Each template has Your Role · Plan · Your Task scaffolding with placeholders the skill substitutes from detected context. **Users no longer manually copy-paste starter prompts** — the skill is the single entry point.
- `kafi-aidlc-onboarding` SKILL.md (both editions) expanded with Stage → Role → Prompt mapping table + Prompt template loading protocol section.

### Added · Installer documentation
- `docs/KAFI-Installer-Guide.html` — full user guide with KAFI design system v2.2 styling: quick start, install/upgrade modes detail, flags reference, safety guardrails, exclusion list, troubleshooting, after-install onboarding.

### Changed · Doc cleanup
- `docs/KAFI-AIDLC-Introduction-{Claude,Kiro}.html` — added "Quick install" section near top; replaced "Role playbooks" section (6 large starter prompt blocks) with slim "How to start a session" pointing to onboarding skill + Stage → Role → Prompt mapping table. Both files trimmed ~228 lines.
- `docs/KAFI-AIDLC-Handbook-{Claude,Kiro}.html` — added "Quick install" section at top of Part 1; replaced "Starter prompts" section (Part 1) with slim "How to start a session". Both files trimmed ~175 lines.
- `packages/claude-code/README.md` + `packages/kiro/README.md` — "How to use" / "Quick start" now leads with one-liner installer; manual cp-r steps retained as fallback under "Manual install".

### Planned for v0.5
Carry-over from original v0.4 plan (deferred to focus v0.4 on workflow correctness fixes):
- Test artifacts stage + template (`test-plan.md`)
- Compliance verification stage
- Operations stages expanded from placeholder to concrete specs
- Project extension YAML examples
- CI parity check (semantic diff, not just word count)

From v0.4 pain-points brainstorm (`docs/ai-dlc-pain-points-2026-05.md`):
- `phase-delivery` extension (replaces unimplemented `phase-discipline` manifest)
- Per-phase `aidlc-docs/` folder schema (avoid overwrites on revisit)
- MVP exit ramp at Stage 14 (3-option gate: Request Changes / Continue / Ship MVP)
- Loop-back protocol S17 → S4 for phase N+1
- `kafi-git-stage-flow` skill (wraps 6-8 git commands into stage macros for non-dev roles)
- Open-items aggregator skill
- Retrospective stage (Stage 18 or extension)
- Sentinel + CI hook for CLAUDE.md/AGENTS.md (Problem 4.12 Option C — defense-in-depth)

## [0.4] · 2026-05-25

### Fixed
- `aidlc-state.md` drift — stage execution cycle now requires updating state file after approval (step 9). Added explicit "State file maintenance" rules for all status transitions (`planning` / `execution` / `awaiting-approval` / `complete`) plus anti-pattern entry. Resume from interruption now reflects actual progress instead of stale Stage 1 snapshot. Parity applied to both editions: `packages/claude-code/aidlc-rule-details/common/process-overview.md` and `packages/kiro/.kiro/steering/common/process-overview.md`.
- CLAUDE.md templates list drifted from disk reality (claimed 7 templates that don't exist, omitted 7 that do). Reconciled to actual 11 templates on disk; added explicit "Pending templates" callout for `prd.md` / `epic.md` / `personas.md` / `risk-register.md` / `design-lite.md` / `story-map.md` / `dod.md` / `test-plan.md`. Kiro AGENTS.md already had the correct list — only ordering aligned + pending callout added for parity.

### Changed
- **Stage 4 (Requirements Analysis) ownership: PM + BA → PM (sole).** Removes co-ownership ambiguity. BA can be consulted but PM has sole approval. Files updated: CLAUDE.md / AGENTS.md mermaid + Roles table, `inception/requirements-analysis.md`, `templates/requirements.md`, `roles/pm.md` (with BA → sole), `roles/ba.md` (Stage 4 moved from "drive" to "contribute advisory"), `packages/claude-code/README.md` doc-types table.
- **Stage 10 (Functional Design) ownership: BA + SA → SA (sole).** Same rationale. Files updated: CLAUDE.md / AGENTS.md mermaid + Roles table, `construction/functional-design.md`, `templates/functional-design.md`, `roles/sa.md` (added Stage 10 + reference to template), `roles/ba.md` (Stage 10 moved from "drive" to "contribute advisory"), README doc-types table.
- BA role scope narrowed to Stage 5 (User Stories, sole) + Pre-Inception sub-flows B/C/D. SA role scope widened to include Stage 10. New "Stages where you contribute (advisory only)" section added to BA role file documenting the consultation pattern for Stages 4 and 10.
- Version banners in `CLAUDE.md` and `AGENTS.md` simplified: removed "Adapted from AWS AI-DLC + Toan Huynh playbook" attribution to keep header concise. Attribution remains in `README.md` and Handbook docs.

### Added
- **`kafi-aidlc-onboarding` skill** — first-session onboarding skill with 3 modes: (A) fresh-install setup wizard, (B) stage detection from legacy artifacts in `00-knowledge/`, (C) resume from existing `aidlc-state.md` with drift reconciliation. Includes a 16-row stage detection rubric mapping file patterns to AI-DLC stages and output format with suggested next-prompt. Explains why `/init` is redundant on AI-DLC projects (`CLAUDE.md` / `AGENTS.md` already auto-loaded; `/init` is non-destructive per Claude Code design but may dilute methodology focus if generic suggestions are accepted blindly). Files added: `packages/claude-code/.claude/skills/kafi/onboarding/SKILL.md` and `packages/kiro/.kiro/steering/kafi-aidlc-onboarding.md`. Both READMEs updated with `/init` note + onboarding skill invocation hint. CLAUDE.md / AGENTS.md updated to register the skill.

### Documentation
- Brainstorm doc: AI-DLC v0.3 pain points + improvement candidates — `docs/ai-dlc-pain-points-2026-05.md`. 21 findings across 4 clusters with code-grounded `file:line` citations. Decisions taken in v0.4: Problems 1, 4.6, 4.7, 4.11. Deferred to v0.5: Problems 2 (waterfall rigidity), 3 (git skills), 4.1-4.5, 4.8-4.10, 4.12.

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
