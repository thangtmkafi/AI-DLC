---
inclusion: manual
description: "KAFI AI-DLC onboarding · use when user just unzipped the package, asks where to start / what stage they are at, mentions /init, or wants to scan 00-knowledge/ to classify project state across the 17-stage workflow"
---

# KAFI AI-DLC Onboarding Skill

> Front-loads Stage 1 (Workspace Detection) for users who haven't started the workflow yet.

---

## `/init` behavior note (not destructive, but redundant)

If the IDE in use offers an `/init` command (Claude Code, Cursor, etc.), modern implementations are designed to be **complementary** — they scan the codebase and *suggest* updates to existing `AGENTS.md` / `CLAUDE.md`, rather than overwriting. Selective merge is the user's call.

That said, on an AI-DLC project `/init` is **unnecessary**:

- `AGENTS.md` already contains the complete 17-stage workflow spec.
- Kiro auto-loads `AGENTS.md` and all `inclusion: always` steering files on every session start — no init step needed.
- `/init` suggestions may pull workflow content toward generic project conventions (e.g., adding build commands, test instructions) which can dilute the methodology focus if accepted blindly.

**If the user mentions `/init`:**

1. Explain it's redundant on an AI-DLC project — `AGENTS.md` is already loaded.
2. Offer this skill's stage detection instead — more useful for orientation.
3. If user wants to run it anyway, remind them to **review each suggested diff carefully** before accepting — especially anything that touches the AI-DLC workflow content.
4. If `AGENTS.md` was modified in a way that diluted the workflow, restore from the original zip or `git checkout` the file.

---

## When to engage this skill

Trigger this skill when:
- User just unzipped AI-DLC and asks how to start.
- User asks "what stage am I at" / "where am I" / "where do I begin".
- User mentions copying legacy artifacts (BRDs, PRDs, mockups, code dumps) into the project.
- User mentions `/init` or asks whether they should run it (it is redundant — explain why).
- `00-knowledge/` is missing or empty AND no `aidlc-docs/` exists.
- `ai-dlc/project.md` is missing.
- `aidlc-state.md` is missing OR shows status that contradicts visible artifacts.

---

## Decision tree — which mode are you in?

```
Q1 · Is the AI-DLC structure intact?
  Check: AGENTS.md, .kiro/steering/, .kiro/templates/ all present?
  NO  → Tell user to re-unzip the AI-DLC package. Exit skill.
  YES → Q2

Q2 · Does aidlc-docs/aidlc-state.md exist?
  YES → Mode C · Resume from state file (verify against artifacts)
  NO  → Q3

Q3 · Does 00-knowledge/ exist with at least one file?
  NO  → Mode A · Fresh install setup wizard
  YES → Mode B · Stage detection from legacy artifacts
```

---

## Mode A · Fresh install setup wizard

For users who just unzipped AI-DLC into a project root and have **nothing** in `00-knowledge/` yet.

### Step 1 · Confirm structure

Run:
```bash
ls AGENTS.md .kiro/steering/ .kiro/templates/
```

Expected: all three exist. If any missing, ask user to re-extract the package.

### Step 2 · Where to put legacy artifacts

Tell user:
> "Drop any existing project materials into `00-knowledge/`:
> - Business docs (BRDs, PRDs, vision drafts) → `00-knowledge/product/`
> - Architecture docs → `00-knowledge/architecture/`
> - Domain glossary, conventions → `00-knowledge/conventions/`
> - Open decisions register → `00-knowledge/open-items.md`
> - Phase definitions (if multi-phase) → `00-knowledge/phases.md`
>
> Code samples go to `src/`, not `00-knowledge/`. Generated AI-DLC artifacts will land in `aidlc-docs/` automatically — don't pre-create it."

### Step 3 · Create `ai-dlc/project.md`

Guide user to create `ai-dlc/project.md` using this template (do NOT write the file for them — let them author):

```markdown
# Project Metadata

**Name:** <project-name>
**Phase:** <e.g. Phase 0 — Foundation>
**Started:** <YYYY-MM-DD>

## Source-of-Truth Precedence
1. `00-knowledge/architecture/` — canonical architecture
2. `00-knowledge/product/` — BRD / PRD / business requirements
3. Vision + Tech Env in `aidlc-docs/inception/discovery/`

## Active Extensions
- `audit-trail` — always enforced
- `personal-data-privacy` — opt-in (auto on PII detection)
- `architecture-boundaries` — define in 00-knowledge/conventions/
- `naming-conventions` — define in 00-knowledge/conventions/
```

### Step 4 · Hand off to workflow

Tell user:
> "Setup complete. Close this skill and start a fresh prompt. The agent will load `AGENTS.md` automatically, run Stage 1 (Workspace Detection), and route you to the right starting point. No `/init` needed — `AGENTS.md` is already loaded."

---

## Mode B · Stage detection from legacy artifacts

For users with legacy materials in `00-knowledge/` but no `aidlc-docs/` yet.

### Step 1 · Inventory

Run these in parallel:

```
Glob: 00-knowledge/**/*
Glob: aidlc-docs/**/*
Glob: src/**/*    (just count, don't list all)
Glob: ai-dlc/*
Glob: adrs/*
```

Read if exists:
- `ai-dlc/project.md`
- `aidlc-docs/aidlc-state.md`
- `00-knowledge/phases.md`
- `00-knowledge/open-items.md`

### Step 2 · Categorize legacy files

For each file in `00-knowledge/`, classify:

| Category | Heuristics (filename + content scan) |
|---|---|
| Business · BRD/PRD | "brd", "prd", "business requirement", "product requirement" |
| Vision draft | "vision", "intent", "mission", "objective" |
| User research | "persona", "journey", "interview", "user research" |
| Architecture | "architecture", "system design", "data flow", ".arch.", ERD diagrams |
| Design | mockup, wireframe, "design", Figma exports, image files |
| Code samples | `.ts`, `.py`, `.java`, source extensions |
| Compliance | "audit", "compliance", "TT 96", "PDPA", "Decree 13" |
| ADR | "adr-", "decision-record" |

### Step 3 · Apply stage rubric

[See `## Stage detection rubric` below.]

### Step 4 · Output classification

Use the output format below. Always include:
- Inventory summary
- Detected stage with reasoning citing specific files
- What's already complete (if any)
- Suggested next stage
- Exact next-prompt for user to paste

---

## Mode C · Resume with existing state file

If `aidlc-docs/aidlc-state.md` exists:

1. Read it.
2. Cross-check the claimed stage against what's actually in `aidlc-docs/`:
   - State says Stage 4 pending but `requirements.md` (or `prd-*.md`) exists → state drifted (see `process-overview.md` step 9). Update state file to match reality, then proceed.
   - State says complete but `aidlc-docs/` is empty → stale state file from prior project. Re-detect via Mode B.
3. If state and reality agree, present resume per `session-continuity.md`:
   - `Status: awaiting-approval` → re-present last completion message
   - `Status: execution` → load stage rule file, continue
   - `Status: planning` → re-display plan + last questions

---

## Stage detection rubric

Order matters — apply top-down, first match wins.

| Files / signals found | Detected position | Recommended next |
|---|---|---|
| AI-DLC structure intact, `00-knowledge/` empty, no `aidlc-docs/` | Brand new install, no inputs | Mode A · Setup wizard |
| Only intent/brief text in `00-knowledge/` (no formal BRD/PRD) | Pre-Inception · Sub-flow D (author-from-brief) | Author Vision Document from brief |
| Legacy BRD/PRD in `00-knowledge/product/`, no `vision.md` | Pre-Inception · Sub-flow C (map-existing) | Validate legacy BRD against AI-DLC Vision template |
| `vision.md` drafted in `00-knowledge/` but not in `aidlc-docs/inception/discovery/` | Pre-Inception · Sub-flow B (fill-gaps) | Move/refine Vision + add Technical Environment |
| Vision exists, `src/` has substantial code (brownfield), no `aidlc-docs/` | Pre-Inception then Stage 3 | Sub-flow A/B/C + queue Stage 3 Reverse Engineering |
| `aidlc-docs/inception/discovery/vision.md` AND `technical-environment.md` exist | Stage 2 complete (KB Context loaded) | Stage 4 (Requirements Analysis · PM — produces PRD + Requirements) |
| `prd-*.md` exists in `aidlc-docs/inception/requirements/` but `requirements.md` does NOT | Stage 4 in progress (PRD step 6a done, REQ step 6b pending) | Continue Stage 4 — derive REQ-NN from PRD-NN |
| `requirements.md` exists in `aidlc-docs/inception/requirements/` (with or without `prd-*.md`) | Stage 4 complete | Stage 5 (User Stories · BA) if user-facing, else Stage 6 |
| `stories.md` exists | Stage 5 complete | Stage 6 (Workflow Planning · PM) |
| `execution-plan.md` exists | Stage 6 complete | Stage 7/8/9 per plan |
| `product-design/mockups/*.html` exist (+ `mockups/index.md`) | Stage 7 complete — HTML mockups are FE source of truth for Stage 14 | Stage 8 (Application Design · SA) |
| `application-design/` pack exists, no units | Stage 8 complete | Stage 9 (Units Generation · SA) |
| `unit-of-work*.md` files exist | Stage 9 complete | Construction begins |
| `aidlc-docs/construction/UNIT-NN/functional-design/` exists for any unit | Stage 10 in progress (per unit · SA) | Stage 11 (NFR Requirements) for that unit |
| Per-unit `nfr-requirements/` + `nfr-design/` exist, no code | Stages 11-12 complete for unit | Stage 13 (Infrastructure) or Stage 14 (Code Generation) |
| `code/` summaries exist per unit | Stage 14 complete for unit | Next unit OR Stage 15 (Build) |
| `aidlc-docs/construction/build/` exists | Stage 15 complete | Stage 16/17 (Operations — still placeholder in v0.5) |
| Inconsistency: `aidlc-state.md` says Stage N, but Stage N+M artifacts exist | State drift detected | Reconcile state file first, then continue |

---

## Stage → Role → Prompt template mapping

When Mode B detects a stage, load the corresponding prompt template from `kafi-aidlc-onboarding-prompts/` and paste it **verbatim** into the agent session start (replacing placeholders with detected context).

| Detected position | Prompt template file |
|---|---|
| Pre-Inception D (author-from-brief), Stage 4 (Requirements), Stage 6 (Workflow Planning) | `pm-stage-4-requirements.md` |
| Pre-Inception B/C (fill-gaps / map-existing), Stage 5 (User Stories) | `ba-stage-5-stories.md` |
| Stage 3 (Reverse Engineering), Stage 8 (Application Design), Stage 9 (Units Generation), Stage 10 (Functional Design), Stage 11 (NFR Requirements), Stage 12 (NFR Design) | `sa-stage-8-app-design.md` |
| Stage 7 (Product Design) | `designer-stage-7-product-design.md` |
| Stage 14 (Code Generation), Stage 15 (Build) | `dev-stage-14-code-gen.md` |
| Stage 13 (Infrastructure Design) | `devops-stage-13-infra-design.md` |

## Prompt template loading protocol

After Mode B detects current stage:

1. Look up the matching template file from the mapping table above
2. Read the template file from `.kiro/steering/kafi-aidlc-onboarding-prompts/<file>.md`
3. Extract the prompt body (everything between `---` markers, excluding placeholder docs section)
4. Substitute placeholders from detected context:
   - `[PROJECT]` ← from `ai-dlc/project.md` Name field
   - `[Lite | Standard]` ← from `aidlc-state.md` Mode field
   - `[Stage N / Pre-Inception X]` ← from stage detection
   - `[unit-name]`, `[N]` ← if stage is per-unit (10-14), from detected UNIT folder
   - Other placeholders ← see template's own "Placeholders" section
5. Paste the substituted prompt as the **first message** of the new session (or include it directly in the Mode B completion message under "Ready-to-use prompt")
6. The user doesn't need to manually paste — agent applies the template internally

## Mode B output format

Use this template for the completion message:

```markdown
## AI-DLC Stage Detection · [ISO 8601 timestamp]

### Project inventory
- `00-knowledge/`: [N files] · key: [list 3-5 most relevant filenames]
- `aidlc-docs/`: [N files or "empty"] · key: [list AI-DLC artifacts found]
- `src/`: [code present: yes/no · approx N files]
- `ai-dlc/project.md`: [exists / missing]
- `aidlc-docs/aidlc-state.md`: [exists / missing / drifted]

### Detected position
**[Pre-Inception sub-flow X | Stage N — Name]**

Reasoning: [1-2 sentences citing which specific files indicated this — e.g., "Found `00-knowledge/product/treasury-brd-2025.md` (legacy BRD, 23 pages) but no `vision.md` anywhere — classic Sub-flow C (map-existing) starting point."]

### What's complete
- [Bulleted list of completed stages, or "Nothing yet — fresh start"]

### What's next
[1 sentence on the recommended next stage and why]

### Ready-to-use prompt (auto-loaded from template)
Agent has already loaded the matching prompt template from `kafi-aidlc-onboarding-prompts/<file>.md` and substituted placeholders. The session is ready to start — no manual paste needed.

If user wants to inspect / customize the prompt before starting, the verbatim content is:
```
[Full prompt body from kafi-aidlc-onboarding-prompts/<role>.md with placeholders substituted]
```

### Open items / inconsistencies
- [List any conflicts found, e.g., state file says Stage 4 but stories.md exists]
- [Or: "None"]
```

### Example output (illustrative)

```markdown
## AI-DLC Stage Detection · 2026-05-25T14:50:00+07:00

### Project inventory
- `00-knowledge/`: 12 files · key: `product/treasury-brd-2025-q4.md`, `architecture/system-context.md`, `conventions/naming.md`
- `aidlc-docs/`: empty
- `src/`: no code present
- `ai-dlc/project.md`: missing
- `aidlc-state.md`: missing

### Detected position
**Pre-Inception · Sub-flow C (map-existing)**

Reasoning: Found a 23-page legacy BRD (`product/treasury-brd-2025-q4.md`) plus architecture context, but no `vision.md` in `aidlc-docs/`. The Vision Document needs to be authored from this BRD with validation against the AI-DLC template — that is exactly the Sub-flow C charter.

### What's complete
- Project KB seeded in `00-knowledge/` (12 files)

### What's next
Run Pre-Inception Sub-flow C to validate the legacy BRD, then map it into the AI-DLC Vision Document at `aidlc-docs/inception/discovery/vision.md`.

### Ready-to-use prompt (auto-loaded)
Template selected: `kafi-aidlc-onboarding-prompts/ba-stage-5-stories.md` (Pre-Inception C requires BA-driven Vision mapping). Placeholders substituted from detected context. Session ready.

If you want to see the prompt the agent will use:
```
Your Role: You are an expert Business Analyst at KAFI Securities, tasked with mapping legacy BRD into AI-DLC Vision template...
(full prompt body, ~25 lines)
```

### Open items / inconsistencies
- `ai-dlc/project.md` not yet created — author this before starting workflow.
```

---

## Common gotchas to surface

1. **`/init` is redundant on AI-DLC projects** — it's complementary (suggests, doesn't overwrite), but `AGENTS.md` is already loaded. Encourage user to use this skill's stage detection instead.
2. **Files outside `00-knowledge/`** — the workflow won't pick up materials scattered in random folders. Tell user to consolidate.
3. **Multiple BRDs/PRDs with conflicts** — surface as open items per `00-knowledge/open-items.md`; never silently pick one.
4. **Code in `aidlc-docs/`** — wrong place. Code goes in `src/`. `aidlc-docs/` is for generated documentation only.
5. **State file claims Stage X but artifacts show Stage Y** — state drifted (see `process-overview.md` Anti-patterns). Reconcile state file before proceeding.
6. **User runs onboarding skill in a project that already has an active workflow** — Mode C handles this, don't reset progress.

---

## References

- `.kiro/steering/inception/workspace-detection.md` — Stage 1 detection logic (this skill front-loads it)
- `.kiro/steering/common/process-overview.md` — 10-step cycle including state file maintenance
- `.kiro/steering/common/session-continuity.md` — resume protocol
- `.kiro/steering/pre-inception/entry-router.md` — sub-flow routing logic
- `.kiro/steering/pre-inception/document-validator.md` — consent-first artifact classifier
- `packages/kiro/AGENTS.md` — workflow spec (the file `/init` would overwrite — protect it)
- `packages/kiro/README.md` §"How to use" — setup steps
