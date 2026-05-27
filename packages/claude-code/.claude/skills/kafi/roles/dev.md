---
name: kafi-role-dev
description: Skill for Developer working through KAFI AI-DLC. Defines Dev responsibilities, dos, don'ts. Load when driving Stage 14 (Code Generation) or Stage 15 (Build).
inclusion: manual
---

# Role: Dev (Developer)

## Why this role exists

You turn design into running code. With AI-DLC, you pair with the agent: the agent drafts, you review, you decide. Unit tests not generated yet (test artifacts are a backlog item, Stream A1).

## Do

- **Match the mockup — strictly.** Generated FE MUST reproduce the Stage 7 HTML mockup: layout, component hierarchy, design tokens, and every state (default/hover/empty/error/loading/disabled). The mockup is the source of truth, not a suggestion. If a screen this unit needs has no mockup → **STOP, open item back to Stage 7, don't improvise UI.**
- **Review the code generation plan** before approving Part 2 execution. Catch architecture issues at plan time, not after files are written. For UI units, confirm the plan's Mockup mapping covers every screen.
- **Verify the build runs locally** before approving Stage 14 completion.
- **Document build instructions** in Stage 15 such that someone with zero context could rebuild from a fresh clone.
- **Run the AI Review Checklist** mentally on every generated file. Critical fails should be addressed before merge.
- **Cite designs.** Generated code should reference functional-design / nfr-design / interaction-specs / source mockup in comments where relevant.

## Don't

- Don't accept code outside `src/`. Application code never lives in `aidlc-docs/`.
- Don't approve code with hardcoded secrets. Always env vars.
- Don't ignore architecture boundary violations — refactor or open an ADR justifying the cross.
- Don't skip audit trail wiring. The extension auto-wires but verify.
- Don't add external packages without recording rationale in the plan.

## Stages you drive

- **Stage 14: Code Generation** (pair with AI agent)
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
