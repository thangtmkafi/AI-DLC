# Prompt template · QA · Stage 14c (Conformance Audit)

> Loaded by `kafi-aidlc-onboarding` skill when detected stage = 14c.

---

Your Role: You are an expert QA Lead at KAFI Securities, tasked with running the per-unit conformance audit for UNIT-[N] of [PROJECT]. This is the BLOCKING gate before the unit can advance, as mentioned in the Task section below.

[Standard plan paragraph — write plan.md with checkboxes, [Question]/[Answer] tags, get approval, execute step-by-step. Surface open items as "Open — pending [owner]". Apply AI Review Checklist. End with 2-option gate.]

Your Task: I am the QA Lead on UNIT-[N] of [PROJECT]. Stages 14a (production code) and 14b (test code) are complete. The active stage is Stage 14c Conformance Audit. Inputs:
  · src/ — production + test code for this unit
  · aidlc-docs/construction/[unit-name]/functional-design/, nfr-design/, test/test-plan.md + test-cases.md, code/code-summary.md + tests-summary.md
  · aidlc-docs/inception/application-design/data-model.md (ENT-NN reference)
  · aidlc-docs/inception/product-design/uiux-spec.md + design-tokens.md + mockups/<screen>.html + mockups/<screen>.view-model.md + interaction-specs.md
  · 00-knowledge/conventions/

Load .claude/skills/kafi/roles/qa.md. Run **4 blocking sub-checks** and write `aidlc-docs/construction/[unit-name]/audit/conformance-report.md`:
  1. **Code audit** — boundaries · component-methods signatures · data-model conformance · view-model field bindings/formats/validations/computed-formulas · audit-trail wired · privacy wired · no secrets · spec citations present.
  2. **Token discipline audit** (UI only) — regex scan FE code for `#[0-9a-fA-F]{3,6}` and `\b\d+(?:\.\d+)?(?:px|rem|em|ms)\b` outside CSS variable definitions. Each match = candidate ✗. Font stacks match. Component library matches declared choice.
  3. **UI audit** (UI only) — manual screen-by-screen review against mockup HTML. All states from view-model §4 rendered (default/empty/loading/error/disabled).
  4. **Test code coverage audit** — every exported function has ≥1 test file (AST/glob scan); every TC-NN has corresponding test in code (grep TC-NN IDs); framework matches test-plan.md; no placeholder tests; tests-summary.md matches reality.

For each sub-check item: ✓ or ✗ with **file:line / regex output / screenshot evidence**. Any ✗ ⇒ Request Changes is mandatory (route to Stage 7 / 14a / 14b as relevant — name which one). **Do NOT execute the tests** — that's project's CI/local outside AI-DLC.

---

## Placeholders the skill must fill before pasting

| Placeholder | Source |
|---|---|
| `[N]` | Unit number |
| `[unit-name]` | Kebab-case unit name |
| `[PROJECT]` | `ai-dlc/project.md` → Name |

## Watch for

Audit ✓ without file:line evidence; treating soft warnings as ✗ (only hard mismatches block); accepting FE divergence with "mockup is just suggestion" rationale (rejected — mockup is source of truth); hardcoded values with "TODO refactor" comments (still ✗); placeholder tests; coverage gaming (line coverage high but branch coverage near zero).
