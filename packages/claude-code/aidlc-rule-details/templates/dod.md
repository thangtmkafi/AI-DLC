# Definition of Done — [Stage / Unit / Phase]

> Generic DoD template used as approval-gate rubric at every stage completion.
> Per-stage extension points let stage rules add specific items.

**Applies to:** [Stage NN | UNIT-NN | Phase N]
**Owner:** [the stage / unit / phase owner]

---

## Universal DoD (every stage)

- [ ] **All declared outputs produced** — every file listed in stage's "Outputs" section exists at the declared path
- [ ] **Specs cited** — every output cites the upstream parent spec(s) it derives from (PRD-NN / REQ-NN / US-NN / ENT-NN / UNIT-NN / TC-NN)
- [ ] **Open items surfaced** — every "Open — pending [owner]" entry has an owner + linked KB section (no fabricated answers)
- [ ] **Extension compliance** — applicable extensions (audit-trail, privacy) declare compliance status
- [ ] **AI Review Checklist** — hard items pass; soft warnings listed if any
- [ ] **`audit.md` updated** — this stage's audit log entry appended
- [ ] **`aidlc-state.md` updated** — per process-overview.md state-file maintenance rules

## Per-stage additions

[Stage rules append items relevant to their stage here. Examples:]

### Stage 4 (Requirements Analysis) example

- [ ] Every PRD-NN has measurable success criteria (numbers, not adjectives)
- [ ] Every REQ-NN cites parent PRD-NN
- [ ] Every REQ touching open items emits "Open — pending [owner]"

### Stage 7 (Product Design) example

- [ ] `design-tokens.md` exists with overrides + WCAG notes
- [ ] `uiux-spec.md` exists with coverage matrix
- [ ] Every key screen has paired `<screen>.html` + `<screen>.view-model.md`
- [ ] Mockup CSS uses only declared tokens (no hex literals)
- [ ] Coverage matrix: every user-facing US-NN has ✓ Covered screen

### Stage 10b (Unit Test Planning) example

- [ ] `test-plan.md` exists with scope, framework, coverage targets
- [ ] `test-cases.md` exists with TC-NN entries
- [ ] Every required item from `test-plan.md` §4 coverage targets has ≥1 TC-NN
- [ ] QA + SA sign-off recorded

### Stage 14a (Production Code Generation) example

- [ ] Code in `src/` only (never inside `aidlc-docs/`)
- [ ] No hardcoded secrets (env vars only)
- [ ] Architecture boundaries respected (no cross-boundary imports without ADR)
- [ ] Audit-trail extension wiring confirmed
- [ ] Privacy extension wiring confirmed (if PII touched)

### Stage 14b (Unit Test Code Generation) example

- [ ] Every exported function has corresponding test file
- [ ] Every TC-NN in `test-cases.md` has corresponding test in code
- [ ] Test framework matches `test-plan.md` declaration
- [ ] `tests-summary.md` lists coverage + skipped items with rationale

### Stage 14c (Conformance Audit) example

- [ ] Code audit ✓ — boundaries · data-model conformance · view-model bindings
- [ ] Token discipline audit ✓ — no ad-hoc hex/px in FE code
- [ ] UI audit ✓ — mockup fidelity screen-by-screen + all states rendered
- [ ] Test code coverage audit ✓ — every function tested · every TC-NN coded
- [ ] `conformance-report.md` written with sub-check details

### Phase delivery (post-Stage 17) example

- [ ] Every stage gate in this phase passed without unresolved Request Changes
- [ ] `aidlc-state.md` shows all stages in phase as Complete
- [ ] Open items remaining all assigned + tracked in `00-knowledge/open-items.md`
- [ ] Retrospective scheduled (Stage 18 if extension active)

---

## How to use this template

1. Stage rule references this template ("DoD = `templates/dod.md` + Stage NN additions").
2. Stage's 2-option completion message lists the Universal DoD items + Per-stage additions as a checklist.
3. All checkboxes must be ✓ before "Continue" advances the gate. Unchecked → Request Changes.
4. AI agent runs through the list before presenting the gate.

KB cited: `process-overview.md` · `ai-review-checklist.md` · stage-specific rule files
Related: `audit.md` (records DoD completion per stage) · `aidlc-state.md`
