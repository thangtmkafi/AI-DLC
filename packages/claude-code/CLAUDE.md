# KAFI AI-DLC Workflow

**v0.7 · KAFI Transformation Office**

> This file is Claude Code's project memory. It defines the AI-Driven Development Lifecycle for this KAFI project. When the user requests development work, follow this workflow FIRST.

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

At workflow start, load:

| What | From | When |
|---|---|---|
| Common rules | `aidlc-rule-details/common/*.md` | Always |
| Active extensions | `aidlc-rule-details/extensions/` | Per trigger |
| KB context | `00-knowledge/` per `context-pins.md` | Always |
| Welcome message | `common/welcome-message.md` | Once per session |

**Common rule files:**
- `process-overview.md` · `session-continuity.md` · `content-validation.md`
- `question-format-guide.md` · `ai-review-checklist.md`

**Extensions:**

| Extension | Category | Status | Trigger |
|---|---|---|---|
| `audit-trail` | KAFI-wide | Always enforced | Any operational system |
| `personal-data-privacy` | KAFI-wide | Opt-in | Auto on PII |
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
- **Entry Router** — `pre-inception/entry-router.md` — 3 questions if intent unclear
- **Document Validator** — `pre-inception/document-validator.md` — consent-first classifier

See `aidlc-rule-details/pre-inception/*.md` for sub-flow details.

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

Each stage: load `inception/<stage>.md`, execute, append `audit.md`, present completion with 2-option gate ("Request Changes" / "Continue").

---

## 🟢 CONSTRUCTION (8 stages — per-unit loop, then build) · v0.7 split

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

**v0.7 conformance model:** Stage 14 split into 14a/14b/14c — Dev produces production code + test code; QA audits 4 sub-checks (code · token discipline · UI fidelity · test code coverage) as the **blocking** gate before the unit advances. Test execution remains the project's CI/local choice (outside AI-DLC).

---

## 🟠 OPERATIONS (placeholder)

```mermaid
flowchart LR
    S15[Build complete] --> S16[16. Deployment<br/>placeholder · DevOps]
    S16 --> S17[17. Monitoring<br/>placeholder · DevOps + SRE]
```

Format TBD in v0.5. No compliance verification stage in v0.4.

---

## Roles

| Role | Drives | Skill |
|---|---|---|
| PM (Product Owner) | Stages 4, 6 | `skills/kafi/roles/pm.md` |
| BA (Business Analyst) | Stage 5 + Pre-Inception | `skills/kafi/roles/ba.md` |
| SA (Solution Architect) | Stages 3, 8, 9, 10, 11, 12 | `skills/kafi/roles/sa.md` |
| Designer (Product Designer) | Stage 7 | `skills/kafi/roles/designer.md` + `skills/kafi/design-system/SKILL.md` |
| Dev (Developer) | Stages 14a, 14b, 15 | `skills/kafi/roles/dev.md` |
| **QA (Quality Assurance)** | **Stages 10b, 14c (NEW v0.7)** | `skills/kafi/roles/qa.md` |
| DevOps / SRE | Stages 13, 16, 17 | `skills/kafi/roles/devops.md` |
| AI Agent | Every stage | — |

Manual skill inclusion — load when driving a stage. Two skills are auto-discoverable (proper SKILL.md format) and load automatically when their description matches the user's intent:

- **kafi-design-system** — loads whenever a stage produces UI artifacts
- **kafi-aidlc-onboarding** — loads when the user just unzipped the package, asks where to start, mentions `/init`, or wants to scan `00-knowledge/` to determine which AI-DLC stage their project is at. Explains why `/init` is redundant on AI-DLC projects (CLAUDE.md is already auto-loaded).

---

## Templates

KAFI standard at `aidlc-rule-details/templates/` · Project overrides at `00-knowledge/templates/`.

Available templates (19):
`vision.md` · `technical-environment.md` · `prd.md` · `requirements.md` · `user-story.md` · `application-design.md` · `data-model.md` · `components.md` · `unit-of-work.md` · `functional-design.md` · `design-tokens.md` · `uiux-spec.md` · `view-model.md` · `test-plan.md` · `test-cases.md` · `dod.md` · `nfr-requirements.md` · `nfr-design.md` · `adr.md`

**Traceability:** `Intent → Vision → [BRD] → PRD → REQ → ENT → Epic → Story → Unit → TC → ADR` · IDs: `PRD-NN · REQ-NN · ENT-NN · EPIC-NN · US-NN · UNIT-NN · TC-NN · ADR-NN`

> **PRD vs Requirements:** PRD answers *WHAT* and *FOR WHOM* (product narrative, feature-level, PM-owned). `requirements.md` answers *HOW THE SYSTEM MUST BEHAVE* (testable functional + NFR, derived from PRD-NN). Both produced at Stage 4. See `aidlc-rule-details/templates/prd.md`.

> **v0.7 templates (new):** `design-tokens.md` (project look & feel catalog), `uiux-spec.md` (master UI/UX narrative), `view-model.md` (per-screen MVVM data binding), `data-model.md` (system-wide entities ENT-NN), `test-plan.md` + `test-cases.md` (per-unit QA documentation), `dod.md` (Definition of Done rubric for every gate).

> **Pending templates (planned, no scaffold yet):** `epic.md` · `personas.md` · `risk-register.md` · `design-lite.md` · `story-map.md` (v0.8+). Until shipped, author these freehand using the traceability chain above.

---

## AI Review Checklist (Soft Enforcement)

Before any meaningful write, agent self-checks against `common/ai-review-checklist.md`. Warnings reported in completion summary — user decides.

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
├── CLAUDE.md                       # this file
├── aidlc-rule-details/            # rule files
├── .claude/
│   ├── skills/kafi/
│   │   ├── design-system/          # KAFI brand-level design system (SKILL.md)
│   │   └── roles/                  # 6 role guides
│   ├── hooks/                      # optional
│   └── settings.json
├── 00-knowledge/                   # project KB + conventions
├── aidlc-docs/                     # generated artifacts
├── adrs/                           # Architecture Decision Records
└── src/                            # application code
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

*Companion handbook: `KAFI-AIDLC-Handbook.html` · v0.4 · Transformation Office, Kafi Securities*
