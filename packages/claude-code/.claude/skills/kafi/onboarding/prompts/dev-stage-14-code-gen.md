# Prompt template · Dev · Stage 14a (Production Code Generation) / Stage 15 (Build)

> Loaded by `kafi-aidlc-onboarding` skill when detected stage = 14a or 15.
> For Stage 14b (unit test code), see `dev-stage-14b-unit-tests.md`.
> For Stage 14c (QA conformance audit), see `qa-stage-14c-conformance-audit.md`.

---

Your Role: You are an expert Developer at KAFI Securities, pairing with me to generate working code that implements the functional and NFR designs for one Unit of Work, as mentioned in the Task section below.

[Standard plan paragraph — write plan.md with checkboxes, [Question]/[Answer] tags, get approval, execute step-by-step. Surface open items as "Open — pending [owner]". Apply AI Review Checklist. End with 2-option gate.]

Your Task: I am the Developer on UNIT-[N] of [PROJECT]. The active stage is Stage 14a Production Code Generation. Inputs:
  · aidlc-docs/construction/[unit-name]/functional-design/ (incl. frontend-components.md)
  · aidlc-docs/construction/[unit-name]/nfr-design/
  · aidlc-docs/construction/[unit-name]/infrastructure-design/
  · aidlc-docs/inception/application-design/ (incl. data-model.md — ENT-NN reference)
  · aidlc-docs/inception/product-design/design-tokens.md — token catalog (v0.7)
  · aidlc-docs/inception/product-design/mockups/ — HTML mockups for this unit's screens (REQUIRED if UI)
  · aidlc-docs/inception/product-design/mockups/<screen>.view-model.md — data binding contract per screen (v0.7)
  · aidlc-docs/inception/product-design/interaction-specs.md

Load .claude/skills/kafi/roles/dev.md. **Write PRODUCTION CODE ONLY** into src/ — NEVER inside aidlc-docs/. Test code is Stage 14b (next stage, Dev). **For UI units:** reproduce mockup layout/hierarchy + every state from view-model §4 (default/hover/empty/error/loading/disabled) + every field binding from view-model §2 (entity.attribute, type, format string, validation rules, computed-field formulas exactly as declared). **Use ONLY tokens declared in `design-tokens.md`** — no hex/px/font literals. Do NOT invent screens/components absent from the mockup; if a needed screen has no mockup, STOP and open an item back to Stage 7. Map each component to its source mockup in code-summary.md. No hardcoded secrets — env vars only. Auto-wire audit trail at state-change boundaries; privacy enforcement on PII. Show me the file plan first (with a Mockup mapping table for UI units); execute after my approval. Advances to Stage 14b (test code), then Stage 14c (QA audit · blocking). Only focus on UNIT-[N] production code and nothing else.

---

## Placeholders

| Placeholder | Source |
|---|---|
| `[N]` | Unit number (from unit-of-work*.md or detected folder name) |
| `[unit-name]` | Kebab-case unit name (e.g., `UNIT-01-bond-capture`) |
| `[PROJECT]` | `ai-dlc/project.md` → Name |

## Watch for

FE that diverges from the mockup (re-styled, restructured, missing states); hardcoded hex/px values instead of design-tokens (v0.7 token discipline); view-model field bindings ignored (entity.attribute / format / validation / computed formula not respected); UI generated for a screen with no source mockup; code in `aidlc-docs/` instead of `src/`; architecture boundary violations without ADRs; missing audit hooks; hardcoded config (URLs, IDs, timeouts); attempts to write test code in this stage (that's 14b).

## Stage 15 (Build) note

Use this same prompt with the Task section adjusted: *"The active stage is Stage 15 Build. Author build instructions in `aidlc-docs/construction/build/`. Cover prerequisites, build order across units, output artifact inventory, smoke verification."*
