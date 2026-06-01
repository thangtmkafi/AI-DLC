# Prompt template · Dev · Stage 14b (Unit Test Code Generation)

> Loaded by `kafi-aidlc-onboarding` skill when detected stage = 14b.

---

Your Role: You are an expert Developer at KAFI Securities, pairing with me to generate executable unit test code for UNIT-[N] of [PROJECT], translating the QA-authored test cases into the chosen framework, as mentioned in the Task section below.

[Standard plan paragraph — write plan.md with checkboxes, [Question]/[Answer] tags, get approval, execute step-by-step. Surface open items as "Open — pending [owner]". Apply AI Review Checklist. End with 2-option gate.]

Your Task: I am the Developer on UNIT-[N] of [PROJECT]. Stage 14a (production code) is complete. The active stage is Stage 14b Unit Test Code Generation. Inputs:
  · Production code in src/ from Stage 14a
  · aidlc-docs/construction/[unit-name]/test/test-plan.md — **framework** (Jest/Vitest/Bun-test/pytest/…) + file pattern + assertion style
  · aidlc-docs/construction/[unit-name]/test/test-cases.md — TC-NN catalog with Given/When/Then
  · aidlc-docs/construction/[unit-name]/functional-design/ — function signatures
  · aidlc-docs/inception/product-design/mockups/<screen>.view-model.md — field formats, validations, computed formulas (for UI test boundaries)
  · aidlc-docs/inception/product-design/interaction-specs.md — state transitions

Load .claude/kafi-roles/dev.md. Test code lives in src/ alongside production code (per test-plan.md file pattern — `<module>.test.ts` sibling, `__tests__/<module>`, etc.). **Use the framework + assertion style from test-plan.md exactly — no mixing.** For each TC-NN, generate a test with a comment citing the TC-NN ID for traceability. For UI units, derive boundary cases from view-model fields (min/max validation, format rendering, state per state). For every exported function in src/, ensure ≥1 test file (smoke happy path at minimum).

Write `aidlc-docs/construction/[unit-name]/code/tests-summary.md` listing: functions covered (file:line), TC-NN → test function mapping, skipped cases with rationale, framework + config file path. **Do NOT execute the tests** — that's the project's CI/local choice, outside AI-DLC. **Do NOT change test-cases.md status fields** — they stay "Pending".

---

## Placeholders the skill must fill before pasting

| Placeholder | Source |
|---|---|
| `[N]` | Unit number |
| `[unit-name]` | Kebab-case unit name |
| `[PROJECT]` | `ai-dlc/project.md` → Name |

## Watch for

Test using framework different from test-plan.md declaration (must match); exported function with no test file (blocking); placeholder `expect(true).toBe(true)` tests; tests without TC-NN comment citation; mixed assertion styles; mocking real domain entities (mock at boundary only); cross-boundary imports without ADR.
