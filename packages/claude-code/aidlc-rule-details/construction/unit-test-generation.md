# Stage 14b: Unit Test Code Generation

**Owner:** Developer (sole) · **Per-unit** · runs after Stage 14a production code · before Stage 14c audit · **Approval required**

## Purpose

Translate the per-unit `test-cases.md` catalog (authored by QA at Stage 10b) into **executable test code** in the target framework. Tests live alongside production code in `src/`.

**Scope:** test code generation (Dev-owned, like production code generation). **Test execution is NOT in scope** — generated tests sit waiting for the project's CI / local runner. Status fields in `test-cases.md` stay "Pending" through AI-DLC; project fills them at execution time.

## Inputs

- Production code from Stage 14a (in `src/`) — function signatures + module structure
- `aidlc-docs/construction/{unit}/test/test-plan.md` — **framework** declaration (Jest · Vitest · Bun-test · pytest · …), assertion style, test file pattern
- `aidlc-docs/construction/{unit}/test/test-cases.md` — TC-NN catalog with G/W/T
- `aidlc-docs/construction/{unit}/functional-design/` — function signatures, business rules
- `aidlc-docs/inception/product-design/mockups/<screen>.view-model.md` — field formats, validation rules, computed-field formulas (for UI test boundary case derivation)
- `aidlc-docs/inception/product-design/interaction-specs.md` — state transitions (for UI state tests)
- `aidlc-docs/construction/{unit}/nfr-design/` — NFR thresholds (for NFR test cases)

## Steps

1. Load `test-plan.md` — confirm framework choice, file pattern, assertion style. Stage 14b respects these.
2. For each TC-NN in `test-cases.md`, generate a test in the chosen framework:
   - **Unit cases** → test functions next to source (e.g., `src/foo.test.ts` next to `src/foo.ts`)
   - **Integration cases** → test files in same module (or `src/__tests__/`)
   - **UI cases** → component-level test files (React Testing Library / Vue Test Utils / etc., per framework)
   - **NFR cases** → may live in a separate `src/__nfr__/` if framework supports; otherwise comment + skip with rationale
   - **Contract cases** → consumer/provider tests if applicable
3. For **every exported function/method** in production code, ensure ≥1 test file exists (even if `test-cases.md` doesn't have a case — generate at least a "happy path" smoke test). Missing function ⇒ blocked at audit.
4. For **UI units**, derive additional boundary cases from view-model:
   - For each field with min/max validation: 2 boundary cases (just-valid + just-invalid)
   - For each field format: 1 rendering case
   - For each state: 1 case rendering that state
5. Use the framework's assertion style declared in `test-plan.md`. No mixing.
6. Mock external dependencies per `test-plan.md` policy.
7. Write `aidlc-docs/construction/{unit}/code/tests-summary.md`:
   - Functions covered + which test file
   - TC-NN → test function name mapping
   - Skipped cases (with rationale)
   - Framework + config file path
8. Update `aidlc-docs/aidlc-state.md` per process-overview state-file maintenance rules.

## Outputs

- **Test code** in `src/` alongside production code (NEVER inside `aidlc-docs/`)
  - File naming per `test-plan.md` pattern: `<module>.test.ts`, `__tests__/<module>.ts`, `<module>_test.py`, etc.
- **`aidlc-docs/construction/{unit}/code/tests-summary.md`** — summary + mapping (not the tests themselves)

## Approval gate

```
Unit Test Code Generation for UNIT-{N} complete.
- Framework: [X] (from test-plan.md)
- Test files created: [N]
- Functions covered: [F / F_total] = [pct]%
- TC-NN coverage:
  · Functional cases: [K1 implemented / K1 total]
  · UI cases: [K2 / K2_total]
  · NFR cases: [K3 / K3_total]
- Skipped cases (with rationale): [list]
- Tests NOT executed in AI-DLC — project runs via CI/local

→ Request Changes (specify uncovered functions / TC-NN)
→ Continue to Stage 14c (Conformance Audit)
```

Dev signs off on completeness; QA verifies at 14c.

## Watch for

- Test file uses framework different from `test-plan.md` declaration (must match exactly)
- Exported function with zero test file (blocking at audit)
- Test case in code without TC-NN comment reference (every test should cite source TC-NN for traceability)
- Mocking real entities (mock at boundary only — entities from data-model are real test subjects)
- Tests that import production code via cross-boundary path (refactor or open ADR)
- Pre-filled "expect(true).toBe(true)" placeholder tests — blocking

## What this stage does NOT do

- ❌ Execute tests (project's choice — CI / local / framework runner)
- ❌ Author test cases (that's Stage 10b, QA-owned)
- ❌ Audit production code (that's Stage 14c, QA-owned)
- ❌ Change `test-cases.md` status fields (those stay "Pending" until execution outside AI-DLC)
