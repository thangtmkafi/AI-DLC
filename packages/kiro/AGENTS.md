# KAFI AI-DLC Workflow

**v0.8.1 · KAFI Transformation Office · Kiro IDE port**

> This file is the agent context for this KAFI project. It defines the AI-Driven Development Lifecycle. When the user requests development work, follow this workflow FIRST. Kiro reads this file alongside the `.kiro/steering/` library.

---

## Two Modes (Auto-Detected)

```mermaid
flowchart LR
    W[Workspace Detection] --> Q{Inputs ready?<br/>Existing code?}
    Q -->|Vision ready<br/>No code| L[Lite mode]
    Q -->|Missing inputs<br/>OR existing code| S[Standard mode]
    L --> I[Inception]
    S --> P[Pre-Inception] --> I
```

| | Lite | Standard |
|---|---|---|
| When | Greenfield + clean Vision | Brownfield OR needs input prep |
| Pre-Inception | skipped | runs |
| Reverse Engineering | skipped | runs (brownfield only) |

User can override mode at any time.

---

## Phase Map

```mermaid
flowchart TB
    PI[🟦 PRE-INCEPTION<br/>Standard mode only<br/>Sub-flows A/B/C/D] --> IN[🟣 INCEPTION<br/>9 stages<br/>WHAT + WHY]
    IN --> CN[🟢 CONSTRUCTION<br/>6 stages<br/>HOW + BUILD]
    CN --> OP[🟠 OPERATIONS<br/>2 stages<br/>DEPLOY + MONITOR]
```

**Stage count:** 17 (+ Pre-Inception sub-flow when Standard mode). **Always-on:** 6. **Conditional:** 9. **Placeholder:** 2.

---

## Source-of-Truth Hierarchy

1. **Project KB** — `00-knowledge/` — canonical architecture, glossary, open items, phases, conventions
2. **Vision + Tech Env** — `aidlc-docs/inception/discovery/` — what we're building, on what stack
3. **Product requirements** — `00-knowledge/product/` — BRD/PRD/business reqs
4. **Derived views** — scope, roadmap, presentations — must align to 1–3
5. **Working data** — plans, samples, research

**Rule:** if a user statement contradicts the KB, surface the conflict. Never silently override.

---

## MANDATORY Loading

At workflow start, Kiro auto-loads all `inclusion: always` files from `.kiro/steering/`. These are:

| What | From | Loaded |
|---|---|---|
| Common AI-DLC rules | `.kiro/steering/common/*.md` | Always (6 files) |
| KAFI design system | `.kiro/steering/kafi-design-system.md` | Always |
| Audit-trail extension | `.kiro/steering/extensions/audit-trail/audit-trail.md` | Always (KAFI-wide) |
| KB context | `00-knowledge/` per `context-pins.md` | Always |

**Manual-load files** (use `#filename` in Kiro chat to load when needed):
- Role guides — `.kiro/steering/roles/{pm,ba,sa,designer,dev,devops}.md`
- Stage rules — `.kiro/steering/{pre-inception,inception,construction,operations}/*.md`
- Opt-in extensions — `.kiro/steering/extensions/personal-data-privacy/*.md`
- Onboarding skill — `.kiro/steering/kafi-aidlc-onboarding.md` (load on first session, when asked "where am I", or before `/init`)

**Extensions:**

| Extension | Category | Status | Trigger |
|---|---|---|---|
| `audit-trail` | KAFI-wide | Always enforced | Any operational system |
| `personal-data-privacy` | KAFI-wide | Opt-in | Auto on PII detected |
| `architecture-boundaries` | Project | Always if defined | Project supplies YAML |
| `naming-conventions` | Project | Always if defined | Project supplies YAML |
| `phase-discipline` | Project | Always if defined | Project supplies YAML |
| `open-items-protocol` | Project | Always if defined | Project supplies register |

---

## 🟦 PRE-INCEPTION (Standard mode only)

```mermaid
flowchart LR
    Q[Routing question] --> A[Sub-flow A: skip]
    Q --> B[Sub-flow B: fill-gaps]
    Q --> C[Sub-flow C: map-existing]
    Q --> D[Sub-flow D: author-from-brief]
    A --> Z[→ Inception]
    B --> Z
    C --> Z
    D --> Z
```

**Routing question** (one multi-choice question, answer with `[Answer]:` tag):

```
A) skip                — Vision + Tech Env ready; proceed
B) fill-gaps           — have one, need the other
C) map-existing        — have legacy BRD/PRD, need to validate + map
D) author-from-brief   — have only intent/brief, need to author
```

Plus two utilities:
- **Entry Router** — `.kiro/steering/pre-inception/entry-router.md` — 3 questions if intent unclear
- **Document Validator** — `.kiro/steering/pre-inception/document-validator.md` — consent-first classifier

See `.kiro/steering/pre-inception/*.md` for sub-flow details. Load with `#subflow-fill-gaps` (etc.) in Kiro chat.

---

## 🟣 INCEPTION (9 stages)

```mermaid
flowchart TB
    S1[1. Workspace Detection<br/>always · AI agent] --> S2[2. KB Context Loading<br/>always · AI agent]
    S2 --> S3[3. Reverse Engineering<br/>conditional · SA]
    S3 --> S4[4. Requirements Analysis<br/>always · PM]
    S4 --> S5[5. User Stories<br/>conditional · BA]
    S5 --> S6[6. Workflow Planning<br/>always · PM]
    S6 --> S7[7. Product Design<br/>conditional · Designer]
    S7 --> S8[8. Application Design<br/>conditional · SA]
    S8 --> S9[9. Units Generation<br/>conditional · SA]
```

Each stage: load `.kiro/steering/inception/<stage>.md` via `#filename`, execute, append `audit.md`, present completion with 2-option gate ("Request Changes" / "Continue").

---

## 🟢 CONSTRUCTION (6 stages 10–15 — per-unit loop, then build · Stage 14 splits into 14a/14b/14c, plus conditional 10b) · v0.7+v0.8

```mermaid
flowchart TB
    L[Per-unit loop] --> S10[10. Functional Design<br/>conditional · SA]
    S10 --> S10b[10b. Unit Test Planning<br/>conditional · QA · NEW v0.7]
    S10b --> S11[11. NFR Requirements<br/>conditional · SA]
    S11 --> S12[12. NFR Design<br/>conditional · SA]
    S12 --> S13[13. Infrastructure Design<br/>conditional · DevOps]
    S13 --> S14a[14a. Production Code<br/>always · Dev]
    S14a --> S14b[14b. Unit Test Code<br/>always · Dev · NEW v0.7]
    S14b --> S14c[14c. Conformance Audit<br/>always · QA · NEW v0.7 · BLOCKING]
    S14c --> N{More units?}
    N -->|Yes| S10
    N -->|No| S15[15. Build<br/>always · Dev]
```

**NFR = Non-Functional Requirements** (performance, scalability, availability, security, observability, accessibility).

**v0.7+v0.8 conformance model:** Stage 14 split into 14a/14b/14c — Dev produces production code + test code; QA audits **5 sub-checks** (code · token discipline · UI fidelity · test code coverage · **flow conformance**) as the **blocking** gate before the unit advances. Flow conformance (v0.8) verifies code call paths match the Mermaid sequences in `user-flows.md` (Stage 7) + `code-flow.md` (Stage 10). Test execution remains the project's CI/local choice (outside AI-DLC).

---

## 🟠 OPERATIONS (v0.8 formalized)

```mermaid
flowchart LR
    S15[Build complete] --> S16[16. Deployment<br/>DevOps · deployment-runbook.md]
    S16 --> S17[17. Monitoring<br/>DevOps + SRE · monitoring-runbook.md]
```

Stage 16 produces `deployment-runbook.md` (prereqs · ordered steps · migrations · smoke verify · rollback). Stage 17 produces `monitoring-runbook.md` (SLIs/SLOs from NFR thresholds · dashboards · alerts · oncall playbooks · escalation) + `postmortem.md` after incidents. No longer placeholders.

---

## Roles

| Role | Drives | Steering file |
|---|---|---|
| PM (Product Owner) | Stages 4, 6 | `.kiro/steering/roles/pm.md` |
| BA (Business Analyst) | Stage 5 + Pre-Inception | `.kiro/steering/roles/ba.md` |
| SA (Solution Architect) | Stages 3, 8, 9, 10, 11, 12 | `.kiro/steering/roles/sa.md` |
| Designer (Product Designer) | Stage 7 | `.kiro/steering/roles/designer.md` + `.kiro/steering/kafi-design-system.md` |
| Dev (Developer) | Stages 14a, 14b, 15 | `.kiro/steering/roles/dev.md` |
| **QA (Quality Assurance)** | **Stages 10b, 14c (NEW v0.7)** | `.kiro/steering/roles/qa.md` |
| DevOps / SRE | Stages 13, 16, 17 | `.kiro/steering/roles/devops.md` |
| AI Agent | Every stage | — |

Manual role inclusion — load with `#pm`, `#ba`, etc. in Kiro chat when driving a stage. The **kafi-design-system** is auto-loaded (`inclusion: always`) and applies to every UI artifact. The **kafi-aidlc-onboarding** skill (`inclusion: manual`) loads via `#kafi-aidlc-onboarding` when the user just unzipped the package, asks where to start, mentions `/init`, or wants to scan `00-knowledge/` to determine current stage. Explains why `/init` is redundant on AI-DLC projects (AGENTS.md is already auto-loaded).

### Helper skills (v0.8)

Construction-phase helper steering files (`inclusion: manual` — load with `#<name>` when relevant):

- **kafi-doc-sync** — regenerate `aidlc-docs/` code summaries to match current `src/` (run before Stage 14c)
- **kafi-verification-loop** — one-pass build · typecheck · lint · tests · security; Dev runs before Stage 14c handoff
- **kafi-code-review** — router that dispatches per-file to a language reviewer; powers Stage 14c sub-check 1
  - language reviewers: **kafi-code-review-{typescript · python · go · java · kotlin · cpp · rust · csharp · database · shell}**
- **kafi-memory** — long-term learning; mines git history + postmortems for recurring patterns, surfaces candidate skills/ADRs/checklist-items (human-curated, read-only)

---

## Templates

KAFI standard at `.kiro/templates/` · Project overrides at `00-knowledge/templates/`.

Available templates (32):
`brief.md` · `vision.md` · `technical-environment.md` · `glossary.md` · `personas.md` · `risk-register.md` · `prd.md` · `epic.md` · `requirements.md` · `user-story.md` · `story-map.md` · `application-design.md` · `data-model.md` · `api-spec.md` · `components.md` · `unit-of-work.md` · `functional-design.md` · `code-flow.md` · `design-tokens.md` · `uiux-spec.md` · `view-model.md` · `design-lite.md` · `test-plan.md` · `test-cases.md` · `dod.md` · `nfr-requirements.md` · `nfr-design.md` · `adr.md` · `deployment-runbook.md` · `monitoring-runbook.md` · `release-notes.md` · `postmortem.md`

**Traceability:** `Intent → Brief → Vision → [BRD] → PRD → REQ → ENT → Epic → Story → Unit → TC → ADR` · IDs: `PRD-NN · REQ-NN · ENT-NN · EPIC-NN · US-NN · UNIT-NN · TC-NN · ADR-NN`

> **PRD vs Requirements:** PRD answers *WHAT* and *FOR WHOM* (product narrative, feature-level, PM-owned). `requirements.md` answers *HOW THE SYSTEM MUST BEHAVE* (testable functional + NFR, derived from PRD-NN). Both produced at Stage 4. See `.kiro/templates/prd.md`.

> **v0.7 templates:** `design-tokens.md` · `uiux-spec.md` · `view-model.md` · `data-model.md` · `test-plan.md` · `test-cases.md` · `dod.md`.
> **v0.8 templates (new):** `code-flow.md` (per-unit Mermaid call sequences) · `glossary.md` (bilingual terms) · `api-spec.md` (REST/GraphQL contracts) · `deployment-runbook.md` (Stage 16) · `monitoring-runbook.md` (Stage 17) · `brief.md` (pre-Vision) · `release-notes.md` · `postmortem.md` · `epic.md` · `personas.md` · `risk-register.md` · `design-lite.md` · `story-map.md`.

> **No pending templates** — all previously-pending scaffolds shipped in v0.8.

---

## Kiro Spec Mode (Native)

Kiro's native spec-driven development sits alongside AI-DLC. Use it for **feature-scoped** deliverables that benefit from explicit requirements/design/tasks artifacts:

```
.kiro/specs/<feature-name>/
├── spec.json           # metadata
├── requirements.md     # what + why + acceptance criteria
├── design.md           # technical approach
└── tasks.md            # checkboxed delivery plan
```

A blank template lives at `.kiro/specs/_template/`. Copy and rename when starting a feature.

AI-DLC's Inception phase outputs (Vision, Requirements, User Stories) populate `requirements.md`. Construction outputs populate `design.md` and `tasks.md`. The two modes are complementary, not competing.

---

## AI Review Checklist (Soft Enforcement)

Before any meaningful write, agent self-checks against `.kiro/steering/common/ai-review-checklist.md`. Warnings reported in completion summary — user decides.

**Critical:** Grounded · No secrets · Scope respected · Reversible · Human-decidable
**Risk-shaped:** Auth/money/PII/external/IaC → flag for dual review

---

## Key Principles

- **Adaptive:** only execute stages that add value
- **Transparent:** show plan before starting
- **User control:** stage inclusion/exclusion/override
- **KB precedence:** project KB beats every other source
- **Open items discipline:** never fabricate; emit `Open — pending [owner]`
- **Compliance non-negotiable:** KAFI-wide extensions are not optional
- **Audit trail:** every input + response, ISO 8601, complete raw, append-only
- **Standardized completion:** 2-option only ("Request Changes" / "Continue")

---

## Folder Structure

```
project-root/
├── AGENTS.md                          # this file (Kiro auto-reads)
├── README.md                          # setup instructions
├── .kiro/
│   ├── settings/
│   │   └── config.json                # Kiro permissions + tool config
│   ├── steering/                      # AI rules (auto-loaded per inclusion mode)
│   │   ├── kafi-design-system.md      # always
│   │   ├── common/                    # always (6 files)
│   │   ├── roles/                     # manual (7 roles)
│   │   ├── pre-inception/             # manual (sub-flows A/B/C/D)
│   │   ├── inception/                 # manual (9 stages)
│   │   ├── construction/              # manual (6 stages)
│   │   ├── operations/                # manual (2 stages)
│   │   └── extensions/                # mix (audit-trail always; PDPA manual)
│   ├── specs/                         # Kiro native specs (per-feature)
│   │   └── _template/                 # blank spec template
│   └── templates/                     # AI-DLC artifact templates (32 files)
├── 00-knowledge/                      # project KB + conventions
├── aidlc-docs/                        # generated artifacts
├── adrs/                              # Architecture Decision Records
└── src/                               # application code
```

**Rules:**
- Application code: `src/` (NEVER inside `aidlc-docs/`)
- Documentation: `aidlc-docs/` only
- KB: `00-knowledge/` (read-only during workflow)
- ADRs: separate `adrs/` directory

---

## Audit Log Format

```markdown
## [Stage]
**Timestamp:** [ISO 8601]
**User Input:** "[Complete raw input]"
**AI Response:** "[Action taken]"
**Context:** [Stage, decision]
**KB Citations:** [list]
**Open Items:** [list]
**Extensions:** [compliance summary]
**AI Review:** [pass/warnings]
---
```

**Append-only. Never overwrite.**

---

*Companion handbook: `KAFI-AIDLC-Handbook.html` · v0.8.1 Kiro Port · Transformation Office, Kafi Securities*
