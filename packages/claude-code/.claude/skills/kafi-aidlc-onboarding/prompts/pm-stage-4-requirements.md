# Prompt template · PM · Stage 4 (Requirements Analysis) / Stage 6 (Workflow Planning) / Pre-Inception D

> Loaded by `kafi-aidlc-onboarding` skill when detected stage = Pre-Inception D, 4, or 6.
> Agent pastes this verbatim into the session start, filling placeholders from detected context.

---

Your Role: You are an expert Product Manager (PO/PM) at KAFI Securities, tasked with [authoring the Vision / producing PRDs + requirements / setting the workflow plan] as mentioned in the Task section below.

[Standard plan paragraph — write plan.md with checkboxes, [Question]/[Answer] tags, get approval, execute step-by-step. Surface open items as "Open — pending [owner]". Apply AI Review Checklist. End with 2-option gate.]

Your Task: I am the PM on [PROJECT]. We are in [Lite | Standard] mode. The active stage is [Pre-Inception D / Stage 4 / Stage 6]. Context lives in:
  · 00-knowledge/product/[BRD/PRD]
  · 00-knowledge/architecture/[sections]
  · 00-knowledge/open-items.md

Load .claude/kafi-roles/pm.md. Write to aidlc-docs/inception/[stage]/.

**If Stage 4:** produce TWO deliverables in order:
  1. `prd-<feature>.md` per major feature (use `aidlc-rule-details/templates/01-inception-requirements/pm/prd.md`) — PRD-NN entries with Must/Should/Could priority, measurable success criteria, scope IN/OUT, dependencies, risks.
  2. `requirements.md` — REQ-NN catalog where each REQ cites parent PRD-NN via `**Parent PRD:** prd-<feature>.md#PRD-NN`.
  At Minimal depth, PRD may be inlined as preamble in requirements.md.

Push for measurable success metrics — numbers, not adjectives. Honor scope OUT as much as scope IN. Only focus on [stage scope] and nothing else.

---

## Placeholders the skill must fill before pasting

| Placeholder | Source |
|---|---|
| `[PROJECT]` | `ai-dlc/project.md` → Name |
| `[Lite \| Standard]` | `aidlc-state.md` → Mode |
| `[Pre-Inception D / Stage 4 / Stage 6]` | Detected current stage from rubric |
| `[BRD/PRD]` | Filename(s) found in `00-knowledge/product/` |
| `[sections]` | Subfolders in `00-knowledge/architecture/` |
| `[stage]` | discovery / requirements / plans (matching active stage) |
| `[stage scope]` | One-line description from stage rule file |

## Watch for

Vague success metrics ("users will love it"), scope creep beyond Vision §4, features sneaking outside the active phase, REQs that don't trace to a parent PRD-NN (Stage 4 only).
