# KAFI AI-DLC

> **AI-Driven Development Lifecycle for KAFI Securities.** A drop-in methodology package that turns Claude Code or Kiro IDE into a discipline-enforcing engineering partner. **The AI plans and executes; humans drive and approve.** You mostly just talk to the agent — it already knows the AI-DLC rules for the version you installed, and guides you stage by stage.

[![Version](https://img.shields.io/badge/version-0.9-00C694)](CHANGELOG.md)
[![Editions](https://img.shields.io/badge/editions-Claude_Code_·_Kiro-101820)](#install-first)
[![License](https://img.shields.io/badge/license-Apache_2.0-585667)](LICENSE)

**Docs:** [Introduction](https://thangtmkafi.github.io/AI-DLC/KAFI-AIDLC-Introduction.html) · [Handbook](https://thangtmkafi.github.io/AI-DLC/KAFI-AIDLC-Handbook.html) · [What's New](https://thangtmkafi.github.io/AI-DLC/KAFI-AIDLC-Whats-New.html) · [Installer Guide](https://thangtmkafi.github.io/AI-DLC/KAFI-Installer-Guide.html) · [Git Guide (non-dev)](https://thangtmkafi.github.io/AI-DLC/KAFI-Git-Guide-NonDev.html)

---

## What AI-DLC is

A **methodology layer** — workflow rules + role guides + templates — that an AI agent follows. It is **not** product code; it's the discipline the agent applies while doing the work. Adapted from AWS AI-DLC, hardened for KAFI (compliance, bilingual VN/EN, append-only audit trail).

**Four pillars**
1. **Spec-driven, FE + BE** — every artifact derives from an upstream spec. BE from `data-model` (ENT-NN); FE from `design-tokens` + `uiux-spec` + `view-model` (MVVM).
2. **Docs kept current** — specs live as `.md` next to code; a doc-sync discipline keeps them in step; an audit gate checks doc-currency.
3. **Audit & verifiable at each gate** — spec-conformance trace-back + Hard/Soft review checklist + a blocking conformance audit per unit (Stage 14c).
4. **Spec-driven, test-verified** — QA writes test plan + cases; Dev generates test code; the audit checks coverage. Tests are the executable spec.

**Shape:** 17-stage adaptive lifecycle across **Pre-Inception → Inception → Construction → Operations** · **2 modes** (Lite for greenfield+clean vision, Standard for brownfield/needs-prep) · **2 editions** in parity (Claude Code, Kiro) · **7 roles** + the AI agent.

---

## Install first

One command in your project folder. The installer auto-detects fresh install vs upgrade, downloads the latest release, and (on a non-empty folder) tucks existing files into `00-knowledge/references/`. Your work dirs (`00-knowledge/`, `aidlc-docs/`, `src/`, `adrs/`, `ai-dlc/`) are never touched on upgrade.

**macOS / Linux**
```bash
curl -fsSL https://raw.githubusercontent.com/thangtmkafi/AI-DLC/main/tools/install.sh | bash
```

**Windows (PowerShell)**
```powershell
iwr -useb https://raw.githubusercontent.com/thangtmkafi/AI-DLC/main/tools/install.ps1 -OutFile install.ps1; .\install.ps1
```

Pick your edition when prompted (or `--edition=claude-code|kiro`). What lands in your project:

| Edition | Root file | Rules & skills the agent loads |
|---|---|---|
| **Claude Code** | `CLAUDE.md` (auto-read every session) | `.claude/skills/` + `aidlc-rule-details/` |
| **Kiro IDE** | `AGENTS.md` (auto-loaded) | `.kiro/steering/` (+ native specs) |

> **Don't run `/init`.** The workflow spec is already in `CLAUDE.md` / `AGENTS.md` and auto-loads on every session — the agent knows AI-DLC the moment you open the project. Pin to a version with `--version=v0.9` (the installer accepts `vX.Y` and `vX.Y.Z`).

---

## Then just talk to the agent

After install you work **by prompt**. Open the project in your IDE and run the onboarding skill — the agent scaffolds the project, figures out where you are, loads the right role, and walks you through.

**Claude Code:** `Run #kafi-aidlc-onboarding`  **·  Kiro:** `#kafi-aidlc-onboarding`  (or just describe what you want to build.)

The onboarding skill (3 modes — auto-detected):
- **Setup** — fresh project: creates the skeleton below + `ai-dlc/project.md`, orients `00-knowledge/`.
- **Detect** — legacy files in `00-knowledge/`: classifies your position across the 17 stages, loads the matching role + prompt.
- **Resume** — `aidlc-docs/aidlc-state.md` exists: reconciles state and continues.

### The project skeleton (the agent creates this — you don't)

```
your-project/
├── CLAUDE.md / AGENTS.md     ← installed · the AI-DLC rules the agent obeys
├── ai-dlc/project.md         ← project metadata (created at setup)
├── 00-knowledge/             ← your inputs: BRDs, PRDs, architecture, conventions, glossary
├── aidlc-docs/               ← artifacts the agent produces (specs, audit, state)
├── adrs/                     ← Architecture Decision Records
└── src/                      ← application code
```

You feed `00-knowledge/`; the agent writes `aidlc-docs/` and `src/`. Every stage closes with a standardized **2-option gate**: *Request Changes* or *Continue*.

---

## Cheatsheet

### The 17 stages

| Phase | # | Stage | Owner | Key output |
|---|---|---|---|---|
| 🟣 Inception | 1–2 | Workspace Detection · KB Loading | AI | `aidlc-state.md` · context |
| | 3 | Reverse Engineering *(brownfield)* | SA | `reverse-engineering/` |
| | 4 | Requirements Analysis | PM | `prd.md` · `requirements.md` |
| | 5 | User Stories *(+ conceptual design, opt)* | BA | `stories.md` · `personas.md` |
| | 6 | Workflow Planning | PM | `execution-plan.md` |
| | 7 | Product Design | Designer | mockups · `design-tokens` · `uiux-spec` · `view-model` · `user-flows` |
| | 8 | Application Design | SA | `application-design` · `data-model` (ENT) · `api-spec` · ADRs |
| | 9 | Units Generation | SA | `unit-of-work` + dependency matrix |
| 🟢 Construction *(per unit)* | 10 / 10b | Functional Design / Unit Test Planning | SA / QA | `functional-design` · `code-flow` / `test-plan` · `test-cases` |
| | 11–12 | NFR Requirements / Design | SA | `nfr-requirements` · `nfr-design` |
| | 13 | Infrastructure Design | DevOps | `infrastructure-design/` |
| | 14a / 14b | Production Code / Unit Test Code | Dev | `src/` · `src/*.test.*` |
| | 14c | **Conformance Audit (BLOCKING)** | QA | `conformance-report.md` · 5 sub-checks |
| | 15 | Build | Dev | `build/` |
| 🟠 Operations | 16 / 17 | Deployment / Monitoring | DevOps | `deployment-runbook` / `monitoring-runbook` · `postmortem` |

**Stage 14c — 5 blocking sub-checks:** code audit · token discipline · UI fidelity (vs mockup) · test coverage · flow conformance.

### 7 roles → stages

`PM` 4·6 · `BA` 5 · `SA` 3·8·9·10·11·12 · `Designer` 7 · `Dev` 14a·14b·15 · `QA` 10b·14c · `DevOps` 13·16·17. Plus the **AI agent** at every stage. The onboarding skill loads the right role guide automatically for the stage you're in.

### Document templates (34 · grouped by phase, then owner)

```
templates/
├── 00-pre-inception/            brief · vision · technical-environment · glossary · personas · risk-register
├── 01-inception-requirements/   pm/ (prd · requirements)   ba/ (epic · user-story · story-map)
├── 02-inception-design/         ui-ux/ (design-tokens · uiux-spec · view-model · user-flows · mockup-index · design-lite)
│                                architecture/ (application-design · data-model · api-spec · components · unit-of-work)
├── 03-construction/             design/ (functional-design · code-flow · nfr-requirements · nfr-design · adr)
│                                test/ (test-plan · test-cases · dod)
└── 04-operations/               deployment-runbook · monitoring-runbook · release-notes · postmortem
```

### Helper skills (load automatically when relevant)

`kafi-design-system` (UI) · `kafi-doc-sync` · `kafi-verification-loop` (build·typecheck·lint·test·security) · `kafi-memory` (mine git history for patterns) · `kafi-code-review` router **+ 10 language reviewers** (TS · Python · Go · Java · Kotlin · C++ · Rust · C# · SQL · Shell).

### Traceability

`Intent → Brief → Vision → [BRD] → PRD → REQ → ENT → Epic → Story → Unit → TC → ADR` · IDs `PRD-NN · REQ-NN · ENT-NN · EPIC-NN · US-NN · UNIT-NN · TC-NN · ADR-NN`. A REQ with no parent PRD = scope creep → blocked at the gate.

### Gate model

**stage = branch · gate = PR · merge = approval.** Non-developers review on the PR web UI (see the [Git Guide for non-devs](https://thangtmkafi.github.io/AI-DLC/KAFI-Git-Guide-NonDev.html)).

---

## Upgrading from an older version

You **don't migrate documents** — re-run the installer; it backs up the package files, pulls the latest release, and preserves your `00-knowledge/` + `aidlc-docs/`. New stages, templates, and skills apply going forward. See [What's New](https://thangtmkafi.github.io/AI-DLC/KAFI-AIDLC-Whats-New.html).

---

## Switching editions (Claude ↔ Kiro)

Already on one edition and want the other? The installer's **convert mode** backs up your current edition's package files, installs the target edition at the latest version, and **preserves your work** — `00-knowledge/`, `aidlc-docs/`, `src/`, `adrs/`, `ai-dlc/` are edition-agnostic (both editions' rules reference the same paths).

**macOS / Linux**
```bash
# Claude Code → Kiro
curl -fsSL https://raw.githubusercontent.com/thangtmkafi/AI-DLC/main/tools/install.sh | bash -s -- --convert-to=kiro
# Kiro → Claude Code
curl -fsSL https://raw.githubusercontent.com/thangtmkafi/AI-DLC/main/tools/install.sh | bash -s -- --convert-to=claude-code
```

**Windows (PowerShell)**
```powershell
iwr -useb https://raw.githubusercontent.com/thangtmkafi/AI-DLC/main/tools/install.ps1 -OutFile install.ps1
.\install.ps1 -ConvertTo kiro            # or:  -ConvertTo claude-code
```

Add `--yes` (or `-Yes`) to skip the confirmation. The previous edition's files are backed up to `.aidlc-backup-*-from-<edition>/`. **Customizations are not auto-ported** — paths and front-matter differ (Claude rules carry none; Kiro steering files use YAML `inclusion`). If you edited any rule / role / skill files, diff them against the new edition's structure and port by hand. Your specs in `aidlc-docs/` and inputs in `00-knowledge/` carry over untouched, so the agent resumes from the same stage.

---

## For maintainers (this repo)

This repo (codename **KORA**) authors AI-DLC itself — it ships two editions in **parity**: every change touches both `packages/claude-code/` and `packages/kiro/` in the same PR. See [CONTRIBUTING.md](CONTRIBUTING.md), [CHANGELOG.md](CHANGELOG.md), and [SESSION_HANDOFF.md](SESSION_HANDOFF.md). Releases auto-build both zips on tag push (`.github/workflows/build-release.yml`); `tools/build-releases.sh` builds locally + runs the parity check.

```
packages/claude-code/   CLAUDE.md + .claude/skills/ + aidlc-rule-details/
packages/kiro/          AGENTS.md + .kiro/steering/ + .kiro/templates/
docs/                   5 rendered HTML docs (served via GitHub Pages)
tools/                  install.sh · install.ps1 · build-releases.sh
```
