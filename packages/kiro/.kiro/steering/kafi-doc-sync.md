---
inclusion: manual
description: "Keep aidlc-docs/ in sync with src/ during Construction. Loads when code has changed and the unit's code-summary.md / tests-summary.md / frontend-components.md need regenerating, or when the user asks to refresh/sync docs. Used before Stage 14c so the conformance audit checks current docs, not stale ones."
---

# Skill: kafi-doc-sync

## Why this skill exists

In AI-DLC, `aidlc-docs/` is the live contract — Stage 14c audits code against it. If code changes after the docs were written, the docs go stale and the audit checks the wrong thing. This skill regenerates the per-unit doc summaries from current `src/` so the contract stays true.

**Scope:** regenerate doc *summaries* that describe code. Does NOT touch upstream specs (PRD, requirements, view-model, data-model) — those are human-owned design intent; if code diverges from them, that's a Stage 14c ✗, not a doc-sync.

## When to run

- After Stage 14a (production code) or 14b (test code) when files changed since the summaries were written
- Before invoking Stage 14c (so the audit sees current docs)
- When the user says "sync docs", "update the doc summaries", "docs are stale"

## What it regenerates

For the active unit, under `aidlc-docs/construction/{unit}/code/`:

| Doc | Regenerated from | Rule |
|---|---|---|
| `code-summary.md` | scan `src/` for the unit | what was built · structure · conventions · component → mockup map (UI) |
| `tests-summary.md` | scan `src/**/*.test.*` | functions covered · TC-NN → test mapping · framework · skipped (with rationale) |
| `frontend-components.md` (the Stage 10 doc) | reconcile against actual components in `src/` | flag any component in code not in the doc, or vice versa — report, don't silently rewrite design intent |

## Steps

1. Identify the active unit (from `aidlc-state.md` or user).
2. Enumerate `src/` files belonging to the unit (per `code-summary.md` file-inventory or module path).
3. For each doc above, diff current reality vs the doc:
   - **Summary docs** (`code-summary`, `tests-summary`): regenerate to match `src/`.
   - **Design-derived docs** (`frontend-components.md`): do NOT overwrite — emit a drift report listing mismatches for human/Stage-14c resolution.
4. Write a `doc-sync-report.md` noting what was regenerated + any design-doc drift surfaced.
5. Update `audit.md` with the sync event.

## Do

- Regenerate summary docs to match code exactly
- Surface (don't silently fix) divergence between code and design-intent docs
- Keep the component → mockup map current for UI units

## Don't

- Don't rewrite upstream specs (view-model, data-model, prd, requirements) — divergence there is a Stage 14c finding
- Don't mark TC-NN status (that's execution, out of AI-DLC scope)
- Don't invent coverage in tests-summary that isn't in `src/`

## References

- Stage: `.kiro/steering/construction/code-generation.md` (14a) · `unit-test-generation.md` (14b) · `conformance-audit.md` (14c)
- Pillar 2 of the methodology: documents kept up-to-date
