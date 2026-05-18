# Stage 14: Code Generation

**Owner:** Developer · **Always runs** (per-unit) · **Approval required**

## Purpose

Generate working code from all design artifacts. Code goes to `src/`; only summaries in `aidlc-docs/`.

## 2-part execution

### Part 1: Planning

Write `aidlc-docs/construction/{unit}/plans/code-generation-plan.md`:

```markdown
# Code Generation Plan: UNIT-{N}

## File structure
- [ ] src/[module1]/file1.ts
- [ ] src/[module1]/file2.ts
- [ ] src/[module2]/file3.ts
- ...

## Dependencies (build order)
1. domain entities
2. business rules
3. services
4. API/handlers
5. UI components (if applicable)

## External dependencies to add
- package-X@1.2.3 — for [purpose]
- package-Y@4.5.6 — for [purpose]

## Questions
## Question: Code style baseline
A) Use existing project style (linters detected: [list])
B) Default to KAFI standard
C) Mix as specified

[Answer]: 

## AI Review Checklist plan
- Grounded: cite Functional Design + NFR Design
- No secrets: env vars only
- Audit trail: auto-wire per audit-trail extension
- Privacy: auto-wire per privacy extension if PII
```

User approves plan.

### Part 2: Generation

1. Generate code per approved plan.
2. Tick checkboxes in plan.md as each file completes.
3. Auto-wire audit trail at state-change boundaries.
4. Auto-wire privacy enforcement if PII fields touched.
5. Enforce architecture boundaries (lint).
6. Run AI Review Checklist (soft).

## Outputs

- Code in `src/` (NEVER inside `aidlc-docs/`)
- Markdown summaries in `aidlc-docs/construction/{unit}/code/`:
  - `code-summary.md` — what was built, structure, conventions
  - `file-inventory.md` — list of files created/modified with one-line description each

## Approval gate

```
Code Generation for UNIT-{N} complete.
- Files created: [N]
- Files modified: [M]
- External packages added: [list]
- Audit trail wired: ✓
- Architecture boundaries: ✓ enforced
- AI Review Checklist: [pass / N warnings — listed]

→ Request Changes
→ Continue to next unit / Stage 15 (Build)
```

## No tests in v0.3

Unit tests deferred to v0.4+. Code Generation produces code only.

## Watch for

- Code outside `src/` (move it)
- Architecture boundary violations (refactor)
- Hardcoded secrets (extract to env)
- Missing audit hooks (add via extension)
