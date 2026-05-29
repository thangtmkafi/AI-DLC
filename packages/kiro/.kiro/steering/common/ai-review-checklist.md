---
inclusion: always
description: "AI Review Checklist (v0.7 · Hard + Soft enforcement)"
---

# AI Review Checklist (v0.7 · Hard + Soft enforcement)

Run after generation, before presenting the 2-option gate. Items split into **Hard** (blocking — gate cannot be presented if any fail) and **Soft** (warning — user decides).

## Hard items · BLOCKING

If any of these fail, return to step 4 (Execute) and fix before presenting the gate.

- [ ] **Grounded** — every output cites real upstream spec (`PRD-NN` / `REQ-NN` / `US-NN` / `ENT-NN` / `UNIT-NN` / `TC-NN`) or KB section. No fabrication.
- [ ] **Spec conformance trace-back passed** (process-overview step 5.5) — every output's parent ID resolved.
- [ ] **No secrets** — no credentials, tokens, keys, PII, customer data.
- [ ] **Scope respected** — output stays within the locked spec for this stage. Out-of-scope work routes to backlog.
- [ ] **Risk-shaped extension compliance** — for outputs touching Auth / Money / PII / External / IaC, applicable extensions (audit-trail, privacy) declare compliance status with evidence.

## Soft items · WARNING (user decides)

- [ ] Matches house style (linters, formatters, naming)
- [ ] Negative and edge cases covered
- [ ] Errors handled
- [ ] Observable (logs, metrics, traces where they matter)
- [ ] Docs touched (README/ADR/aidlc-docs updated when appropriate)
- [ ] Reversible — changes easy to revert; risky ops have rollback note
- [ ] Human-decidable — architectural / trade-off choices surfaced

## Risk-shaped escalation

For changes touching:
- Auth / authZ
- Money movement
- PII / sensitive data
- External contracts / APIs
- Infrastructure (IaC, deployment)

→ Flag for **dual review** (SA + relevant role) AS PART OF the Hard set (cannot ship without dual sign-off).
→ For IaC: **plan-before-apply**. Destructive ops flagged.

## Completion summary format

```
AI Review Checklist (v0.7):
  Hard (blocking): [✓ Grounded · ✓ Trace-back · ✓ No secrets · ✓ Scope · ✓ Extension compliance]
  Soft (warnings): [✓ Style · ⚠ Edge cases · ✓ Error handling · ✓ Observable · ⚠ Docs]
  Risk-shaped: [N/A | Dual review: [SA + Designer signed off]]

  ⚠ Soft warnings:
  - [Edge cases] Test cases cover happy path but no boundary case for face_value max
  - [Docs] aidlc-docs/inception/audit.md not appended yet
```

Hard items showing ✗ → gate is NOT presented. Fix and re-run.
Soft items showing ⚠ → gate IS presented with warnings listed. User chooses Continue / Request Changes.

## Upgrading soft → hard

If a soft item is repeatedly ignored (≥ 3 stages in a row), QA / SA escalates to PM for promotion to Hard in next version.

## v0.6 → v0.7 transition

The "soft enforcement" model from v0.6 is replaced by this Hard/Soft split. Critical items that used to emit warnings now block. This is the methodology's response to "specs without verification is wishful thinking" — hard checks at the gate are the executable form of the trace-back contract.
