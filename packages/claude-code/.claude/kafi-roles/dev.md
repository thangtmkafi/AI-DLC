---
name: kafi-role-dev
description: Skill for Developer working through KAFI AI-DLC. Defines Dev responsibilities, dos, don'ts. Load when driving Stage 14 (Code Generation) or Stage 15 (Build).
inclusion: manual
---

# Role: Dev (Developer)

## Why this role exists

You turn design into running code AND its unit tests. With AI-DLC, you pair with the agent: the agent drafts, you review, you decide. **v0.7 split:** Stage 14a (production code, this role) → Stage 14b (unit test code, this role, derived from QA's test-cases.md) → Stage 14c (conformance audit, QA-owned, blocking). Test execution is the project's CI/local choice (outside AI-DLC).

## Do

- **Match the mockup — strictly.** Generated FE MUST reproduce the Stage 7 HTML mockup: layout, component hierarchy, design tokens, and every state (default/hover/empty/error/loading/disabled). The mockup is the source of truth, not a suggestion. If a screen this unit needs has no mockup → **STOP, open item back to Stage 7, don't improvise UI.**
- **Follow the declared code flow.** Implement the call paths in `code-flow.md` (Stage 10) — View → Handler → Service → Repo → DB. No cross-boundary call that isn't declared there (+ ADR). Stage 14c sub-check #5 audits this against the generated call graph.
- **Review the code generation plan** before approving Part 2 execution. Catch architecture issues at plan time, not after files are written. For UI units, confirm the plan's Mockup mapping covers every screen.
- **Run `kafi-verification-loop` before handing off to Stage 14c** — build · typecheck · lint · tests · security in one pass. Don't burn a conformance-audit cycle on code that doesn't compile.
- **Document build instructions** in Stage 15 such that someone with zero context could rebuild from a fresh clone.
- **Run the AI Review Checklist** mentally on every generated file. Critical fails should be addressed before merge.
- **Cite designs.** Generated code should reference functional-design / nfr-design / interaction-specs / source mockup / code-flow in comments where relevant.

## Don't

- Don't accept code outside `src/`. Application code never lives in `aidlc-docs/`.
- Don't approve code with hardcoded secrets. Always env vars.
- Don't ignore architecture boundary violations — refactor or open an ADR justifying the cross.
- Don't skip audit trail wiring. The extension auto-wires but verify.
- Don't add external packages without recording rationale in the plan.

## Stages you drive

- **Stage 14a: Production Code Generation** (pair with AI agent — production code only in `src/`)
- **Stage 14b: Unit Test Code Generation** (NEW v0.7 — translate QA's `test-cases.md` into test code in chosen framework, lives alongside production code)
- **Stage 15: Build** (sole owner)

## Stages where you're consulted

- Stage 8 (Application Design) — when component design has implementation implications you should flag
- Stage 13 (Infrastructure Design) — runtime / deployment realities

## Key questions Dev should always ask

- "Does the generated FE match the mockup screen-by-screen — layout, tokens, all states?"
- "Are there any architecture boundary violations?"
- "Is the audit trail wired?"
- "Are secrets in env vars only?"
- "Can I rebuild this from a fresh clone with just the build instructions?"

## Anti-patterns to call out

- FE that diverges from the mockup (re-styled, restructured, missing states, ad-hoc colors)
- UI generated for a screen with no source mockup
- Generated code that imports across boundaries without ADR
- Logging PII
- Hardcoded config (URLs, IDs, timeouts)
- Missing error handling on external calls

## References

- Stage: `aidlc-rule-details/construction/code-generation.md`
- Stage: `aidlc-rule-details/construction/build.md`
- Checklist: `aidlc-rule-details/common/ai-review-checklist.md`
