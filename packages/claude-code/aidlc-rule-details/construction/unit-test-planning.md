# Stage 10b: Unit Test Planning

**Owner:** QA (sole) · **Conditional** (per-unit · runs after Stage 10 Functional Design) · **Approval required**

## When to run / skip

```mermaid
flowchart LR
    A[Stage 10 functional-design complete?] -->|Yes| R[Run for this unit]
    A -->|Skipped (trivial unit)| S[Skip · inherit unit-level test plan]
```

If Stage 10 was skipped for this unit (simple CRUD), Stage 10b is also skipped — the unit inherits parent test plan if any, or relies on the next unit's plan.

## Purpose

Author the per-unit **test strategy** (`test-plan.md`) and **test case catalog** (`test-cases.md`) **before** code generation. These artifacts become the contract for Stage 14b unit test code generation and Stage 14c conformance audit.

**Scope:** documentation only. Test execution is the project's choice (CI / local / manual / framework) — out of AI-DLC scope. Status fields in `test-cases.md` stay "Pending" through AI-DLC stages.

## Inputs

- `aidlc-docs/construction/{unit}/functional-design/` — business-logic, business-rules, domain-entities, frontend-components
- `aidlc-docs/inception/user-stories/stories.md` — US-NN acceptance criteria for this unit
- `aidlc-docs/inception/product-design/uiux-spec.md` + `mockups/<screen>.view-model.md` + `mockups/<screen>.html` (for UI units)
- `aidlc-docs/inception/application-design/data-model.md` — ENT-NN reference
- `aidlc-docs/inception/requirements/requirements.md` — REQ-NN for this unit
- `aidlc-docs/construction/{unit}/nfr-design/` (if Stage 12 ran)
- `00-knowledge/conventions/architecture-boundaries.md`

## Steps

1. Identify this unit's scope from Stage 9 `unit-of-work*.md`. List which REQ-NN / US-NN / view-models / screens are in scope.
2. Author **`test-plan.md`** (use `templates/test-plan.md`):
   - Scope (in / out)
   - Test types (unit · integration · UI · NFR · contract)
   - Framework choice (Jest · Vitest · Bun-test · pytest · …) — declared explicitly so Stage 14b respects it
   - Coverage targets — every REQ + US AC + view-model field + state + domain op + business rule must have ≥1 TC-NN
   - Risk-based prioritization
   - Test data + environment assumptions
3. Author **`test-cases.md`** (use `templates/test-cases.md`):
   - Walk through derivation rules in template §case-derivation-rules
   - For each REQ-NN: ≥1 happy + 1-2 failure cases
   - For each US-NN AC: 1:1 mapping
   - For each view-model field: format + boundary (×2) + validation cases
   - For each view-model state: 1 case
   - For each computation: 1 happy + edge cases
   - For each domain operation: 1 happy + 1 failure
   - For each business rule: 1 case
   - For each NFR threshold: 1 case
4. Fill coverage summary table at top of `test-cases.md` — verify zero gaps.
5. Generate open items for ambiguous cases (e.g. "Open — pending PM: should empty face_value default to 0 or null?").
6. Update `aidlc-docs/aidlc-state.md` per process-overview state-file maintenance rules.

## Outputs

To `aidlc-docs/construction/{unit}/test/`:

| File | Content |
|---|---|
| `test-plan.md` | Strategy: scope, types, framework, coverage targets, risks, data, environment |
| `test-cases.md` | Catalog: TC-NN entries with G/W/T, citations, status field (filled at execution time) |

## Approval gate

```
Unit Test Planning for UNIT-{N} complete.
- Test plan: scope locked · framework=[X] · coverage targets declared
- Test cases: [K] cases authored
  · Functional: [K1] · UI: [K2] · NFR: [K3] · Contract: [K4]
- Coverage summary:
  · REQ coverage: [X / Y] ✓
  · US AC coverage: [X / Y] ✓
  · view-model field coverage: [X / Y] ✓
  · view-model state coverage: [X / Y] ✓
  · domain op coverage: [X / Y] ✓
  · business rule coverage: [X / Y] ✓
- Open items: [list]

→ Request Changes (specify which coverage area is incomplete)
→ Continue to Stage 11 (NFR Requirements) or Stage 14a (Production Code Generation) per execution plan
```

QA + SA sign-off required.

## Watch for

- Test cases that don't cite an upstream spec (REQ / US / view-model / domain op / rule) — every case must trace
- Coverage gaps (an item in test-plan §4 with zero TC-NN)
- Cases that bundle multiple assertions (split — one assertion per case)
- Cases referencing fields not in the data-model or view-model
- "Status: Pass" pre-filled — status MUST stay Pending until execution outside AI-DLC

## What this stage does NOT do

- ❌ Generate test code (that's Stage 14b, Dev-owned)
- ❌ Run tests (project's choice, outside AI-DLC)
- ❌ Audit existing code (that's Stage 14c, QA-owned audit)
