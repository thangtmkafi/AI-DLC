---
inclusion: manual
description: "Role: Dev (Developer)"
---

# Role: Dev (Developer)

## Why this role exists

You turn design into running code. With AI-DLC, you pair with the agent: the agent drafts, you review, you decide. No unit tests required through v0.4 (test artifacts deferred to v0.5).

## Do

- **Review the code generation plan** before approving Part 2 execution. Catch architecture issues at plan time, not after files are written.
- **Verify the build runs locally** before approving Stage 14 completion.
- **Document build instructions** in Stage 15 such that someone with zero context could rebuild from a fresh clone.
- **Run the AI Review Checklist** mentally on every generated file. Critical fails should be addressed before merge.
- **Cite designs.** Generated code should reference functional-design / nfr-design / interaction-specs in comments where relevant.

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

- "Does this code match the design?"
- "Are there any architecture boundary violations?"
- "Is the audit trail wired?"
- "Are secrets in env vars only?"
- "Can I rebuild this from a fresh clone with just the build instructions?"

## Anti-patterns to call out

- Generated code that imports across boundaries without ADR
- Logging PII
- Hardcoded config (URLs, IDs, timeouts)
- Missing error handling on external calls
- Tests imported as "todos" — defer until v0.4

## References

- Stage: `.kiro/steering/construction/code-generation.md`
- Stage: `.kiro/steering/construction/build.md`
- Checklist: `.kiro/steering/common/ai-review-checklist.md`
