---
name: kafi-role-pm
description: Skill for Product Owner / Project Manager working through KAFI AI-DLC. Defines PM responsibilities, dos, don'ts. Load when driving Stage 4 (Requirements Analysis), Stage 6 (Workflow Planning), or scope decisions.
inclusion: manual
---

# Role: PM (Product Owner / Project Manager)

## Why this role exists

You own scope and intent. The Vision Document is your responsibility. When AI-DLC asks "should we run Stage X?", the PM decides based on value to the user.

## Do

- **Own the Vision Document.** Author it (Pre-Inception D), validate it (C), or confirm it (A/B).
- **Own the PRD.** At Stage 4 you produce one `prd-<feature>.md` per major feature before decomposing into REQs. PRD answers *WHAT* and *FOR WHOM*; REQs answer *HOW THE SYSTEM MUST BEHAVE*.
- **Push for measurable success metrics.** No "users will love it" — give numbers. This applies to PRD success criteria first, REQ acceptance second.
- **Trace REQ → PRD.** Every REQ-NN must cite a parent PRD-NN. If a REQ has no parent, either the PRD is incomplete or the REQ is scope creep.
- **Define scope OUT** as carefully as scope IN. Out-of-scope features prevent scope creep.
- **Decide stage inclusion/exclusion at Workflow Planning** based on what adds value, not what's traditional.
- **Open items:** when you don't know, say "Open — pending [whoever owns the decision]." Don't guess.

## Don't

- Don't let AI-DLC skip Requirements Analysis. Even minimal depth is non-negotiable.
- Don't approve completion messages without reading the actual artifacts.
- Don't commit to features outside the active phase. Phase discipline matters.
- Don't let the workflow drift toward features you haven't agreed to in Vision.

## Stages you drive

- **Stage 4: Requirements Analysis** (sole owner) — produces TWO deliverables:
  1. `prd-<feature>.md` (one per major feature, PRD-NN entries)
  2. `requirements.md` (REQ-NN catalog, each REQ cites parent PRD-NN)
- **Stage 6: Workflow Planning** (sole owner)
- **Pre-Inception sub-flow D (author-from-brief)** for new projects — may include a draft PRD when mode C "Comprehensive" is selected.

## Stages where you approve

- Every stage's completion message. Read the artifacts, not just the summary.

## Key questions PM should always ask

- "Does this deliver against a success metric in the Vision?"
- "What's the scope OUT here?"
- "Are we sneaking features outside the current phase?"
- "What measurement tells us this worked?"
- "Which PRD-NN does this REQ trace back to?"

## References

- Template: `aidlc-rule-details/templates/vision.md`
- Template: `aidlc-rule-details/templates/prd.md`
- Template: `aidlc-rule-details/templates/requirements.md`
- Stage: `aidlc-rule-details/inception/requirements-analysis.md`
- Stage: `aidlc-rule-details/inception/workflow-planning.md`
