# Product Requirements Document — [Feature Name]

> Stage 4 deliverable · PM owned · One file per major feature
> Sits between Vision (north-star) and Requirements (testable REQ-NN)
> Every PRD-NN traces forward to one or more REQ-NN

**Status:** Draft | Approved
**Owner:** [PM name]
**Last updated:** [Date]
**Version:** [v0.X]
**Parent Vision:** [link to vision.md]

---

## 1. Feature overview

[One sentence. What is this feature, in plain language?]

## 2. Problem statement

[1-2 paragraphs. What user pain does this solve? Why now? Cost of not solving?]

**Source:** Vision §X / Stakeholder request / KB citation

## 3. Target users / personas

| Persona | Primary need | Frequency of use |
|---|---|---|
| [Role 1] | [need] | [daily / weekly / one-off] |
| [Role 2] | [need] | [...] |

## 4. User journey / scenarios

[2-4 concrete scenarios in user voice. "As a [role], I want to [action] so that [outcome]." Walk through happy path + 1 edge case.]

- **Scenario 1 — [name]:** [walk-through]
- **Scenario 2 — [name]:** [walk-through]

## 5. Features

Each PRD-NN is a product-level capability (NOT a technical requirement — that's `requirements.md`).

- **[PRD-01]** [Capability name]
  - **What it does:** [user-facing behavior]
  - **Priority:** Must / Should / Could
  - **Success criteria:** [observable outcome]
  - **Decomposes to:** REQ-NN, REQ-NN+1 (filled by Stage 4 requirements step)

- **[PRD-02]** [Capability name]
  - **What it does:** [...]
  - **Priority:** ...
  - **Success criteria:** [...]
  - **Decomposes to:** [REQ list]

## 6. Success metrics (measurable)

[Numbers, not adjectives. How do we know the PRD shipped value?]

| Metric | Baseline | Target | Measurement source |
|---|---|---|---|
| [e.g., Time-to-complete task X] | 12 min | < 3 min | App telemetry |
| [e.g., Error rate] | 5% | < 0.5% | Log aggregator |
| [e.g., User adoption (week 4)] | 0% | 60% of target users | Active-user count |

## 7. Scope

### Scope IN
- [Capability / behavior 1]
- [Capability / behavior 2]

### Scope OUT
[Explicitly NOT in this PRD — equally important to scope IN.]
- [Item] — deferred to [phase X / future PRD]
- [Item] — handled by [other system / other PRD]

## 8. Dependencies

| Depends on | What we need | Owner | Status |
|---|---|---|---|
| [PRD-NN or external system] | [API / data / decision] | [team / person] | [confirmed / pending] |

## 9. Risks + mitigations

| Risk | Likelihood | Impact | Mitigation |
|---|---|---|---|
| [Risk 1] | H/M/L | H/M/L | [plan] |
| [Risk 2] | ... | ... | [...] |

## 10. Constraints

| Type | Constraint | Source |
|---|---|---|
| Regulatory | [e.g., TT 96/2020 audit trail] | KB §regulatory |
| Technical | [e.g., must call Bravo EOD only] | KB §architecture-boundaries |
| Business | [e.g., go-live by Q3] | Vision §timeline |

## 11. Open items

[Decisions still pending. Each must have an owner.]

- Open — pending [owner]: [decision needed] · See `00-knowledge/open-items.md#[id]`

---

## Traceability footer

| PRD-NN | Decomposes to (REQ-NN) | Realized by (US-NN) | Implemented in (UNIT-NN) | ADR (if architectural) |
|---|---|---|---|---|
| PRD-01 | REQ-01, REQ-02, REQ-03 | US-01, US-02 | UNIT-01 | ADR-01 |
| PRD-02 | REQ-04, REQ-05 | US-03 | UNIT-02 | — |

*PRD-NN populated at Stage 4 step 4a · REQ-NN at Stage 4 step 4b · US-NN at Stage 5 · UNIT-NN at Stage 9 · ADR-NN appended ongoing.*

---

KB cited: {sections referenced}
Related: PRD-NN cross-refs · Vision § · BRD § (if any) · ADR-NN
