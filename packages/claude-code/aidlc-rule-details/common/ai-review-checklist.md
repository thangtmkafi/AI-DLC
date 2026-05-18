# AI Review Checklist (Soft Enforcement)

Run before any meaningful write. Report results in completion summary. User decides whether to proceed.

## Critical items (warning if NO)

- [ ] **Grounded** — claims reference real KB, code, or docs in this repo. No fabrication.
- [ ] **No secrets** — no credentials, tokens, keys, PII, customer data.
- [ ] **Scope respected** — output stays within requested change. Extra work goes to backlog.
- [ ] **Reversible** — changes easy to revert. Risky ops have rollback note.
- [ ] **Human-decidable** — architectural / trade-off choices called out for a human.

## Quality items (informational)

- [ ] Matches house style (linters, formatters, naming)
- [ ] Negative and edge cases covered
- [ ] Errors handled
- [ ] Observable (logs, metrics, traces where they matter)
- [ ] Docs touched (README/ADR/aidlc-docs updated when appropriate)

## Risk-shaped review

For changes touching:
- Auth / authZ
- Money movement
- PII / sensitive data
- External contracts / APIs
- Infrastructure (IaC, deployment)

→ Flag for **dual review** (SA + relevant role).
→ For IaC: **plan-before-apply**. Destructive ops flagged.

## Completion summary format

```
AI Review Checklist:
  Critical: [✓ Grounded | ✓ No secrets | ⚠ Scope | ✓ Reversible | ✓ Human-decidable]
  Quality: [✓✓✓⚠✓]
  Risk-shaped: [N/A | Dual review needed: [why]]
  
  ⚠ Warnings:
  - [Scope] Output included refactor of unrelated module X — recommend backlog
```

## Soft enforcement rationale

User can proceed with warnings. Trust + speed > strict blocking for pilot.

If abuse appears (warnings repeatedly ignored), upgrade to hard enforcement in v0.4.
