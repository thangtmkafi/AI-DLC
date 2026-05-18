# Process Overview

**Purpose:** Define the meta-rules every stage follows.

## Stage execution cycle

```
1. Log raw user input → audit.md
2. Load this stage's rule-detail file
3. Load prior stage outputs as inputs
4. Execute (plan → questions → generation)
5. Run AI Review Checklist (soft)
6. Present 2-option completion
7. Wait for explicit approval
8. Log user response → audit.md
9. Proceed to next stage
```

## 2-Option Completion Message Format

```
✅ [Stage Name] — Complete

[Brief summary of what was produced]

Outputs:
- path/to/output1.md
- path/to/output2.md

Open items surfaced: [list or "None"]
Extension compliance: [summary]
AI Review Checklist: [pass / N warnings]

What's next?
  → Request Changes (describe what to change)
  → Continue to [Next Stage Name]
```

## Plan-driven stages

Stages 5 (User Stories), 9 (Units Generation), 14 (Code Generation) are 2-part:
- **Part 1 — Planning**: create plan.md with checkboxes + questions; user approves plan
- **Part 2 — Execution**: execute approved plan, ticking checkboxes

## Adaptive principle

The agent assesses which CONDITIONAL stages add value for this project:
- Reverse Engineering: brownfield only
- User Stories: user-facing work only
- Product Design: UI involved only
- Application Design: new components only
- Units Generation: multi-unit only
- Functional/NFR Req/NFR Design/Infra Design: per-unit conditional

Always-on: 1, 2, 4, 6, 14, 15.

## Anti-patterns to avoid

- Skipping audit log entries
- Asking questions inline in chat (always go to file with `[Answer]:` tag)
- Proceeding past a gate without explicit approval
- Fabricating answers to open items
- Modifying source documents (always produce sibling files)
