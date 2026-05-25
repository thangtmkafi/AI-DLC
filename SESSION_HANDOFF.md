# Session Handoff · KAFI AI-DLC

> **Drop this file at repo root.** When opening this repo in Claude Code, your first prompt should be:
> *"Read `SESSION_HANDOFF.md` and propose what to tackle next from the v0.5 backlog."*

---

## Where we are

This is the **KAFI AI-DLC methodology repo** — it contains the workflow rules, role guides, templates, and two IDE editions (Claude Code + Kiro). It is **not** a KAFI product repo.

**Important meta point.** There are **two `CLAUDE.md` files** in this repo and they serve different purposes:

- **`/CLAUDE.md`** (repo root · auto-loaded) — Development context for working ON this repo. Tells Claude Code about the parity rule, file map, style expectations. Read `SESSION_HANDOFF.md` next for current state.
- **`/packages/claude-code/CLAUDE.md`** — The AI-DLC workflow content shipped to end-users. Has parity with `/packages/kiro/AGENTS.md`. Edit only as part of a v0.X release.

Don't conflate the two. Editing the root one shapes how this repo is developed; editing the package one ships to every KAFI project using AI-DLC.

**Current state:** v0.4 shipped 25 May 2026. Two editions, content parity verified.

- **Claude Code Edition** — `packages/claude-code/` · `CLAUDE.md` + `.claude/skills/` + `aidlc-rule-details/`
- **Kiro Edition** — `packages/kiro/` · `AGENTS.md` + `.kiro/steering/` with YAML inclusion modes

Both ship as zip files in `releases/v0.4/`. GitHub Actions auto-builds new zips on tag push.

### v0.4 changes (shipped 2026-05-25)

Driven by `docs/ai-dlc-pain-points-2026-05.md` triage — focused on workflow correctness, not new stages.

- **Fixed** · Problem 1 — `aidlc-state.md` drift: stage cycle now 10 steps with step 9 = "update state file". State file maintenance rules added for all status transitions.
- **Fixed** · Problem 4.7 — CLAUDE.md templates list reconciled with disk reality (was claiming 7 phantom templates).
- **Changed** · Problem 4.6 — Stage 4 ownership PM+BA → PM (sole). Stage 10 ownership BA+SA → SA (sole). BA scope narrowed to Stage 5 + Pre-Inception.
- **Added** · Problem 4.11 — `kafi-aidlc-onboarding` skill (3 modes: setup wizard, stage detection from 00-knowledge/, resume verification). 16-row stage detection rubric.
- **Documentation** — `docs/ai-dlc-pain-points-2026-05.md` brainstorm doc with 21 findings as input to v0.5 triage.
- **Removed** "Adapted from AWS AI-DLC + Toan Huynh playbook" attribution from `CLAUDE.md` / `AGENTS.md` banners (kept in README + Handbook).

---

## Hard rules

**1 · Parity rule.** Every change to one edition must apply to the other in the same PR. The Claude Code edition uses no front-matter; the Kiro edition uses YAML `inclusion: always|manual`. Content stays in sync. See `CONTRIBUTING.md`.

**2 · Single version, both editions.** `v0.5` ships both zips. No `v0.5-claude-code` vs `v0.5-kiro` split. If a change applies to only one platform, that's a parity bug — open an issue first.

**3 · KAFI design system v2.2 for any visual output.** Inter font · kafi-green `#00C694` sole accent · border-only cards 18px radius · max 3 text shades (`#101820` / `#585667` / `#9095A0`). HTML docs in `docs/` follow this strictly.

**4 · CHANGELOG is the source of truth for the backlog.** `## [Unreleased]` section in `CHANGELOG.md` lists what's planned. Update it as part of every PR.

---

## v0.5 backlog (prioritized)

From `CHANGELOG.md` `## [Unreleased]`. Two streams: carry-over from original v0.4 plan + brainstorm doc items.

### Stream A · Carry-over (originally planned v0.4)

| # | Item | Rough size | Notes |
|---|---|---|---|
| A1 | **Test artifacts** | 1-2 weeks | New stage between Construction and Operations · template + role guide. Most-asked-for in KAFI feedback. |
| A2 | **Compliance verification** | 1 week | Pre-deploy stage gating on extensions (audit-trail, PDPA, project-defined) |
| A3 | **Operations expansion** | 2 weeks | Replace stage 16-17 placeholders with concrete deploy + monitor specs |
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

Pick one to start. Recommended order: A1 (test artifacts is sales-blocker), B6 (1-hour safety win), then triage A2-A5 vs B1-B5 with BTS.

---

## How to do work

### Add a rule
1. Drop file in **both** `packages/claude-code/aidlc-rule-details/<folder>/` and `packages/kiro/.kiro/steering/<folder>/`
2. Kiro version: prepend YAML front-matter — `inclusion: always|manual` + `description: "..."`
3. Update the relevant section in both `docs/KAFI-AIDLC-Handbook-Claude.html` and `docs/KAFI-AIDLC-Handbook-Kiro.html`
4. Append entry to `CHANGELOG.md` under `## [Unreleased]`

### Add a role
1. Both `packages/claude-code/.claude/skills/kafi/roles/<role>.md` and `packages/kiro/.kiro/steering/roles/<role>.md` (Kiro: `inclusion: manual`)
2. Starter prompt in both `docs/KAFI-AIDLC-Introduction-*.html`
3. Row in Roles tables of both Handbook docs

### Add a template
1. Both `packages/claude-code/aidlc-rule-details/templates/<name>.md` and `packages/kiro/.kiro/templates/<name>.md`
2. No front-matter needed (templates are reference docs)
3. Reference from Templates section of both Handbook docs

### Build releases locally
```bash
./tools/build-releases.sh v0.5-dev
# Output → releases/v0.5-dev/
# Verify content before tagging real release
```

### Cut a release
```bash
# After merging develop → main via "Release v0.5" PR
git tag v0.5
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
| `docs/KAFI-AIDLC-Handbook-Claude.html` | Per-stage reference · use to understand the workflow |
| `docs/KAFI-AIDLC-Handbook-Kiro.html` | Same content, Kiro framing · use to understand inclusion modes |
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

*Last updated: 25 May 2026 · v0.4 ship + brainstorm-driven correctness fixes*
