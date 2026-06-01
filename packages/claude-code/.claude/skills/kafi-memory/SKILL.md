---
name: kafi-memory
description: Long-term learning — scan recent git history to extract repeated patterns, idioms, anti-patterns, and recurring fixes, then surface candidate skills / ADRs / review-checklist items for human curation. Loads when the user asks to "extract learnings", "what patterns are we repeating", "mine git history", or after a postmortem. Read-only suggestion engine — never auto-writes skills.
inclusion: manual
---

# Skill: kafi-memory

## Why this skill exists

KAFI runs many AI-DLC projects. The same idioms, the same mistakes, the same fixes recur — but the knowledge stays trapped in individual repos + people's heads. This skill mines git history + project artifacts to surface patterns worth promoting to org-level knowledge: new skills, new ADRs, new review-checklist items, glossary terms.

**Read-only + human-in-the-loop.** It SUGGESTS; it never auto-creates skills or rewrites rules. A human curates what gets promoted. (Auto-creation is deliberately out of scope — see Out of scope.)

## What it mines

- **Recent commits** — `git log` + diffs over a window (default last 30 days or last N commits)
- **Conformance reports** — recurring Stage 14c ✗ patterns (same sub-check failing repeatedly)
- **Postmortems** — `postmortem.md` action items + 5-whys root causes
- **ADRs** — decisions that keep getting re-litigated
- **Open items** — recurring unresolved question shapes

## What it surfaces (candidates only)

| Candidate type | Signal | Where it would go (if a human promotes it) |
|---|---|---|
| New skill | same manual pattern done ≥3 times | `.claude/skills/kafi-<name>/` (human authors) |
| New ADR | same trade-off decided repeatedly | `adrs/ADR-NN` |
| Review-checklist item | same Stage 14c ✗ recurring | `common/ai-review-checklist.md` Hard/Soft |
| Glossary term | same term defined ad-hoc in multiple docs | `glossary.md` |
| Code-review rule | same lint/pitfall flagged across reviews | `kafi-code-review-<lang>` hot-spots |
| Test-case pattern | same boundary/edge missed repeatedly | `test-cases.md` derivation rules |

## Steps

1. Determine window (default: 30 days / last 50 commits; user can override).
2. Collect: `git log --stat` + diffs, `conformance-report.md` files, `postmortem.md` files, recent ADRs, open-items.
3. Cluster by recurrence — a pattern needs ≥3 occurrences to be a candidate (avoid noise).
4. For each cluster, write a candidate entry: pattern · evidence (commit/file refs) · proposed promotion · rationale.
5. Append to `00-knowledge/learnings/<YYYY-MM-DD>.md` (per-project log).
6. For org-level candidates, produce a separate `org-promotion-candidates.md` the Transformation Office reviews.

## Do

- Require ≥3 occurrences before calling something a pattern
- Cite evidence (commit SHA, file:line, report) for every candidate
- Separate per-project learnings from org-level promotion candidates

## Don't

- Don't auto-create skills, ADRs, or rules — suggest only
- Don't promote a one-off as a pattern
- Don't include PII / secrets found in history in the learnings doc (flag separately + privately)

## Out of scope

- **Auto-skill-creation** from history (the ECC `skill-create` pattern) — deferred; KAFI keeps humans in the loop for now.

## References

- Inspired by ECC `continuous-learning-v2`
- Related: `postmortem.md` · `ai-review-checklist.md` · `glossary.md` · ADRs
- Pillar: long-term organizational learning on top of per-project AI-DLC
