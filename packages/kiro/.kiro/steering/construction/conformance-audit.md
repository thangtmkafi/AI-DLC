---
inclusion: manual
description: "Stage 14c: Conformance Audit"
---

# Stage 14c: Conformance Audit

**Owner:** QA (sole) · **Per-unit · always runs after Stage 14b** · **Approval required · BLOCKING gate**

## Purpose

Verify that the generated artifacts of this unit (production code from Stage 14a + test code from Stage 14b) **strictly conform** to all upstream specs. This is the last gate before the unit can advance to the next unit or to Stage 15 (Build).

Stage 14c does NOT execute tests — it audits whether code, tokens, UI, and tests CONFORM to specs. Test execution is the project's responsibility outside AI-DLC.

## Inputs

- `src/` — production code (Stage 14a) + test code (Stage 14b) for this unit
- `aidlc-docs/construction/{unit}/functional-design/` — function signatures, business rules, domain entities, frontend-components
- `aidlc-docs/construction/{unit}/nfr-design/`
- `aidlc-docs/construction/{unit}/test/test-plan.md` + `test-cases.md`
- `aidlc-docs/construction/{unit}/code/code-summary.md` + `tests-summary.md`
- `aidlc-docs/inception/application-design/data-model.md` — ENT-NN reference
- `aidlc-docs/inception/product-design/uiux-spec.md` + `design-tokens.md` + `mockups/<screen>.html` + `mockups/<screen>.view-model.md` + `interaction-specs.md`
- `00-knowledge/conventions/`

## The 4 blocking sub-checks

Any ✗ blocks — Request Changes back to the appropriate stage (14a / 14b / 7 as relevant).

### 1. Code audit

Verify production code matches design specs.

- [ ] Architecture boundaries respected (no cross-boundary imports without ADR)
- [ ] Component-method signatures match `components.md`
- [ ] Domain entities match `data-model.md` (names, types, constraints, invariants) AND `domain-entities.md` (per-unit derivation)
- [ ] **For UI units, every component cites the source view-model and respects its field bindings** — entity.attribute source, type, format string applied, validation rules enforced, computed-field formulas implemented as declared
- [ ] Audit-trail extension wired at state-change boundaries
- [ ] Privacy extension wired if PII fields touched
- [ ] No hardcoded secrets (env vars only)
- [ ] All generated code cites the functional-design / requirements section it implements

### 2. Token discipline audit (UI units only)

Verify FE code uses only declared design tokens.

- [ ] Every style value in CSS / styled-components / Tailwind config maps to a token in `design-tokens.md` (or the inherited KAFI base)
- [ ] No hardcoded hex literals (`#xxxxxx`, `#xxx`)
- [ ] No raw pixel/rem/em literals outside CSS variable definitions
- [ ] No raw motion duration values (`Nms` literals) outside variable definitions
- [ ] Font stacks match declared stacks in `design-tokens.md` typography
- [ ] Component library used matches the declared choice (no extra library snuck in)

**Tooling:** regex scan
- Hex: `#[0-9a-fA-F]{3,6}` outside CSS `var(--*)` or token-definition file
- Length literals: `\b\d+(?:\.\d+)?(?:px|rem|em)\b` outside variable definitions
- Duration literals: `\b\d+ms\b` outside variable definitions

Each match = candidate ✗ (review individually; legitimate exceptions documented).

### 3. UI audit (UI units only)

Verify rendered output matches the Stage 7 mockup screen-by-screen.

- [ ] Layout and component hierarchy match `mockups/<screen>.html`
- [ ] All states from `view-model.md` §4 are implemented (default · empty · loading · error · disabled · …)
- [ ] Field rendering matches view-model formats (currency grouping, decimal places, date pattern)
- [ ] Validation rules enforced as declared in view-model
- [ ] Computed fields render the declared formula's output
- [ ] Empty/error/loading visuals match mockup variants
- [ ] Action handlers invoke the declared domain operation per view-model §5

**Method:** Manual screen-by-screen review against mockup HTML side-by-side; future v0.8 visual-diff tooling will automate (Stream D1).

### 4. Test code coverage audit

Verify Stage 14b produced complete test code.

- [ ] Every exported function/method in `src/` has at least one test file
- [ ] Every TC-NN in `test-cases.md` has a corresponding test function in code (citation comment present)
- [ ] Test framework in code matches `test-plan.md` declaration
- [ ] `tests-summary.md` matches reality (no claimed coverage that doesn't exist)
- [ ] No placeholder tests (`expect(true).toBe(true)` etc.)
- [ ] For UI units: tests for each view-model field's boundary cases + format rendering + states exist

**Tooling:** AST/glob scan of `src/*.{ts,tsx,js,py,go,…}` vs corresponding `<file>.test.<ext>` or `__tests__/`; grep test code for TC-NN identifiers; diff against `test-cases.md`.

## Steps

1. Load all inputs.
2. Run sub-check 1 (Code audit) — record findings.
3. Run sub-check 2 (Token discipline) — record regex match findings.
4. Run sub-check 3 (UI audit) — manual review of each screen vs mockup.
5. Run sub-check 4 (Test code coverage) — AST/glob + grep.
6. Author `aidlc-docs/construction/{unit}/audit/conformance-report.md`:
   - One section per sub-check with ✓ / ✗ per item and evidence (file:line for failures)
   - Overall gate verdict (Pass / Request Changes with which sub-check)
7. Update `aidlc-docs/aidlc-state.md` per process-overview state-file maintenance rules.

## Outputs

To `aidlc-docs/construction/{unit}/audit/`:

| File | Content |
|---|---|
| `conformance-report.md` | Per-sub-check findings with ✓ / ✗ and evidence |

## Approval gate

```
Conformance Audit for UNIT-{N} complete.

Sub-check 1 · Code audit:               [✓ / ✗ with diffs]
Sub-check 2 · Token discipline (UI):    [✓ / ✗ with violations]
Sub-check 3 · UI audit (UI):            [✓ / ✗ per screen]
Sub-check 4 · Test code coverage:       [✓ / ✗ with gaps]

Overall: PASS / REQUEST CHANGES

→ Request Changes (specify which sub-check; routes back to Stage 7 / 14a / 14b)
→ Continue to next unit OR Stage 15 (Build)
```

If any ✗ ⇒ Request Changes is mandatory. Cannot advance.

## Watch for

- "Audit passed but reviewer didn't actually check" — every sub-check requires evidence (file:line, screenshot, regex output) in the report
- Treating soft warnings as ✗ (only hard mismatches block)
- Allowing FE divergence with rationale like "mockup is just a suggestion" — NO. Mockup is source of truth (v0.6 rule)
- Hardcoded values with comments like "TODO refactor to token" — still ✗ in v0.7
- Tests that exist but assert nothing meaningful — ✗

## What this stage does NOT do

- ❌ Execute tests (project's CI / local runner — outside AI-DLC)
- ❌ Author code or tests (those are 14a / 14b, Dev-owned)
- ❌ Update mockups or specs (those are upstream — Request Changes routes back)
