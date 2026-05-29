# Session Handoff · KAFI AI-DLC

> **Drop this file at repo root.** When opening this repo in Claude Code, your first prompt should be:
> *"Read `SESSION_HANDOFF.md` and propose what to tackle next from the v0.9 backlog."*

---

## Where we are

This is the **KAFI AI-DLC methodology repo** — it contains the workflow rules, role guides, templates, and two IDE editions (Claude Code + Kiro). It is **not** a KAFI product repo.

**Important meta point.** There are **two `CLAUDE.md` files** in this repo and they serve different purposes:

- **`/CLAUDE.md`** (repo root · auto-loaded) — Development context for working ON this repo. Tells Claude Code about the parity rule, file map, style expectations. Read `SESSION_HANDOFF.md` next for current state.
- **`/packages/claude-code/CLAUDE.md`** — The AI-DLC workflow content shipped to end-users. Has parity with `/packages/kiro/AGENTS.md`. Edit only as part of a v0.X release.

Don't conflate the two. Editing the root one shapes how this repo is developed; editing the package one ships to every KAFI project using AI-DLC.

**Current state:** v0.8 shipped 29 May 2026. Two editions, content parity verified.

- **Claude Code Edition** — `packages/claude-code/` · `CLAUDE.md` + `.claude/skills/` + `aidlc-rule-details/`
- **Kiro Edition** — `packages/kiro/` · `AGENTS.md` + `.kiro/steering/` with YAML inclusion modes

Both ship as zip files in `releases/v0.8/`. GitHub Actions auto-builds new zips on tag push.

### v0.8 changes (shipped 2026-05-29) — mega release

- **Added** · view-model §6 Layout sketch (Mermaid flowchart + ASCII); `user-flows.md` as Mermaid sequenceDiagram; NEW per-unit `code-flow.md` (Stage 10); Stage 14c 5th sub-check **flow conformance**.
- **Added** · 14 skills: `kafi-doc-sync`, `kafi-verification-loop`, `kafi-memory`, `kafi-code-review` router + 10 per-language reviewers (TS/Python/Go/Java/Kotlin/Cpp/Rust/Csharp/Database/Shell).
- **Added** · 13 templates (19 → 32): code-flow · glossary · api-spec · deployment-runbook · monitoring-runbook · brief · release-notes · postmortem · epic · personas · risk-register · design-lite · story-map. No pending templates remain.
- **Changed** · Operations (Stage 16/17) formalized from placeholders → runbook-driven. DevOps/Dev/QA/Designer roles updated.
- **Changed** · HTML docs deep-synced (~935 lines drift closed); Introduction adds Methodology/4-pillars + trims brainstorm to "Next coming · KAI Atlas".
- **Added** · NEW `docs/KAFI-AIDLC-Whats-New.html` (v0.3→v0.8 migration page, indexed on Pages landing).

### v0.7 changes (shipped 2026-05-29)

The "spec-driven, test-verified" upgrade. Conformance audit becomes a mechanical gate — not advisory.

- **Added** · 6 new templates: `design-tokens.md` · `uiux-spec.md` · `view-model.md` · `data-model.md` · `test-plan.md` · `test-cases.md` · `dod.md`. Templates total 12 → 19.
- **Added** · QA role (planning + audit only, NO test code, NO execution).
- **Added** · Stage 10b Unit Test Planning (QA) + Stage 14b Unit Test Code Generation (Dev) + Stage 14c Conformance Audit (QA · BLOCKING with 4 sub-checks).
- **Changed** · Stage 14 → Stage 14a (Production Code only). FE fidelity gate from v0.6 moves into Stage 14c sub-check 3.
- **Changed** · Stage 7 now produces 4 outputs: design-tokens → uiux-spec → mockups/<screen>.html → mockups/<screen>.view-model.md. Mockup CSS uses CSS custom properties referencing design-tokens.md (no hex literals).
- **Changed** · Stage 8 adds `data-model.md` output. Stage 10 derives `domain-entities.md` from it.
- **Changed** · Process overview cycle: step 5.5 spec conformance trace-back (mechanical). AI Review Checklist split into Hard (blocking) + Soft (warning).
- **Changed** · Traceability chain extended: `… → PRD → REQ → ENT → … → Unit → TC → ADR`.

### v0.6 changes (shipped 2026-05-27)

HTML mockups as FE source of truth + strict Stage 14 fidelity gate.

- **Added** · Stage 7 produces self-contained HTML mockups (`product-design/mockups/*.html`, design-system styled) as canonical hi-fi deliverable + `mockups/index.md` manifest. Replaces vague Markdown+image screen-designs.
- **Added** · Stage 14 gains an explicit Inputs section (previously had none) + a mandatory FE fidelity gate. Mockup = source of truth; generated FE must reproduce layout/hierarchy/tokens/all-states (visual+structural contract, framework-agnostic). Screen-by-screen check is Request-Changes-blocking. No mockup ⇒ STOP + open item back to Stage 7.
- **Changed** · Stage 10 references mockups; frontend-components cite source mockup. Stage 8 input note clarified. Designer role (HTML mockup deliverable) + Dev role (hard "match mockup" rule) + onboarding prompts + rubric updated. HTML docs Stage 7/14 rewritten.

### v0.5 changes (shipped 2026-05-26)

PRD formalization + installer/onboarding tooling consolidation.

- **Added** · `prd.md` template (both editions, ~80 lines). Sits between Vision and Requirements in the traceability chain — PRD answers *WHAT* and *FOR WHOM* with measurable success criteria; Requirements (REQ-NN) answer *HOW THE SYSTEM MUST BEHAVE*.
- **Added** · Stage 4 dual deliverable. PM now produces both `prd-<feature>.md` (step 6a) and `requirements.md` (step 6b, each REQ cites parent PRD-NN). Adaptive depth: Minimal/Standard/Comprehensive. Files: `inception/requirements-analysis.md` in both editions.
- **Added** · PRD rubric (13 items) in `pre-inception/document-validator.md` — replaces "see individual rubric files" placeholder.
- **Added** · Onboarding skill rubric row mapping `prd-*.md` files to Stage 4 in-progress.
- **Changed** · Templates count 11 → 12. Pending list narrowed (drops `prd.md`, retains `epic.md`/`personas.md`/etc as v0.6+).
- **Changed** · Traceability chain documentation: `Vision → [BRD] → PRD → REQ → Epic → Story → Unit → ADR`. PRD no longer bracketed.
- **Changed** · Stage 4 ownership badge in Handbook fixed (PM + BA → PM sole) — v0.4 carry-over correction in HTML doc.
- **Tooling consolidation** · Cross-platform installer (`tools/install.sh` + `install.ps1`), 6 onboarding skill prompt templates, `KAFI-Installer-Guide.html`, doc cleanup — all built in v0.4 cycle but untagged at the time, now ship with v0.5.

### v0.4 changes (shipped 2026-05-25)

Driven by `docs/ai-dlc-pain-points-2026-05.md` triage — focused on workflow correctness, not new stages.

- **Fixed** · Problem 1 — `aidlc-state.md` drift: stage cycle now 10 steps with step 9 = "update state file".
- **Fixed** · Problem 4.7 — CLAUDE.md templates list reconciled with disk reality.
- **Changed** · Problem 4.6 — Stage 4 ownership PM+BA → PM (sole). Stage 10 ownership BA+SA → SA (sole). BA scope narrowed to Stage 5 + Pre-Inception.
- **Added** · Problem 4.11 — `kafi-aidlc-onboarding` skill (3 modes: setup wizard, stage detection from 00-knowledge/, resume verification).
- **Documentation** — `docs/ai-dlc-pain-points-2026-05.md` brainstorm doc with 21 findings.
- **Removed** "Adapted from AWS AI-DLC + Toan Huynh playbook" attribution from package banners.

---

## Hard rules

**1 · Parity rule.** Every change to one edition must apply to the other in the same PR. The Claude Code edition uses no front-matter; the Kiro edition uses YAML `inclusion: always|manual`. Content stays in sync. See `CONTRIBUTING.md`.

**2 · Single version, both editions.** `v0.8` ships both zips. No `v0.8-claude-code` vs `v0.8-kiro` split. If a change applies to only one platform, that's a parity bug — open an issue first.

**3 · KAFI design system v2.2 for any visual output.** Inter font · kafi-green `#00C694` sole accent · border-only cards 18px radius · max 3 text shades (`#101820` / `#585667` / `#9095A0`). HTML docs in `docs/` follow this strictly.

**4 · CHANGELOG is the source of truth for the backlog.** `## [Unreleased]` section in `CHANGELOG.md` lists what's planned. Update it as part of every PR.

---

## v0.9 backlog (prioritized)

From `CHANGELOG.md` `## [Unreleased]`. v0.8 shipped the mega release (layouts + code-flow + flow conformance + 14 skills + 13 templates + Operations). Remaining items carry over.

### Stream A · Carry-over (originally planned v0.4 → … → now v0.9)

| # | Item | Rough size | Notes |
|---|---|---|---|
| A1 | **Test artifacts** | — | **Shipped v0.7 ✓** (templates test-plan + test-cases; stages 10b, 14b, 14c; QA role) |
| A2 | **Compliance verification** | 1 week | Pre-deploy stage gating on extensions (audit-trail, PDPA, project-defined) |
| A3 | **Operations expansion** | — | **Shipped v0.8 ✓** (Stage 16/17 formalized · deployment-runbook + monitoring-runbook + postmortem) |
| A4 | **Project extension YAML examples** | 1 week | Worked examples for `architecture-boundaries`, `naming-conventions`, `phase-discipline` |
| A5 | **CI parity check upgrade** | 3 days | Semantic diff (currently word-count drift only) |

### Stream B · Brainstorm doc triage (`docs/ai-dlc-pain-points-2026-05.md`)

| # | Item | Problem # | Rough size |
|---|---|---|---|
| B1 | `phase-delivery` extension (replaces missing `phase-discipline` manifest) | 2 + 4.1 | 5-7 days |
| B2 | Per-phase `aidlc-docs/` folder schema | 2.3 + 4.4 | 2 days |
| B3 | MVP exit ramp (3-option Stage 14 gate) | 2.4 | 1 day |
| B4 | Loop-back S17 → S4 protocol | 2 | 1-2 days |
| B5 | `kafi-git-stage-flow` skill (highest-impact git friction reducer) | 3 | 1.5 days |
| B6 | Sentinel + CI hook for CLAUDE.md/AGENTS.md (Problem 4.12 Option C) | 4.12 | 1 hour |
| B7 | Audit log rotation | 4.2 | 0.5 day |
| B8 | Open-items aggregator skill | 4.3 | 1 day |
| B9 | AI review hard-gate for risk-flagged stages | 4.5 | 0.5 day |
| B10 | Designer-BA review pattern | 4.8 | 0.5 day |
| B11 | 2-part stage decision rule | 4.9 | 0.5 day |
| B12 | Retrospective stage (Stage 18 or extension) | 4.10 | 1 day |

### Stream C · PRD follow-ups (from v0.5)

| # | Item | Rough size | Notes |
|---|---|---|---|
| C1 | Standalone `epic.md` template | — | **Template shipped v0.8 ✓** (`epic.md`). Dedicated Epic *stage* still optional/deferred. |
| C2 | PRD-NN → REQ-NN traceability checker | 2 days | CI lint catching REQs without parent PRD-NN |
| C3 | BRD template | 1 week | Sibling to PRD when stakeholder approval needs business case detail |

### Stream D · Mockup/FE-fidelity follow-ups (from v0.6)

| # | Item | Rough size | Notes |
|---|---|---|---|
| D1 | Visual-diff tooling (screenshot mockup vs rendered FE) | 3-5 days | Automate the screen-by-screen fidelity check now done manually |
| D2 | Mockup → component scaffold mode (literal HTML reuse) | 2 days | Opt-in alternative to visual+structural contract for web stacks |

Pick one to start. Recommended order: B6 (1-hour safety win), A2 (compliance verification), then triage rest with BTS. Note: many v0.9 candidates also include per-language reviewers beyond the v0.8 ten, `kafi-memory` auto-skill-creation, and the parked Change-Request (CR) protocol.

---

## How to do work

### Add a rule
1. Drop file in **both** `packages/claude-code/aidlc-rule-details/<folder>/` and `packages/kiro/.kiro/steering/<folder>/`
2. Kiro version: prepend YAML front-matter — `inclusion: always|manual` + `description: "..."`
3. Update the relevant section in `docs/KAFI-AIDLC-Handbook.html` (unified doc) with edition callouts where paths differ
4. Append entry to `CHANGELOG.md` under `## [Unreleased]`

### Add a role
1. Both `packages/claude-code/.claude/skills/kafi/roles/<role>.md` and `packages/kiro/.kiro/steering/roles/<role>.md` (Kiro: `inclusion: manual`)
2. Add new prompt template at `packages/claude-code/.claude/skills/kafi/onboarding/prompts/<role>-stage-X.md` AND mirror at `packages/kiro/.kiro/steering/kafi-aidlc-onboarding-prompts/<role>-stage-X.md`. Update Stage→Role→Prompt mapping table in onboarding SKILL.md / steering file.
3. Row in Roles section of `docs/KAFI-AIDLC-Handbook.html` (skills table with both edition path columns)

### Add a template
1. Both `packages/claude-code/aidlc-rule-details/templates/<name>.md` and `packages/kiro/.kiro/templates/<name>.md`
2. No front-matter needed (templates are reference docs)
3. Reference from Templates section of `docs/KAFI-AIDLC-Handbook.html` (mention both edition paths inline)

### Build releases locally
```bash
./tools/build-releases.sh v0.7-dev
# Output → releases/v0.7-dev/
# Verify content before tagging real release
```

### Cut a release
```bash
# After merging develop → main via "Release v0.7" PR
git tag v0.7
git push --tags
# GitHub Actions builds zips + creates GitHub Release automatically
```

---

## Recent decisions · don't relitigate

| Decision | Rationale |
|---|---|
| Apache 2.0 license | Permissive · matches AWS AI-DLC upstream · safe for KAFI commercial use |
| Both editions in one repo | Content parity is enforceable; separate repos drift |
| Single version per release | Parity rule needs single source of truth |
| `AGENTS.md` for Kiro (not `KIRO.md`) | Universal agents.md spec — survives tool switches |
| No CI parity check beyond word-count yet | Phase 2 work · v0.5 item (carry-over from v0.4 plan) |
| Root `CLAUDE.md` as dev context primer | Auto-loaded for productivity · clearly distinguished from `packages/claude-code/CLAUDE.md` which ships to end-users |
| KAFI design system v2.2 | v3 not specced; stay v2.2 until BTS confirms |
| Brainstorm doc captured (no package changes) | `docs/ai-dlc-pain-points-2026-05.md` lists 21 findings across 4 clusters; needs BTS triage before any workflow change; avoids premature implementation |
| v0.4 scope refocused — workflow correctness, not new stages | Original v0.4 plan (5 items) deferred to v0.5; v0.4 instead shipped fixes for state drift / ownership ambiguity / templates drift + onboarding skill. Driven by pain-points brainstorm findings, not external request. |
| `/init` framing softened in skill + READMEs | Per verified Claude Code behavior: `/init` on existing `CLAUDE.md` is complementary (suggests diff, not destructive). Skill explains why `/init` is redundant on AI-DLC projects without alarmist language. |
| "Adapted from AWS AI-DLC + Toan Huynh playbook" removed from package banners | Banner concision. Attribution kept in `README.md` and Handbook docs. |
| Cross-platform installer added (`tools/install.sh` + `tools/install.ps1`) | Replaces manual `cp -r` + git-add steps. Auto-detects install vs upgrade, manages legacy files via `00-knowledge/references/`, downloads from GitHub Releases. Built in v0.4 cycle but only first tagged in v0.5. |
| Onboarding skill expanded with prompt templates (Approach E) | 6 per-role starter prompts moved from Introduction/Handbook docs into `.claude/skills/kafi/onboarding/prompts/` (and Kiro equivalent). Skill becomes single entry point — `Run #kafi-aidlc-onboarding` → agent picks right template per detected stage. Docs trimmed ~228 + 175 lines per edition. Quality preserved: templates are verbatim from prior prompts, not agent-inferred. |
| **PRD formalized as Stage 4 co-deliverable with Requirements (v0.5)** | PRD ≠ Requirements. PRD = product narrative (PRD-NN, *WHAT/FOR WHOM*). Requirements = technical decomposition (REQ-NN, *HOW BEHAVE*). Stage 4 produces both, each REQ cites parent PRD-NN. Adaptive depth allows skipping PRD at Minimal complexity. Closes the long-standing "Pending templates" gap on `prd.md`. |
| **HTML mockups are FE source of truth; Stage 14 enforces screen-by-screen fidelity (v0.6)** | Stage 7 outputs self-contained HTML mockups (design-system skill) in `product-design/mockups/`. Stage 14 reproduces them in the target framework — visual + structural contract, framework-agnostic (NOT literal HTML reuse). Fidelity check is Request-Changes-blocking; UI with no mockup ⇒ STOP + open item back to Stage 7. Chosen over literal-scaffold mode (which is a deferred v0.8 opt-in, Stream D2). |
| **Spec-driven, test-verified · QA role + conformance audit (v0.7)** | Hybrid SDD direction locked: specs stay primary contract; tests + audit become executable verification. QA owns Stage 10b (test plan + test cases as documentation) + Stage 14c (4-sub-check blocking audit: code · token discipline · UI · test code coverage). Dev owns 14a (production) + 14b (unit test code). **Test execution explicitly out of AI-DLC scope** — project's CI/local choice. 6 new templates (design-tokens, uiux-spec, view-model, data-model, test-plan, test-cases, dod). Process cycle gains step 5.5 spec trace-back; AI Review Checklist split Hard/Soft. |
| **Design tokens at project level (v0.7)** | `design-tokens.md` ships as a Stage 7 deliverable (FIRST output, before mockups). Inherits from KAFI design-system skill + declares overrides. Stage 14c audits FE code uses ONLY declared tokens — regex scan rejects ad-hoc hex/px/font literals. Closes the "look & feel adherence" gap separate from functional fidelity. |
| **MVVM-style UI/UX spec triangle (v0.7)** | Each screen has 3 contracts: Model (data-model.md ENT-NN) · View (mockup HTML) · View-Model (view-model.md field bindings + format + validation + computed). System narrative `uiux-spec.md` ties everything (sitemap, menus, screen catalog, coverage matrix). |

---

## What's NOT in this repo (explicitly out of scope)

- **Local LLM deployment plan** — separate KSB workstream · lives outside this repo
- **KOS-MO architecture, TRS BRDs, product specs** — separate KAFI product repos
- **Project-specific knowledge bases** — each project owns its `00-knowledge/`
- **AI model weights or configs** — bring-your-own (Claude / Kiro / local LLM)
- **Test fixtures or example projects** — could be added under `examples/` in v0.5+

---

## Suggested first prompts

**Start a v0.5 backlog item:**
> Read `SESSION_HANDOFF.md`. I want to tackle item A1 (test artifacts). Propose the file plan honoring the parity rule, then wait for my approval before writing.

**Audit current state:**
> Read `SESSION_HANDOFF.md`. Run a content parity check between `packages/claude-code/` and `packages/kiro/`. Report any drift — files in one but not the other, content divergence beyond YAML front-matter, etc.

**Quick rule fix:**
> Read `SESSION_HANDOFF.md`. The rule in `packages/claude-code/aidlc-rule-details/inception/requirements-analysis.md` says X — update to Y, mirror to Kiro, update Handbook docs, add CHANGELOG entry.

**Onboard another contributor:**
> Read `SESSION_HANDOFF.md` and `CONTRIBUTING.md`. Summarize for someone joining this repo for the first time — what should they read and in what order?

---

## File references

| File | Why you'd read it |
|---|---|
| `README.md` | Public-facing entry · explains what AI-DLC is |
| `CONTRIBUTING.md` | Parity rule details · release process · style |
| `CHANGELOG.md` | Version history · current Unreleased backlog |
| `docs/KAFI-AIDLC-Handbook.html` | Per-stage reference · use to understand the workflow |
| `docs/KAFI-AIDLC-Handbook.html` | Same content, Kiro framing · use to understand inclusion modes |
| `tools/build-releases.sh` | Build automation · run to test locally |
| `.github/PULL_REQUEST_TEMPLATE.md` | What reviewers check on every PR |

---

## How to update this file

When you finish a meaningful chunk of work, update sections that drifted:

- Move completed items out of "v0.5 backlog" → add a `## Recently completed` section, or just note in CHANGELOG
- Add new decisions to "Recent decisions" if any were locked
- Update "Where we are" if version changed

Keep it under ~250 lines. If it grows, that's a signal to split into multiple session-state files or archive old context.

---

*Last updated: 29 May 2026 · v0.8 ship — mega release · ASCII+Mermaid layouts · code-flow + flow conformance · 14 skills · 13 templates · Operations formalized · HTML deep-sync + What's-New page*
