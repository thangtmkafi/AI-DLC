# Stage 14a: Production Code Generation

**Owner:** Developer · **Always runs** (per-unit) · **Approval required** · Advances to Stage 14b (Unit Test Code Generation)

> **Stage 14 split (v0.7):** 14a Production Code (this file, Dev) · 14b Unit Test Code (Dev) · 14c Conformance Audit (QA). The FE fidelity gate (v0.6) is enforced at 14c, not here.

## Purpose

Generate **production code only** from the unit's design artifacts. Test code is Stage 14b; conformance audit is Stage 14c.

Code goes to `src/`; only summaries in `aidlc-docs/`.

## Inputs

- `aidlc-docs/construction/{unit}/functional-design/` — business logic, rules, domain entities, `frontend-components.md`
- `aidlc-docs/construction/{unit}/nfr-design/`
- `aidlc-docs/inception/application-design/data-model.md` — ENT-NN reference (entity names + types are stable)
- `aidlc-docs/inception/product-design/design-tokens.md` — token catalog (FE must use only these tokens — v0.7)
- `aidlc-docs/inception/product-design/mockups/` — **HTML mockups for this unit's screens · REQUIRED if the unit has UI**
- `aidlc-docs/inception/product-design/mockups/<screen>.view-model.md` — **data binding contract per screen** (v0.7)
- `aidlc-docs/inception/product-design/interaction-specs.md` — states, transitions
- `00-knowledge/conventions/` — architecture boundaries, naming conventions

## Frontend fidelity (mandatory when unit has UI)

The Stage 7 HTML mockup is the **source of truth** for all generated frontend. It is NOT a suggestion or a loose reference.

- **Reproduce** the mockup's layout, component hierarchy, and visual structure in the target framework (React/Vue/etc).
- **Use the exact design tokens** (colors, spacing, typography) from the mockup / design-system skill — no ad-hoc styling, no invented colors.
- **Implement every state** shown in the mockup + `interaction-specs.md`: default, hover, empty, error, loading, disabled.
- **Do NOT introduce** screens, components, or layouts absent from the mockup. If a screen needed by this unit has no mockup → **STOP. Emit an open item back to Stage 7. Do not improvise UI.**
- **Map** each generated UI component to its source mockup file in `code-summary.md`.

The FE fidelity gate is enforced at **Stage 14c** (Conformance Audit, QA-owned) — a unit with UI cannot pass Stage 14c if the generated FE diverges from its mockup, breaks token discipline (per `design-tokens.md`), or ignores view-model bindings (per `view-model.md`). Stage 14a writes the code; Stage 14c verifies.

## 2-part execution

### Part 1: Planning

Write `aidlc-docs/construction/{unit}/plans/code-generation-plan.md`:

```markdown
# Code Generation Plan: UNIT-{N}

## File structure
- [ ] src/[module1]/file1.ts
- [ ] src/[module1]/file2.ts
- [ ] src/[module2]/file3.ts
- ...

## Mockup mapping (if unit has UI)
| Screen | Source mockup | Components to generate |
|---|---|---|
| Deal capture | product-design/mockups/deal-capture.html | DealForm, DealRow, EmptyState, ErrorBanner |

## Dependencies (build order)
1. domain entities
2. business rules
3. services
4. API/handlers
5. UI components (if applicable)

## External dependencies to add
- package-X@1.2.3 — for [purpose]
- package-Y@4.5.6 — for [purpose]

## Questions
## Question: Code style baseline
A) Use existing project style (linters detected: [list])
B) Default to KAFI standard
C) Mix as specified

[Answer]: 

## AI Review Checklist plan
- Grounded: cite Functional Design + NFR Design
- FE fidelity: generated UI matches product-design/mockups/<screen>.html (layout, tokens, all states)
- No secrets: env vars only
- Audit trail: auto-wire per audit-trail extension
- Privacy: auto-wire per privacy extension if PII
```

User approves plan.

### Part 2: Generation

1. Generate code per approved plan.
2. Tick checkboxes in plan.md as each file completes.
3. **Frontend: build each component to match its source mockup** — layout, hierarchy, tokens, all states. No divergence.
4. Auto-wire audit trail at state-change boundaries.
5. Auto-wire privacy enforcement if PII fields touched.
6. Enforce architecture boundaries (lint).
7. Run AI Review Checklist (soft) + FE fidelity self-check (hard for UI units).

## Outputs

- Code in `src/` (NEVER inside `aidlc-docs/`)
- Markdown summaries in `aidlc-docs/construction/{unit}/code/`:
  - `code-summary.md` — what was built, structure, conventions, **+ component → mockup mapping for UI units**
  - `file-inventory.md` — list of files created/modified with one-line description each

## Approval gate

```
Production Code Generation (Stage 14a) for UNIT-{N} complete.
- Files created: [N]
- Files modified: [M]
- External packages added: [list]
- Audit trail wired: ✓
- Architecture boundaries: ✓ enforced
- View-model bindings respected (UI units): ✓ all fields cite ENT-NN with declared format
- Design tokens used (UI units): ✓ no ad-hoc hex/px values
- AI Review Checklist: [pass / N warnings — listed]

→ Request Changes
→ Continue to Stage 14b (Unit Test Code Generation)
```

Stage 14a ends here. Stage 14b (Dev) generates test code; Stage 14c (QA) audits everything.

## Tests handled in Stage 14b

This stage produces production code only. The unit test code is generated at Stage 14b (Dev), translating QA's `test-cases.md` into the framework declared in `test-plan.md`. Stage 14c (QA conformance audit) is the blocking gate before this unit advances.

## Watch for

- **FE that diverges from the mockup** (re-styled, restructured, missing states) — Request Changes
- **UI generated with no source mockup** — STOP, open item back to Stage 7
- Code outside `src/` (move it)
- Architecture boundary violations (refactor)
- Hardcoded secrets (extract to env)
- Missing audit hooks (add via extension)
