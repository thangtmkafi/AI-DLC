# Test Cases — UNIT-NN [Unit name]

> Stage 10b deliverable · QA-owned · Per-unit catalog
> Each TC-NN is a documented test scenario · status filled at execution time (outside AI-DLC)
> Companion: `test-plan.md` (strategy)

**Status:** Draft | Approved
**Owner:** [QA name]
**Last updated:** [Date]
**Unit:** UNIT-NN · [name]

---

## Coverage summary

Filled when catalog complete. Cross-checks coverage targets from `test-plan.md` §4.

| Upstream spec | Required | Covered | Gap |
|---|---|---|---|
| REQ-01, REQ-02, REQ-03 | 3 | 3 | — |
| US-03 ACs (3 AC) | 3 | 3 | — |
| view-model fields (Deal capture, 8 fields) | 8 × (format + validation + boundary) = 24 cases | 24 | — |
| view-model states (5) | 5 | 5 | — |
| Domain ops (`submit`, `approve`, `cancel`) | 6 (happy + failure each) | 6 | — |

---

## Case catalog

### TC-01: [Short case name]

**Type:** Unit | Integration | UI | NFR | Contract
**Cites:** REQ-NN · US-NN-ACx · PRD-NN · view-model field "[name]" · domain op "[name]"
**Priority:** Must | Should | Could
**Status:** Pending | Pass | Fail | Blocked  (← filled at execution time, NOT by AI-DLC)

**Preconditions:**
- [State of the system before this test]
- [Required fixtures / data]
- [User role logged in: viewer / trader / approver / admin]

**Given:** [initial state · in user-visible terms]

**When:** [action taken]

**Then:** [expected observable outcome]
- [Specific assertion 1]
- [Specific assertion 2]

**Test data:**
- [Field 1]: [value]
- [Field 2]: [value]

**Notes:** [edge cases, references to bug history, dependent TCs]

---

### TC-02: [Next case]

[Same shape]

---

### TC-03: [Boundary case — derived from view-model validation]

**Type:** Unit
**Cites:** view-model field `face_value` (range 1M-10B)
**Priority:** Must
**Status:** Pending

**Preconditions:** User on Deal capture screen · authenticated as trader

**Given:** the form is open in default state

**When:** user enters `face_value = 999999` (below minimum) and tabs out

**Then:** the field shows error state
- Border color uses `--kafi-color-error-500`
- Error message reads "Face value must be at least 1,000,000 VND"
- Submit button is disabled

**Test data:** `face_value = 999999`

**Notes:** Pair with TC-04 (`face_value = 1000000`) for boundary lower-bound pass.

---

### TC-04: [Format rendering case — derived from view-model format]

**Type:** UI
**Cites:** view-model field `face_value` (format: VND · thousand sep `.` · 0 decimals)
**Priority:** Must
**Status:** Pending

**Given:** Deal capture screen rendered with `face_value = 5000000000` from server

**When:** the field is rendered

**Then:** display shows `5.000.000.000` (Vietnamese thousand grouping, no decimals, no currency symbol prefix unless designed)

**Test data:** seed `face_value = 5000000000`

---

### TC-05: [State transition case — derived from view-model states]

**Type:** UI
**Cites:** view-model state "loading"
**Priority:** Should
**Status:** Pending

**Given:** Deal capture screen, user clicks Submit

**When:** API call is in-flight (latency > 100ms)

**Then:**
- Form fields become disabled
- Submit button shows spinner inline
- No additional clicks register on Submit

---

### TC-N: [Negative case — derived from business-rules]

**Type:** Unit
**Cites:** business-rules `cannot approve own deal`
**Priority:** Must
**Status:** Pending

**Preconditions:** Deal in `pending` status, owned by user U1, user U1 logged in

**Given:** U1 attempts to approve deal owned by U1

**When:** `Deal.approve(by: U1)` is invoked

**Then:**
- Operation rejects with error code `SELF_APPROVAL_FORBIDDEN`
- Deal status remains `pending`
- AuditEvent emitted with reason

---

## Case derivation rules

When authoring cases at Stage 10b, systematically derive from upstream specs:

1. **From REQ-NN acceptance criteria:** 1 happy + 1-2 failure cases each
2. **From US-NN Given/When/Then:** 1:1 mapping per AC
3. **From view-model fields:** for each field
   - 1 format-rendering case (default value displayed correctly)
   - 1 lower-boundary case (just-valid + just-invalid)
   - 1 upper-boundary case (just-valid + just-invalid)
   - 1 validation-failure case (wrong type, empty, etc.)
4. **From view-model states:** 1 case per state showing correct rendering
5. **From view-model computations:** 1 case verifying formula correctness + ≥1 edge case
6. **From domain operations:** 1 happy + 1 each failure (pre-condition / invariant violation)
7. **From business-rules:** 1 case per rule
8. **From NFR thresholds:** 1 case per threshold (perf, security, accessibility)

This ensures Stage 14b can mechanically derive test code from this catalog.

---

KB cited: `test-plan.md` · functional-design · view-model · business-rules · NFR-design
Related: `tests-summary.md` (Stage 14b output) · `conformance-report.md` (Stage 14c)
