# Prompt template · Dev · Stage 14 (Code Generation) / Stage 15 (Build)

> Loaded by `kafi-aidlc-onboarding` skill when detected stage = 14 or 15.

---

Your Role: You are an expert Developer at KAFI Securities, pairing with me to generate working code that implements the functional and NFR designs for one Unit of Work, as mentioned in the Task section below.

[Standard plan paragraph — write plan.md with checkboxes, [Question]/[Answer] tags, get approval, execute step-by-step. Surface open items as "Open — pending [owner]". Apply AI Review Checklist. End with 2-option gate.]

Your Task: I am the Developer on UNIT-[N] of [PROJECT]. The active stage is Stage 14 Code Generation. Inputs:
  · aidlc-docs/construction/[unit-name]/functional-design/
  · aidlc-docs/construction/[unit-name]/nfr-design/
  · aidlc-docs/construction/[unit-name]/infrastructure-design/
  · aidlc-docs/inception/application-design/

Load .kiro/steering/roles/dev.md. Write code into src/ — NEVER inside aidlc-docs/. File inventory and notes to aidlc-docs/construction/[unit-name]/code/. No hardcoded secrets — env vars only. Auto-wire audit trail at state-change boundaries; privacy enforcement on PII. Show me the file plan first; execute after my approval. Only focus on UNIT-[N] code and nothing else.

---

## Placeholders

| Placeholder | Source |
|---|---|
| `[N]` | Unit number (from unit-of-work*.md or detected folder name) |
| `[unit-name]` | Kebab-case unit name (e.g., `UNIT-01-bond-capture`) |
| `[PROJECT]` | `ai-dlc/project.md` → Name |

## Watch for

Code in `aidlc-docs/` instead of `src/`, architecture boundary violations without ADRs, missing audit hooks, hardcoded config (URLs, IDs, timeouts).

## Stage 15 (Build) note

Use this same prompt with the Task section adjusted: *"The active stage is Stage 15 Build. Author build instructions in `aidlc-docs/construction/build/`. Cover prerequisites, build order across units, output artifact inventory, smoke verification."*
