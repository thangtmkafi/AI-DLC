# Test Plan — UNIT-NN [Unit name]

> Stage 10b deliverable · QA-owned · Per-unit strategy document
> Sets scope, test types, framework, coverage targets
> Companion: `test-cases.md` (detailed TC-NN catalog)

**Status:** Draft | Approved
**Owner:** [QA name]
**Last updated:** [Date]
**Unit:** UNIT-NN · [name]
**Approver:** [QA + SA]

---

## 1. Scope

What this unit covers in test, in plain language.

**In scope:**
- [Functional area / module 1]
- [Functional area / module 2]
- [UI screens served — S-NN list from uiux-spec catalog]
- [Domain operations from functional-design]

**Out of scope:**
- [Areas explicitly NOT tested by this unit · e.g. external services we mock]
- [NFRs handled by other units]

## 2. Test types

Which categories of tests this unit produces. Each category cited in `test-cases.md`.

| Type | Purpose | Examples this unit |
|---|---|---|
| **Unit** | Per-function correctness, isolated, fast | Pure functions, business rules, validators |
| **Integration** | Multiple modules together, real or in-memory deps | Repository + service, API + handler |
| **UI** | Per-component rendering + interaction | View-model bindings, state transitions, format rendering |
| **NFR** | Performance / security / accessibility / privacy thresholds | Response time p95 · audit-trail emission · WCAG a11y |
| **Contract** | External-system interface stability | API request/response shape, message envelope |

Mark each line ✓ / ✗ for "in this unit".

## 3. Framework

Test framework chosen for this unit (Stage 14b code generation respects this).

- **Framework:** [Jest · Vitest · Bun test · pytest · JUnit · go test · …]
- **Rationale:** [why this framework]
- **Runner config location:** [`vitest.config.ts` · `jest.config.js` · …]
- **Assertion style:** [BDD `expect(x).toBe(y)` · classical `assert(x === y)`]
- **Mocking approach:** [library + when to mock vs use real]
- **Test file pattern:** [`*.test.ts` next to source · `__tests__/*.ts` · …]

## 4. Coverage targets

What MUST have at least one test case. Derived from upstream specs.

| Upstream spec | Required coverage in this unit |
|---|---|
| Every REQ-NN this unit implements | ≥1 TC-NN cites it |
| Every US-NN AC (Given/When/Then) | ≥1 TC-NN cites it |
| Every view-model field (this unit's UI) | ≥1 TC-NN covers format + validation + boundary |
| Every state in view-model (default/empty/loading/error/disabled) | ≥1 UI TC-NN |
| Every domain operation in functional-design | ≥1 TC-NN covers happy + ≥1 covers failure |
| Every error path in `business-rules.md` | ≥1 TC-NN |

**Coverage target by metric:**
- Function coverage: ≥ [X]%
- Branch coverage: ≥ [Y]%
- Line coverage: ≥ [Z]%

(Project sets thresholds; defaults: 80/70/80 for non-trivial units.)

## 5. Risk-based prioritization

Areas that warrant deeper testing.

| Risk area | Why higher risk | Extra cases |
|---|---|---|
| Money calculations | Financial accuracy · regulatory | Boundary values · rounding · negative cases |
| State transitions | Multiple actors · concurrency | Each transition path · invalid transitions |
| Privacy-sensitive fields | PDPA · compliance | Masking · access logging · encryption |
| External integrations | Network failure · partial response | Timeout · retry · fallback · idempotency |

## 6. Test data needs

What test fixtures / seed data this unit requires.

- [Fixture 1] — [purpose · location]
- [Fixture 2] — [...]
- **Synthetic data generator:** [if used, which library + seed policy]
- **PII handling in test data:** must be synthetic only — NEVER real customer data

## 7. Test environment assumptions

- [DB type / version + seed strategy]
- [External services mocked or real?]
- [Time/clock injection mechanism for date-sensitive tests]
- [Locale / timezone settings]

## 8. Open items

- Open — pending [owner]: [...]

---

## What this document does NOT do

This is the **strategy**. The detailed test case catalog lives in `test-cases.md`. Test code lives in `src/` (Stage 14b output). Execution happens outside AI-DLC scope (project CI or manual).

KB cited: functional-design · view-model · uiux-spec · NFR-design (if any)
Related: `test-cases.md` · `tests-summary.md` (post-Stage 14b)
