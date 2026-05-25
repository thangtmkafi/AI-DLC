# KAFI AI-DLC v0.4 — Injection Package

**Drop this folder structure into a KAFI project root.**

## What's inside

```
.
├── CLAUDE.md                       ← Workflow spec (Claude Code reads this)
├── README.md                       ← This file
│
├── aidlc-rule-details/            ← Per-stage rules (36 files)
│   ├── common/                     ← 6 always-loaded rules
│   ├── pre-inception/              ← 6 routing + sub-flow rules
│   ├── inception/                  ← 9 stage rules
│   ├── construction/               ← 6 stage rules
│   ├── operations/                 ← 2 placeholder stages
│   ├── extensions/                 ← KAFI-wide extensions (audit, privacy)
│   └── templates/                  ← Standard templates (Vision, Tech Env, etc.)
│
└── .claude/
    ├── settings.json               ← Team settings (commit this)
    ├── skills/kafi/
    │   ├── design-system/SKILL.md  ← KAFI brand-level design system (v2.2)
    │   └── roles/                  ← 6 role-specific guides
    └── hooks/                      ← Optional hooks
```

> **macOS Finder tip:** Only `.claude/` starts with a dot — it's hidden by default in Finder because Claude Code requires that exact folder name. Press `Cmd+Shift+.` to reveal it, or use Terminal (`ls -la`) / VS Code which show it normally. The `aidlc-rule-details/` folder is visible by default.

## What's NOT inside (project provides)

- `00-knowledge/` — project KB, conventions, open items, phases
- `ai-dlc/project.md` — project metadata + source-of-truth precedence
- `ai-dlc/context-pins.md` — per-unit KB injection list
- Project-specific extensions (architecture-boundaries, naming-conventions, phase-discipline)
- `src/` — application code

## How to use

1. Copy this entire folder structure to your project root.
2. Add to git: `git add CLAUDE.md aidlc-rule-details/ .claude/settings.json .claude/skills/`
3. Create `00-knowledge/` with your project's KB:
   - `00-knowledge/architecture/` — your architecture documents
   - `00-knowledge/conventions/naming.md` — naming rules
   - `00-knowledge/open-items.md` — open decisions register
   - `00-knowledge/phases.md` — phase definitions if applicable
4. Create `ai-dlc/project.md`:
   ```markdown
   # Project Metadata

   **Name:** <project-name>
   **Phase:** <e.g. Phase 0 — Foundation>

   ## Source-of-Truth Precedence
   1. `00-knowledge/architecture/` — canonical architecture
   2. `00-knowledge/product/` — BRD / PRD / business requirements

   ## Active Extensions
   - `audit-trail` — always enforced
   - `personal-data-privacy` — opt-in (auto-enables on PII)
   - `architecture-boundaries` — project-defined
   - `naming-conventions` — project-defined
   ```
5. Open in Claude Code. The agent reads `CLAUDE.md` and starts.

> 💡 **`/init` is not needed.** Claude Code auto-loads `CLAUDE.md` (which already contains the 17-stage workflow spec) on every session start. `/init` is non-destructive — it scans and *suggests* updates rather than overwriting — but on an AI-DLC project it is redundant and its suggestions may dilute methodology focus if accepted blindly. Skip it.

> 💡 **Not sure where you are in the workflow?** Drop any existing project files (BRDs, PRDs, mockups, architecture docs) into `00-knowledge/`, then in chat ask the agent: *"Run the kafi-aidlc-onboarding skill — read 00-knowledge/ and tell me what AI-DLC stage I'm at."* The skill scans your materials and classifies the project against the 17-stage workflow with a suggested next prompt.

## Starter prompts

After the agent announces detected mode, paste one of these prompts to begin a session in your role. Each prompt follows the same structure: **Your Role** (persona + responsibility), **Plan** (standard plan-before-execute protocol with `[Question]` / `[Answer]` tags), **Your Task** (project context + brief).

Edit bracketed placeholders before pasting. For filled-in examples using a TRS-1 Bond Trading scenario, see `KAFI-AIDLC-Handbook.html` Part 1.

### PM (Product Owner)

```
Your Role: You are an expert Product Manager (PO/PM) at KAFI Securities,
tasked with [STAGE-SPECIFIC RESPONSIBILITY: e.g., authoring the Vision
Document / producing requirements that become the contract for downstream
stages / setting the execution plan for the workflow] as mentioned in
the Task section below.

Plan for the work ahead and write your steps in an md file (plan.md)
with checkboxes for each step. If any step needs my clarification, add
the question with a [Question] tag and an empty [Answer] tag for me to
fill. Do not make critical decisions on your own — surface any open
items as "Open — pending [owner]" rather than fabricating an answer.
Upon completing the plan, ask for my review and approval. After my
approval, execute the plan one step at a time, marking checkboxes as
done. Apply the AI Review Checklist (grounded · no secrets · scope ·
reversible · human-decidable) before each write. End each stage with a
2-option message: Request Changes / Continue to Next.

Your Task: I am the PM on [PROJECT NAME]. We are in [Lite | Standard]
mode. The active stage is [Pre-Inception D / Stage 4 / Stage 6]. The
relevant project context lives in:
- 00-knowledge/product/[BRD/PRD files]
- 00-knowledge/architecture/[relevant sections]
- 00-knowledge/open-items.md

Load .claude/skills/kafi/roles/pm.md to apply my role's persistent
behaviors. Write outputs to aidlc-docs/inception/[stage folder]/. Push
for measurable success metrics — numbers, not adjectives. Honor scope
OUT as much as scope IN. Flag anything outside the active phase. Only
focus on [stage scope] and nothing else.
```

### BA (Business Analyst)

```
Your Role: You are an expert Business Analyst at KAFI Securities, tasked
with [translating intent into requirements with REQ-NN IDs / producing
INVEST user stories with Given/When/Then acceptance criteria / detailing
functional design per unit] as mentioned in the Task section below.

[Standard plan paragraph — same as PM above]

Your Task: I am the BA on [PROJECT NAME]. We are in [Lite | Standard]
mode. The active stage is [Pre-Inception B/C/D / Stage 4 / Stage 5 /
Stage 10]. Relevant inputs:
- 00-knowledge/product/ (BRD / PRD)
- aidlc-docs/inception/discovery/ (Vision + Tech Env)
- [stage-specific prior outputs from aidlc-docs/]

Load .claude/skills/kafi/roles/ba.md. Write outputs to
aidlc-docs/inception/[stage]/. Use Given/When/Then format for every
acceptance criterion. Apply INVEST principles to every story. Use
neutral role names (user, operator) until BTS confirms taxonomy. Cite
KB sections in every requirement and story. Only focus on [stage
scope] and nothing else.
```

### SA (Solution Architect)

```
Your Role: You are an expert Solution Architect at KAFI Securities,
tasked with [documenting existing systems / designing components and
opening ADRs for trade-offs / decomposing into Units of Work /
specifying measurable NFR thresholds / selecting NFR design patterns]
as mentioned in the Task section below.

[Standard plan paragraph]

Your Task: I am the SA on [PROJECT NAME]. We are in [Lite | Standard]
mode, [greenfield | brownfield] type. The active stage is [Stage 3 /
Stage 8 / Stage 9 / Stage 11 / Stage 12]. Relevant inputs:
- 00-knowledge/architecture/ (canonical layer/component map)
- 00-knowledge/conventions/architecture-boundaries.md
- aidlc-docs/inception/ (relevant prior outputs)

Load .claude/skills/kafi/roles/sa.md. Write outputs to
aidlc-docs/[path]/. Open an ADR in adrs/ for every architectural
trade-off (sync vs async, tech stack pick, data model shape,
consistency model, build vs buy, cross-boundary calls). Push for
measurable NFR thresholds — ms, percentile, load profile. No "should
be fast" without numbers. Enforce architecture boundaries; if code
contradicts KB, flag it — don't silently update either. Only focus on
[stage scope] and nothing else.
```

### Designer (Product Designer)

```
Your Role: You are an expert Product Designer at KAFI Securities,
tasked with translating user stories into screen specifications and
interaction patterns that Code Generation can consume directly, as
mentioned in the Task section below.

[Standard plan paragraph]

Your Task: I am the Product Designer on [PROJECT NAME]. The active
stage is Stage 7 Product Design. Relevant inputs:
- aidlc-docs/inception/user-stories/ (this iteration's stories)
- aidlc-docs/inception/discovery/vision.md (personas + scope)

Load BOTH:
- .claude/skills/kafi/roles/designer.md (role behaviors)
- .claude/skills/kafi/design-system/SKILL.md (KAFI brand tokens,
  typography, components, patterns)

Write outputs to aidlc-docs/inception/product-design/. Reference the
KAFI design system for every component; custom components require
justification against the system. Cover empty / error / loading states
— not just happy path. WCAG 2.1 AA minimum on all screens. Specify
interactions with enough detail that Code Generation can implement
directly. Only focus on Stage 7 deliverables and nothing else.
```

### Dev (Developer)

```
Your Role: You are an expert Developer at KAFI Securities, pairing
with me to generate working code that implements the functional and
NFR designs for one Unit of Work, as mentioned in the Task section
below.

[Standard plan paragraph]

Your Task: I am the Developer on UNIT-[N] of [PROJECT NAME]. The
active stage is Stage 14 Code Generation. Relevant inputs:
- aidlc-docs/construction/[unit-name]/functional-design/
- aidlc-docs/construction/[unit-name]/nfr-design/
- aidlc-docs/construction/[unit-name]/infrastructure-design/
- aidlc-docs/inception/application-design/

Load .claude/skills/kafi/roles/dev.md. Write code into src/ — NEVER
inside aidlc-docs/. Write file inventory and notes to
aidlc-docs/construction/[unit-name]/code/. No hardcoded secrets — env
vars only. Auto-wire audit trail at every state-change boundary (per
the audit-trail extension). Auto-wire privacy enforcement if PII
fields are touched (per the personal-data-privacy extension). Show me
the file-by-file plan first; only execute after my approval. Run the
AI Review Checklist on every generated file. Only focus on UNIT-[N]
code and nothing else.
```

### DevOps / SRE

```
Your Role: You are an expert DevOps / SRE at KAFI Securities, tasked
with mapping logical infrastructure components to concrete services
and defining the deployment topology for one Unit of Work, as
mentioned in the Task section below.

[Standard plan paragraph]

Your Task: I am the DevOps/SRE on UNIT-[N] of [PROJECT NAME]. The
active stage is Stage 13 Infrastructure Design. Relevant inputs:
- aidlc-docs/construction/[unit-name]/nfr-design/
- aidlc-docs/inception/discovery/technical-environment.md
- 00-knowledge/architecture/[integration map if exists]

Load .claude/skills/kafi/roles/devops.md. Write outputs to
aidlc-docs/construction/[unit-name]/infrastructure-design/. If the
cloud target is undecided, use logical components only and surface
"Open — pending [owner]". Plan-before-apply for any IaC; flag
destructive operations. Document where secrets live and how they
rotate. Identify observability hooks for declared NFR thresholds.
Only focus on Stage 13 deliverables and nothing else.
```

## Git workflow

Six roles plus the AI agent share one repo. The model: **stage = branch, gate = pull request, merge = approval**. For the full diagram, file ownership matrix, and conflict resolution, see `KAFI-AIDLC-Handbook.html` Part 3.

### Branch naming

| Pattern | Used for | Example |
|---|---|---|
| `stage/{N}-{kebab-name}` | Single-role Inception stage | `stage/4-requirements` |
| `pre-inception/route-{X}-{desc}` | Pre-Inception sub-flows | `pre-inception/route-D-vision` |
| `unit/UNIT-{NN}-{kebab-name}` | Per-unit Construction (Stages 10–14) | `unit/UNIT-01-bond-capture` |
| `kb/{topic}` | Direct KB updates (PM/BA/SA only) | `kb/architecture-treasury-update` |
| `fix/{kebab-description}` | Hotfixes | `fix/audit-log-format` |

### Daily commands

```bash
# Start a session
git checkout main
git pull
git checkout -b stage/4-requirements
# open Claude Code → paste BA starter prompt

# Commit during session (after each logical chunk)
git add aidlc-docs/inception/requirements/
git commit -m "Stage 4: Requirements REQ-01..REQ-12

KB cited: arch/treasury.md §3
Open items: L2 role taxonomy"

# End of stage · open PR
git push -u origin stage/4-requirements
gh pr create \
  --title "Stage 4: Requirements" \
  --body "Closes gate · 24 REQs · 2 open items"

# After PR merged · clean up
git checkout main
git pull
git branch -d stage/4-requirements
git push origin --delete stage/4-requirements
```

### Commit message format

```
Stage [N]: [stage name] — [brief outcome]

Produced: [files / IDs]
KB cited: [section refs]
Open items: [list or "none"]

Related: REQ-NN, US-NN, UNIT-NN, ADR-NN
```

### The audit.md conflict (expected)

`aidlc-docs/audit.md` is append-only and **every** session writes to it. Merge conflicts are normal — never overwrite, always keep both:

```bash
git checkout --merge aidlc-docs/audit.md
# Or manually: remove conflict markers, keep both
# sets of audit entries in chronological order
```

For everything else, branches should own different folders so genuine conflicts are rare. If two branches conflict in `aidlc-docs/inception/*/`, the branching model was violated — restructure before merging.

## Document types

The workflow produces 19 canonical document types across four phases. Templates marked **★** are pre-built scaffolds in `aidlc-rule-details/templates/` — the agent uses them as starting frames. Full descriptions in `KAFI-AIDLC-Handbook.html` Part 3.

| Phase | Document | Owner | Purpose | Template |
|---|---|---|---|---|
| Pre-Inception | **Vision Document** · `discovery/vision.md` | PM | What + why · scope · success metrics | ★ |
| | **Technical Environment** · `discovery/technical-environment.md` | SA | Stack · cloud · constraints | ★ |
| Inception | **Reverse Engineering Pack** · `reverse-engineering/` (6) | SA | Existing system · KB-first (brownfield only) | — |
| | **Requirements** · `requirements/requirements.md` | PM | REQ-NN entries · KB-cited · acceptance per entry | ★ |
| | **User Stories** · `user-stories/stories.md` | BA | US-NN · INVEST · G/W/T ACs · personas | ★ (single) |
| | **Execution Plan** · `plans/execution-plan.md` | PM | Stages run · depth · gating | — |
| | **Product Design Pack** · `product-design/` (6) | Designer | UX flows · screens · interactions (UI only) | — |
| | **Application Design Pack** · `application-design/` (5) | SA | Components · methods · services · ADRs | ★ × 2 |
| | **Units of Work** · `application-design/unit-of-work*.md` | SA | Unit decomposition · deps · story map · exit criteria | ★ |
| Construction (per unit) | **Intent & Pinned Context** · `construction/{unit}/intent.md` | SA | Unit intent + KB pin list ≤ 4k tokens | — |
| | **Functional Design Pack** · `{unit}/functional-design/` | SA | Business logic · rules · entities · components | ★ |
| | **NFR Requirements** · `{unit}/nfr-requirements/` | SA | Measurable thresholds across 9 NFR categories | ★ |
| | **NFR Design** · `{unit}/nfr-design/` | SA | Patterns + tech that meet each NFR · ADRs | ★ |
| | **Infrastructure Design** · `{unit}/infrastructure-design/` | DevOps + SA | Logical → concrete services · topology | — |
| | **Code Summaries** · `{unit}/code/` | Developer | Inventory · module map · review outcomes | — |
| | **Build Pack** · `construction/build/` | Developer | Build instructions · order · outputs | — |
| Cross-cutting | **ADR** · `adrs/ADR-NN-*.md` | SA | One per architectural trade-off | ★ |
| | **Audit Log** · `aidlc-docs/audit.md` | AI agent | Append-only · TT 96/2020 compliance | — |
| | **State File** · `aidlc-docs/aidlc-state.md` | AI agent | Workflow state · resume marker | — |

**Templates available (11):** `vision.md` · `technical-environment.md` · `user-story.md` · `adr.md` · `requirements.md` · `application-design.md` · `components.md` · `unit-of-work.md` · `functional-design.md` · `nfr-requirements.md` · `nfr-design.md`

**Project overrides:** drop a same-named file in `00-knowledge/templates/` to override the KAFI standard for that project.

## How to update

Workflow versions evolve. To upgrade:

1. Replace `CLAUDE.md` with new version.
2. Replace `aidlc-rule-details/` (preserve any project-specific extensions you added).
3. Replace role guides under `.claude/skills/kafi/roles/` and the design system at `.claude/skills/kafi/design-system/SKILL.md`.

Project-specific content (`00-knowledge/`, `aidlc-docs/`, `src/`) is preserved across updates.

## Companion documents (distributed separately)

These reference docs are kept outside the injection package so they don't bloat every project repo:

- `KAFI-AIDLC-Introduction.html` — visual presentation for leadership + project teams
- `KAFI-AIDLC-Handbook.html` — per-stage detailed reference

Get them from the Transformation Office (or wherever your team hosts them) and keep them open in a browser tab while working — they aren't needed inside the project.

## Status

- Version: 0.3 DRAFT
- Maintained by: KAFI Transformation Office
- Adapted from: AWS Labs AI-DLC + Toan Huynh enterprise playbook
