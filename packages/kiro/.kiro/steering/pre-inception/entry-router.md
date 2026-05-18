---
inclusion: manual
description: "Entry Router"
---

# Entry Router

**Purpose:** 3 questions to disambiguate user intent when session start is unclear. Never blocks — produces a recommendation.

## When to run

- User's first message is vague ("help me build something", "let's start a project")
- Multiple sub-flows could fit
- No attached document AND no clear scope statement

## Skip when

- User explicitly named a sub-flow ("run map-existing on this doc")
- A document is attached → Document Validator runs instead
- User asked about a specific stage by name

## The 3 questions

Write to `aidlc-docs/inception/discovery/entry-router-questions.md`:

```markdown
## Question 1: What do you want to do?
A) Prepare inputs for development (Vision, Tech Env, requirements)
B) Build software (code generation from existing inputs)
C) Fix or extend something in this repo
D) Other (describe below)

[Answer]: 

## Question 2: What do you have right now?
A) A clear Vision Document + Tech Env
B) A draft BRD/PRD/legacy doc that needs work
C) Only an idea or short brief
D) Existing code I need to extend
E) Other (describe below)

[Answer]: 

## Question 3 (optional): Any hard constraints?
A) Specific language/runtime (specify below)
B) Specific deadline (specify below)
C) Regulatory (audit trail, privacy, accessibility) — confirm
D) None
E) Other (describe below)

[Answer]: 
```

## Recommendation mapping

| Q1 / Q2 | Recommended path |
|---|---|
| A / A → already done | Confirm + proceed to Inception |
| A / B → map existing | Sub-flow C: map-existing |
| A / C → author from brief | Sub-flow D: author-from-brief |
| A / D → reverse engineer first | Standard mode + Reverse Engineering |
| B / A → straight to building | Inception (Lite if greenfield) |
| C / D → brownfield extension | Standard mode |

Present recommendation as one option in a final 2-option message:

```
Recommended path: [Sub-flow X]
  → Proceed with recommendation
  → Choose different path (specify below)
```
