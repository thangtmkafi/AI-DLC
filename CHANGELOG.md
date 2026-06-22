# Changelog

All notable changes to KAFI AI-DLC will be documented in this file. Format based on [Keep a Changelog](https://keepachangelog.com/en/1.1.0/) · this project adheres to [Semantic Versioning](https://semver.org/).

## [0.9] · 2026-06-12

### Promoted to the v0.9 stable line — consolidation + packaging & docs polish

v0.9 rolls up the v0.8.x patch line and hardens packaging, templates, and docs. **No methodology change** — the 17 stages, 7 roles, gate model, and 4 pillars are unchanged from v0.8.

- **Skill discovery fixed** — the 16 skills are flat at `.claude/skills/kafi-*/` (folder name == skill name), so they appear on `/` and auto-load by description.
- **FE templates completed** — added `user-flows.md` (Mermaid sequenceDiagram per cross-screen flow) and `mockup-index.md` (screen manifest); template count 32 → 34.
- **Templates reorganized** — grouped into phase subfolders, with inception-requirements/inception-design/construction split by owner (pm·ba / ui-ux·architecture / design·test). All references remapped; both editions in parity.
- **Installer** — accepts 3-part versions (vX.Y.Z); the edition + confirm prompts now read from /dev/tty, fixing the silently-skipped edition prompt under `curl | bash`.
- **README** rewritten as the public entry point — install-first, prompt-driven ("install, then just talk to the agent — it scaffolds the project skeleton and guides you stage by stage"), with a full cheatsheet and a Claude ↔ Kiro edition-switching guide.
- **Release automation** — GitHub Actions posts a Teams notification on release; docs container build added. Doc version banners updated to v0.9.

## [0.8.3.4] · 2026-06-12

### Changes . Change Notification Channel
- From Team Channel to Group Chat

## [0.8.3.3] · 2026-06-12

### Added · Teams notification job for GitHub Actions release workflow

- New `notify` job in `.github/workflows/build-release.yml` — runs after `build` succeeds and posts an Adaptive Card to the configured Power Automate webhook.
- Card extracts only the current version's changelog section from `CHANGELOG.md` (skips code blocks, caps at 35 lines).
- Release date parsed from the changelog header; falls back to the run date if absent.
- Card design aligned with KAFI design system: kafi-green title, muted metadata row (Version · Released · Editions), changelog body, inline docs link, and two action buttons — "Browse Docs" (positive/filled) and "View Release".
- `msTeams: {width: "Full"}` ensures the card fills the full post width.
- Docs URL `https://kai-foundry.kafisc.vn/kora/` wired into both the inline link and the primary action button.

## [0.9.1] · 2026-06-22

Patch release. **No methodology change** — the 17 stages, 7 roles, gate model, 34 templates, and 4 pillars are unchanged from v0.9. Fixes the design-system logo bug, removes the package-level README, and bumps version markers.

### Fixed · Design-system logo no longer auto-generated

- The `kafi-design-system` skill §17 carried an "SVG Fallback" that *drew* a placeholder logo (an X mark + a `<text>` "Kafi"), so agents rendered a fake logo instead of the brand asset. Removed the fallback and replaced it with a hard rule: the logo is a **fixed asset** — embed the official base64 PNG, never recreate or redraw it, no SVG. Added a light/dark variant table (light background → `KAFI_LOGO_DARK`; dark background → `KAFI_LOGO_WHITE`) and fixed the related "use SVG" pitfall-table line (`X mark` → `K mark`).
- Applied in parity to `packages/claude-code/.claude/skills/kafi-design-system/SKILL.md` and `packages/kiro/.kiro/steering/kafi-design-system.md`.
- `docs/index.html` — replaced the CSS-drawn `.logo-x` placeholder with the real per-theme base64 PNG (dark logo on the light theme, white logo on the dark theme); brand text `KAFI AI-DLC` → `AI-DLC`.

### Removed · Package-level README

- Deleted `packages/claude-code/README.md` and `packages/kiro/README.md`. The injection package no longer ships a README — installing AI-DLC into a project must not drop or overwrite the project's own `README.md`. The root `README.md` (public entry point) is unchanged.
- Installers (`tools/install.sh` + `tools/install.ps1`) no longer list `README.md` as a package path, so upgrade/convert no longer backs up or replaces the consuming project's README. The `ai-dlc/project.md` metadata template (previously in the package README §"How to use" step 4) is now inlined in the installer's next-steps output.
- Docs synced: Installer Guide file-set tables move `README.md` from "replaced" to "preserved"; the AGENTS.md folder tree and the Handbook injected-package diagram drop the README node; both onboarding skills repoint the README setup reference to `docs/KAFI-Installer-Guide.html`. Both editions in parity.

### Changed

- Version bumped v0.9 → v0.9.1 across `CLAUDE.md` / `AGENTS.md` banners + footers, `settings.json`, `config.json` (also corrected a stale v0.8 comment), the root `README.md` badge + install example, and the HTML doc banners (index · Introduction · Handbook · Installer Guide · Git Guide).

## [Unreleased]

### Planned (post-0.9 backlog)
- Test execution integration (CI hooks / runner-aware) — out of scope by design, project's choice
- Compliance verification stage — Stream A2
- Project extension YAML examples — Stream A4
- CI parity check (semantic diff, not just word count) — Stream A5
- `phase-delivery` extension (Stream B1)
- Per-phase `aidlc-docs/` folder schema (B2)
- MVP exit ramp at Stage 14 (B3)
- Loop-back protocol S17 → S4 (B4)
- `kafi-git-stage-flow` skill (B5)
- Sentinel + CI hook for CLAUDE.md/AGENTS.md (B6)
- Audit log rotation (B7) · Open-items aggregator skill (B8) · AI review hard-gate (B9) · Designer-BA review pattern (B10) · 2-part stage decision rule (B11) · Retrospective stage (B12)
- Automated PRD-NN → REQ-NN traceability checker — Stream C2
- BRD template — Stream C3
- Visual-diff tooling (screenshot mockup vs rendered FE) — Stream D1
- Mockup → component scaffold mode (literal HTML reuse) — Stream D2
- Per-language code reviewers beyond the v0.8 ten (e.g. Swift, PHP, Ruby) as projects need them
- Change-request (CR) protocol — parked brainstorm thread
- `kafi-memory` auto-skill-creation (currently suggestion-only)

## [0.8.3] · 2026-06-05

### Changed · Templates reorganized into phase + owner subfolders

The flat `templates/` directory (34 files) is now grouped by lifecycle phase, and the two phases with dual ownership are further split by owner — so a role finds its scaffolds in one place.

```
templates/
├── 00-pre-inception/            brief · vision · technical-environment · glossary · personas · risk-register
├── 01-inception-requirements/   pm/ (prd · requirements) · ba/ (epic · user-story · story-map)
├── 02-inception-design/         ui-ux/ (design-tokens · uiux-spec · view-model · user-flows · mockup-index · design-lite) · architecture/ (application-design · data-model · api-spec · components · unit-of-work)
├── 03-construction/             design/ (functional-design · code-flow · nfr-requirements · nfr-design · adr) · test/ (test-plan · test-cases · dod)
└── 04-operations/               deployment-runbook · monitoring-runbook · release-notes · postmortem
```

- All ~45 `templates/<name>.md` references across rule files, onboarding prompts, role guides, CLAUDE.md / AGENTS.md, and the HTML docs were remapped to the new phase/owner paths (e.g. `templates/01-inception-requirements/pm/prd.md`).
- Both editions identical (Claude `aidlc-rule-details/templates/`, Kiro `.kiro/templates/`); 34 files; `design-tokens.md`'s single edition-specific line (skill path) is the only intentional difference. No template content changed — pure reorganization.
- Version v0.8.2 → v0.8.3.

## [0.8.2] · 2026-06-05

### Added · Two missing FE-design templates (32 → 34)

A template audit found the FE-design set incomplete: `user-flows.md` and the mockups manifest had **no template**, yet both are Stage-7 Designer outputs referenced by downstream rules (and `user-flows` was even marked `★` in the doc-types table).

- **`user-flows.md`** (Stage 7 · Designer) — Mermaid `sequenceDiagram` per cross-screen flow with standard actor lanes (User · Screen · Handler · Service · Repo · DB) + `alt` error paths + a coverage table (flow ↔ story ↔ screen). It is the upstream contract that Stage 10 `code-flow.md` and the Stage 14c flow-conformance sub-check trace against — the Stage-7 twin of `code-flow.md`.
- **`mockup-index.md`** (Stage 7 · Designer) — machine-readable manifest authored to `mockups/index.md`: screen → HTML mockup → paired view-model → stories (US-NN) → target unit → states, plus a sitemap and coverage self-check.
- Both shipped to **both editions** (byte-identical), wired into the Stage-7 `product-design` rule, and added to the doc-types catalog (Introduction + Handbook). Template count **32 → 34** updated across CLAUDE.md / AGENTS.md / docs.
- Mockups themselves remain bespoke HTML via the `kafi-design-system` skill (correctly no template). Parity verified: 34 == 34 identical names; `design-tokens.md`'s single edition-specific line (skill path) is intentional.

### Fixed · Installer rejected 3-part versions (`vX.Y.Z`)

Carried from the v0.8.1 follow-up: `tools/install.sh` + `tools/install.ps1` validated only `vX.Y`, so installing/upgrading to a patch (`v0.8.1`, `v0.8.2`) failed and the version parser truncated `v0.8.1` → `v0.8`. The validation regex, GitHub latest-tag extraction, and current-version parser now accept an optional `.Z` segment.

## [0.8.1] · 2026-05-31

### Fixed · Skill discovery — flatten the `kafi/` skill group so skills appear on `/`

A packaging bug present since v0.4: Claude Code does **not** discover skills nested two levels deep, so the entire `kafi/` skill library laid out as `.claude/skills/kafi/<name>/SKILL.md` was never discovered — skills did not appear when typing `/` and did not auto-load by description. The IDE flagged "skill name should match the folder name" because the command name derives from the leaf folder, not the `name:` field.

- **Flattened** all 16 skills out of the `.claude/skills/kafi/` group to `.claude/skills/<name>/`, where the folder name now equals the `name:` field (`kafi-design-system`, `kafi-aidlc-onboarding`, `kafi-doc-sync`, `kafi-verification-loop`, `kafi-memory`, `kafi-code-review` + 10 per-language reviewers). The `kafi-` prefix is retained to avoid collisions with generically-named skills from other packages (onboarding, memory, code-review, design-system).
- **Moved role guides** from `.claude/skills/kafi/roles/` to `.claude/kafi-roles/` (they are reference docs loaded by path when driving a stage — not skills, so they no longer live under `skills/`).
- `kafi-aidlc-onboarding/prompts/` rides inside the onboarding skill folder (subfolders within a skill are fine).
- Updated ~55 path references across `CLAUDE.md`, `README.md`, rule files, onboarding prompts, and the HTML docs (Handbook/Introduction folder trees + skills tables + Installer Guide). Kiro edition is unaffected — its steering files are already flat (`.kiro/steering/kafi-*.md`).
- Version banner v0.8 → v0.8.1 in `CLAUDE.md`, `AGENTS.md`, `config.json`, `settings.json`. Methodology unchanged — docs HTML methodology banners remain v0.8; this is a packaging/layout patch.

### Fixed · Installer rejected 3-part versions (`vX.Y.Z`)

The bootstrap installers validated only `vX.Y`, so installing/upgrading to the **v0.8.1** patch failed with `Invalid version format: v0.8.1 (expected vX.Y)`, and the upstream version parser silently truncated `v0.8.1` → `v0.8` (breaking upgrade detection). Fixed in `tools/install.sh` + `tools/install.ps1`: the validation regex, the GitHub latest-tag extraction, and the current-version parser now all accept an optional `.Z` patch segment (`vX.Y` or `vX.Y.Z`). Installers are served live from `main` (raw), so the fix applies without a re-tag.

## [0.8] · 2026-05-29

### Added · ASCII+Mermaid layouts · code-flow · flow conformance · 14 skills · 13 templates · Operations formalized

The largest release to date. Closes HTML drift debt and adds the full per-language review, long-term-memory, and operations layers.

**Layout + flow specs:**
- `view-model.md` gains **§6 Layout sketch** — a Mermaid `flowchart TB` (agent-facing, structural) + ASCII box-drawing (human-facing, spatial), so agents grasp screen layout without parsing HTML.
- Stage 7 `user-flows.md` formalized as **Mermaid `sequenceDiagram`** per cross-screen flow (User → Screen → Handler → Service → Repo → DB · alt blocks).
- NEW per-unit **`code-flow.md`** (Stage 10, SA) — Mermaid sequence of the code call path per user action.
- Stage 14c gains a **5th blocking sub-check: Flow conformance** — code's actual call graph must match the `user-flows.md` + `code-flow.md` sequences.

**14 new skills:**
- `kafi-doc-sync` (keep `aidlc-docs/` current with `src/`) · `kafi-verification-loop` (build·typecheck·lint·tests·security one-pass) · `kafi-memory` (mine git history + postmortems for patterns → candidate skills/ADRs, human-curated)
- `kafi-code-review` router + 10 per-language reviewers: **typescript · python · go · java · kotlin · cpp · rust · csharp · database · shell** (powers Stage 14c sub-check 1).

**13 new templates** (19 → 32 total):
- `code-flow.md` · `glossary.md` (bilingual) · `api-spec.md` · `deployment-runbook.md` · `monitoring-runbook.md` · `brief.md` · `release-notes.md` · `postmortem.md` · `epic.md` · `personas.md` · `risk-register.md` · `design-lite.md` · `story-map.md`. No templates remain pending.

**Operations formalized:** Stage 16 (Deployment) + Stage 17 (Monitoring) lifted from placeholders — produce `deployment-runbook.md` + `monitoring-runbook.md` (SLOs derived from NFR thresholds) + `postmortem.md`.

### Changed
- Traceability chain: `Intent → Brief → Vision → [BRD] → PRD → REQ → ENT → Epic → Story → Unit → TC → ADR`.
- DevOps role: Operations stages no longer placeholders. Dev role: runs `kafi-verification-loop` before Stage 14c, follows `code-flow.md`. QA role: 5 sub-checks (added flow conformance). Designer role: authors layout sketch + Mermaid user-flows.
- **HTML docs deep-synced** (~935 lines of drift from v0.5/v0.6/v0.7 light passes): Handbook Stage 7/8 outputs, Operations de-placeholdered, doc-types catalog + skills section updated; Introduction adds a **Methodology & 4-pillars** section, trims the brainstorm section to a focused **"Next coming · KAI Atlas"** roadmap teaser.
- **NEW `docs/KAFI-AIDLC-Whats-New.html`** — v0.3 → v0.8 migration highlights page (indexed on the Pages landing) since most users are still on v0.3.
- Version banner v0.7 → v0.8 across CLAUDE.md, AGENTS.md, config.json, all HTML docs, docs/index.html.

## [0.7] · 2026-05-29

### Added · Conformance audit + QA role + 6 new templates (the "spec-driven, test-verified" model)

The central gap closed: AI-DLC now mechanically verifies that outputs conform to upstream specs at every gate. Hard checks at the AI Review Checklist + per-unit blocking audit at Stage 14c.

**6 new templates** (templates count 12 → 19):
- **`design-tokens.md`** — project-level look & feel catalog (colors, type, spacing, radius, shadow, motion). Inherits from KAFI design system skill + declares overrides. Stage 14c audits token discipline (no ad-hoc hex/px in FE code).
- **`uiux-spec.md`** — master UI/UX narrative: sitemap + navigation chrome + screen catalog + cross-screen flows + accessibility posture + coverage matrix (stories → screens). Single canonical entry point for the whole UI.
- **`view-model.md`** — per-screen MVVM data-binding contract. Field-binding table maps each on-screen field to source `entity.attribute` (ENT-NN), with type, format, validation, computed-field formula, state behavior.
- **`data-model.md`** — system-wide entities (ENT-NN), attributes, relationships, invariants, schemas, classifications (PII/audit). Stage 10 `domain-entities.md` derives per-unit views from this.
- **`test-plan.md`** — per-unit test strategy: scope, types, framework, coverage targets.
- **`test-cases.md`** — per-unit TC-NN catalog with Given/When/Then. Status fields stay "Pending" through AI-DLC (project executes outside).
- **`dod.md`** — generic Definition-of-Done rubric used at every stage approval gate.

**3 new stage rules + 1 new role:**
- **Stage 10b · Unit Test Planning** (NEW · QA) — per-unit, runs after Stage 10 functional-design. Outputs `test-plan.md` + `test-cases.md`.
- **Stage 14a · Production Code Generation** (renamed from Stage 14 · Dev) — production code only in `src/`.
- **Stage 14b · Unit Test Code Generation** (NEW · Dev) — translates `test-cases.md` into framework-specific test code (Jest/Vitest/Bun-test/pytest/etc. per `test-plan.md`).
- **Stage 14c · Conformance Audit** (NEW · QA · BLOCKING) — 4 sub-checks: (1) Code audit (boundaries, signatures, view-model bindings, audit/privacy wiring); (2) Token discipline audit (no hex/px literals in FE — regex enforced); (3) UI audit (mockup fidelity screen-by-screen + states); (4) Test code coverage audit (every function has test file + every TC-NN has test in code).
- **QA role** (NEW) — scoped narrowly: planning + audit only. Does NOT write test code (Dev does at 14b). Does NOT execute tests (project's CI/local).

**Process upgrade:**
- `process-overview.md` cycle gains **step 5.5: Spec conformance trace-back** — mechanical check that every output cites a parent ID from upstream stage.
- `ai-review-checklist.md` restructured into **Hard (blocking)** + **Soft (warnings)** groups. Hard items prevent the 2-option gate from being presented. Soft items remain warnings (user decides).

**Stage 7 expanded** to 4 deliverables: `design-tokens.md` first → `uiux-spec.md` master → `mockups/<screen>.html` per screen (CSS uses tokens, no hex literals) → `mockups/<screen>.view-model.md` per screen (data-binding contract).

**Stage 8 expanded**: adds `data-model.md` output. Stage 10 derives `domain-entities.md` from it.

**Stage 14 split into 14a/14b/14c** per above. The FE fidelity gate from v0.6 moves into Stage 14c sub-check #3.

### Changed
- Traceability chain extended: `Intent → Vision → [BRD] → PRD → REQ → ENT → Epic → Story → Unit → TC → ADR`. IDs gain `ENT-NN` (entities) + `TC-NN` (test cases).
- Pending templates list shrinks (dod + test-plan removed since shipped; still pending: epic, personas, risk-register, design-lite, story-map for v0.8+).
- Construction phase count 6 → 8 stages (10 + 10b + 11 + 12 + 13 + 14a + 14b + 14c + 15). Mermaid in CLAUDE.md/AGENTS.md updated. Roles table adds QA row.
- Designer role: now owns 3 contracts at Stage 7 — design-tokens (look & feel), uiux-spec (functionality narrative), view-model (data binding) — alongside HTML mockups.
- Dev role: now owns both 14a (production) and 14b (tests). Stage 15 unchanged.
- Onboarding skill: stage rubric updated for 7 new file signals (design-tokens, uiux-spec, view-model, data-model, test-plan, test-cases, conformance-report); Stage→Role→Prompt mapping adds 3 new rows.
- Version banner v0.6 → v0.7 across CLAUDE.md, AGENTS.md, `.kiro/settings/config.json`, all HTML docs, `docs/index.html`.

## [0.6] · 2026-05-27

### Added · HTML mockups as FE source of truth
- **Stage 7 Product Design now produces self-contained HTML mockups** (`aidlc-docs/inception/product-design/mockups/*.html`) as the canonical hi-fi deliverable, built with the design-system skill (inline CSS, KAFI tokens — opens standalone in a browser). One file per key screen, every state shown (default/empty/error/loading). Plus a `mockups/index.md` manifest mapping screen → file → US-NN → target unit. Replaces the prior vague "screen-designs/ (Markdown + image links)" as the primary output. Files: `inception/product-design.md` in both editions.
- **Stage 14 Code Generation now has an explicit `## Inputs` section** (previously had none) listing functional-design, nfr-design, `product-design/mockups/` (REQUIRED if UI), interaction-specs, and conventions.
- **Stage 14 FE fidelity gate (mandatory when unit has UI)** — the HTML mockup is the source of truth. Generated FE must reproduce the mockup's layout, component hierarchy, design tokens, and all states in the target framework (visual + structural contract, framework-agnostic). A screen-by-screen fidelity check is **Request-Changes-blocking**. UI with no source mockup ⇒ STOP + open item back to Stage 7 (no improvised UI). `code-generation-plan.md` gains a Mockup mapping table; approval gate gains a blocking fidelity line.

### Changed
- **Stage 10 Functional Design** inputs now reference `product-design/mockups/`; `frontend-components.md` components each cite their source mockup file.
- **Stage 8 Application Design** input note clarifies `product-design/` includes the HTML mockups; component boundaries should respect mockup screen structure.
- **Designer role** — deliverable is now self-contained HTML mockups (design-system skill), the FE source of truth, not reference images. **Dev role** — added hard rule "Generated FE MUST match the Stage 7 HTML mockup (layout, hierarchy, tokens, all states)"; key question + anti-patterns updated; stale "through v0.4" test-deferral refs fixed.
- **Onboarding prompts** (designer Stage 7 + dev Stage 14, both editions) updated for HTML mockup output + FE fidelity. **Onboarding stage-detection rubric** maps `mockups/*.html` to Stage 7 complete.
- **HTML docs** (Handbook + Introduction) Stage 7 + Stage 14 sections rewritten for HTML mockups + fidelity gate. Stale "Stage 4 PM + BA" folder-map label corrected to PM (sole).
- Version banner v0.5 → v0.6 in `CLAUDE.md`, `AGENTS.md`, `.kiro/settings/config.json`, all documentation HTML files, `docs/index.html`.

## [0.5] · 2026-05-26

### Added · PRD as Stage 4 co-deliverable
- **`prd.md` template** at `packages/claude-code/aidlc-rule-details/templates/` and `packages/kiro/.kiro/templates/`. Feature-scoped product narrative with 11 sections: feature overview, problem statement, target users/personas, user journey, PRD-NN features with Must/Should/Could priority, measurable success metrics, scope IN/OUT, dependencies, risks, constraints, open items, plus traceability footer mapping PRD-NN → REQ-NN → US-NN → UNIT-NN.
- **Stage 4 rule expanded to two-step deliverable** — Step 6a generates `prd-<feature>.md` per major feature (PRD answers *WHAT* and *FOR WHOM*); Step 6b derives `requirements.md` with REQ-NN entries each citing parent PRD-NN. Adaptive depth: Minimal (PRD inlined as preamble), Standard (1 PRD + REQs), Comprehensive (PRD per feature + full traceability). Files updated: `inception/requirements-analysis.md` in both editions.
- **PRD rubric (13 items)** added to `pre-inception/document-validator.md` — fills the prior "see individual rubric files" placeholder. Items mirror PRD template structure for consent-first classification of legacy attached docs.
- **Sub-flow D mode C** now references `prd.md` template explicitly. When mode C "Comprehensive" is selected, agent drafts `aidlc-docs/ba-authoring/<feature>/prd-draft.md` which feeds Stage 4 step 6a as PM finalizes the official PRD.
- **PM role file** + onboarding prompt template updated to reflect dual deliverable. PM now owns both PRD and Requirements at Stage 4; new "Trace REQ → PRD" rule prevents scope creep (REQ without parent PRD = incomplete PRD or scope creep, must resolve before approval).
- **Onboarding skill rubric** adds row mapping `prd-*.md` presence to Stage 4 in-progress state. State drift detection now considers PRD files alongside `requirements.md`.

### Changed
- Templates active list: 11 → 12 (added `prd.md`). Pending templates list updated — `prd.md` removed (now shipped); pending list narrowed to `epic.md`, `personas.md`, `risk-register.md`, `design-lite.md`, `story-map.md`, `dod.md`, `test-plan.md` (v0.6+).
- Traceability chain documentation reordered: `Intent → Vision → [BRD] → PRD → REQ → Epic → Story → Unit → ADR`. PRD now ahead of REQ in the chain (was bracketed and undefined in v0.4).
- Stage 4 ownership badge in Handbook fixed: PM + BA → PM (sole). Carry-over correction from v0.4 (rule files were already updated but HTML doc was missed).
- Version banner v0.4 → v0.5 in `CLAUDE.md`, `AGENTS.md`, `.kiro/settings/config.json`, all 4 documentation HTML files, `docs/index.html`.

### Added · Cross-platform installer (shipped with v0.5; built in v0.4 cycle, untagged at the time)
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
  - Companion `KAFI-AIDLC-Introduction.html` and `KAFI-AIDLC-Handbook.html`
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
