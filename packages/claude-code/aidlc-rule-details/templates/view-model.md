# View Model — [Screen Name]

> Stage 7 deliverable · Designer-owned · One per screen (sibling to `<screen>.html` mockup)
> Data-binding contract: every on-screen field bound to source entity.attribute with type, format, validation
> Stage 14c audit verifies generated FE code matches this spec

**Status:** Draft | Locked
**Owner:** [Designer name]
**Last updated:** [Date]
**Mockup file:** `mockups/[screen].html`
**Stories served:** US-NN, US-NN+1
**Target unit:** UNIT-NN
**Parent data-model:** `aidlc-docs/inception/application-design/data-model.md`

---

## 1. Screen summary

[1-2 sentences: what the user does on this screen + key info shown.]

## 2. Field bindings

The contract: every interactive or data-displaying element on the screen has an entry here.

| Field on screen | Type | Source (entity.attribute) | Format | Validation | State behavior |
|---|---|---|---|---|---|
| Bond face value | double | `Bond.face_value` (ENT-03) | VND · thousand separator `.` · 0 decimal places · e.g. `5.000.000.000` | min 1_000_000 · max 10_000_000_000 · numeric only | editable · required |
| Yield | float | `Deal.yield` (ENT-01) | percent · 4 decimal places · e.g. `7.2500%` | 0 ≤ x ≤ 100 · numeric only | editable · required |
| Settlement date | date | `Deal.settlement_date` (ENT-01) | DD/MM/YYYY | future date only · ISO 8601 internally | editable · required · date-picker |
| Tenor (years) | int | (computed from `settlement_date - issue_date`) | integer · e.g. `3` | derived | read-only · computed |
| Coupon dates | date[] | `Bond.coupon_dates` (ENT-03) | DD/MM/YYYY each, comma-separated list | derived | read-only · computed |
| Deal price | double | (computed) | VND · thousand separator `.` · 0 decimal places | — | read-only · computed |
| Status | enum | `Deal.status` (ENT-01) | localized label · color-coded | one of draft/pending/approved/settled/cancelled | read-only · badge component |
| Notes | string | `Deal.notes` (ENT-01) | plain text · max 500 chars | length ≤ 500 | editable · optional |

**Type vocabulary:** `string · int · double · float · date · datetime · bool · enum · array<T>`
**Format vocabulary:** declare units (VND/USD/%/days), separators (`.` thousand · `,` decimal), decimal places (0/2/4), date pattern (DD/MM/YYYY or ISO 8601), case (uppercase/title), max display length + truncation behavior.

## 3. Computations

For every field marked "computed" in §2, declare the formula.

- **Tenor (years)** = `floor((Bond.maturity_date - Bond.issue_date) / 365.25)`
- **Coupon dates** = `generate(Bond.issue_date, Bond.coupon_frequency, until Bond.maturity_date)`
- **Deal price** = `Bond.face_value × (1 - (Deal.yield / 100) × (days_to_maturity / 365))`
  - where `days_to_maturity` = `Bond.maturity_date - Deal.settlement_date`

Generated FE code MUST implement computations EXACTLY as declared here. Stage 14c audits.

## 4. State bindings

How each state changes the rendered output. Mockup HTML must include visuals for each state.

### default (happy path)
- All editable fields enabled
- Submit button enabled when validation passes
- Computed fields show calculated values
- Status badge shows current value

### empty (no data yet)
- Form is blank · placeholders shown per field
- Computed fields show `—` placeholder
- Submit button disabled

### loading (async fetch in progress)
- Skeleton shimmer on data-displaying fields
- Form disabled
- Spinner overlay or top-bar progress indicator

### error (validation OR server)
- Invalid field highlighted (border color: `--kafi-color-error-500`)
- Error message below field (`--kafi-type-caption` weight, `--kafi-color-error-700` text)
- Toast/banner for server errors with retry CTA
- Submit button disabled until errors resolved

### disabled (read-only mode, e.g. settled deals)
- All fields read-only · no border/background change but cursor `not-allowed`
- Submit button hidden
- Status badge shows terminal state

### (other states relevant to this screen — declare each)

## 5. Actions / events

Buttons + form events that change state. Each cites the domain operation it triggers.

| Action / event | Trigger | Domain operation | Pre-conditions | Post-state |
|---|---|---|---|---|
| Submit | Submit button click | `Deal.submit()` (ENT-01) | All required fields valid | status: draft → pending |
| Save draft | "Save draft" button | Direct write to `Deal.notes`, etc. | None | stays draft |
| Cancel | "Cancel" button | `Deal.cancel(reason)` (ENT-01) | Prompt user for reason | status: any → cancelled |
| Change settlement_date | Field blur | Re-compute Tenor + Coupon dates + Deal price | Valid date | Computed fields refreshed |

## 6. Accessibility notes (per screen)

- All form fields have accessible labels (`<label for>` or `aria-label`)
- Required fields announced via `aria-required`
- Validation errors associated via `aria-describedby`
- Logical tab order matches visual order
- Color is NOT the only signal for error/success (also icon + text)

## 7. Open items

- Open — pending [owner]: [decision needed re: this screen] · See `00-knowledge/open-items.md#[id]`

---

## Audit hook (Stage 14c · Code audit · UI audit · Token discipline)

Stage 14c audit verifies:
- Every field in §2 is rendered in generated FE with correct entity.attribute binding
- Every format string in §2 is applied (e.g., VND grouping, % precision, date pattern)
- Every validation rule in §2 is enforced client-side
- Every computation in §3 is implemented with the declared formula
- Every state in §4 is rendered (default · empty · loading · error · disabled · …)
- Action handlers in §5 invoke the declared domain operation
- Color tokens used match `design-tokens.md` (NOT hex literals)

Any divergence ⇒ Request Changes (blocking).

KB cited: `data-model.md` (ENT-NN) · Stage 7 mockup HTML · design-tokens.md · interaction-specs.md
Related: `mockups/[screen].html` · `mockups/index.md` · per-unit `frontend-components.md` · per-unit `test-cases.md`
