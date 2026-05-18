# Question Format Guide

**Never ask questions inline in chat. Always write to a file with `[Answer]:` tags.**

## Format

```markdown
## Question: [Short topic]
[Context — why this question matters, 1-2 sentences]

A) [Option A — concrete, not vague]
B) [Option B]
C) [Option C]
D) [Option D]
E) [Option E — usually "Other (describe below)"]

[Answer]: 
```

## Rules

- **Always multi-choice** (A-E) — never open-ended. If truly open, give E) "Other (describe below)".
- **Concrete options** — "Use PostgreSQL" not "Use a database".
- **One question per block** — don't bundle.
- **Number the questions** if multiple in one file: `## Question 1: ...`
- **Wait** — never assume an answer. Pause until user fills `[Answer]:` and re-runs.

## When to ask

- Ambiguity that affects artifact quality
- Architectural trade-offs (always — never decide silently)
- Open items from `00-knowledge/open-items.md` — emit canonical line instead, don't ask
- Scope decisions (in vs out)

## When NOT to ask

- Things the KB clearly answers
- Things prior stage outputs clearly answer
- Style/formatting (use templates and conventions)

## Storage

Questions go in the relevant plan file:
- Inception plans: `aidlc-docs/inception/plans/[stage]-plan.md`
- Construction plans: `aidlc-docs/construction/plans/{unit}-[stage]-plan.md`
- Pre-Inception routing: `aidlc-docs/inception/discovery/[sub-flow]-questions.md`
