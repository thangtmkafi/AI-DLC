# Process Overview

**Purpose:** Define the meta-rules every stage follows.

## Stage execution cycle

```
1. Log raw user input → audit.md
2. Load this stage's rule-detail file
3. Load prior stage outputs as inputs
4. Execute (plan → questions → generation)
5. Run AI Review Checklist (Hard = blocking, Soft = warnings)
5.5. Spec conformance trace-back (NEW v0.7 · mechanical, not human judgment):
     for each output produced, verify it cites a parent ID from the upstream stage
     (PRD-NN → REQ-NN → US-NN → ENT-NN → UNIT-NN → TC-NN).
     Outputs without parent citation → block, return to step 4.
6. Present 2-option completion
7. Wait for explicit approval
8. Log user response → audit.md
9. Update aidlc-state.md (advance current stage, append to Stages Completed)
10. Proceed to next stage
```

**Critical items in `ai-review-checklist.md` are blocking; quality items remain soft warnings.** A gate cannot be presented while any Hard item fails. The trace-back step (5.5) is part of the Hard set — mechanical, deterministic, no exceptions.

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

## State file maintenance

`aidlc-docs/aidlc-state.md` is the resume marker. It must reflect the latest committed state, not the latest in-progress work. The agent maintains it as follows:

**On approval received (step 9 above), update:**
- `Current Stage` → set to the next stage about to run (e.g., `Stage: [Stage N+1 — Name]`)
- `Status` → `planning` (since next stage's execution has not begun)
- `Last activity` → current timestamp (ISO 8601)
- `Last user input` → reference to the approval entry in `audit.md`
- `Stages Completed` → append `[✓] Stage N — Name`

**On `Request Changes` received, update:**
- `Status` → `execution` (returning to re-work)
- `Last activity` → current timestamp
- `Last user input` → reference to the change-request entry in `audit.md`
- Do NOT append to `Stages Completed`

**On planning gate approval (plan-driven stages 5, 9, 14 — Part 1 complete):**
- `Status` → `execution` (Part 2 begins)
- `Last activity` → current timestamp

**On execution start (mid-stage, before any output written):**
- `Status` → `execution`
- `Last activity` → current timestamp

**On the 2-option completion presented but not yet approved:**
- `Status` → `awaiting-approval`
- `Last activity` → current timestamp

The state file is overwritten in-place. The complete history lives in `audit.md` — `aidlc-state.md` holds only the current snapshot.

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
- Skipping `aidlc-state.md` updates after a gate (resume will reflect stale state)
- Asking questions inline in chat (always go to file with `[Answer]:` tag)
- Proceeding past a gate without explicit approval
- Fabricating answers to open items
- Modifying source documents (always produce sibling files)
