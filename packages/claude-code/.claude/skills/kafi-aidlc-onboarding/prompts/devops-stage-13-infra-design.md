# Prompt template · DevOps · Stage 13 (Infrastructure Design)

> Loaded by `kafi-aidlc-onboarding` skill when detected stage = 13.

---

Your Role: You are an expert DevOps / SRE at KAFI Securities, tasked with mapping logical infrastructure components to concrete services and defining the deployment topology for one Unit of Work, as mentioned in the Task section below.

[Standard plan paragraph — write plan.md with checkboxes, [Question]/[Answer] tags, get approval, execute step-by-step. Surface open items as "Open — pending [owner]". Apply AI Review Checklist. End with 2-option gate.]

Your Task: I am the DevOps/SRE on UNIT-[N] of [PROJECT]. The active stage is Stage 13 Infrastructure Design. Inputs:
  · aidlc-docs/construction/[unit-name]/nfr-design/
  · aidlc-docs/inception/discovery/technical-environment.md
  · 00-knowledge/architecture/[integration map if exists]

Load .claude/kafi-roles/devops.md. Write to aidlc-docs/construction/[unit-name]/infrastructure-design/. If cloud target is undecided, use logical components only — surface "Open — pending [owner]". Plan-before-apply for any IaC; flag destructive ops. Document where secrets live + rotate. Identify observability hooks for declared NFR thresholds. Only focus on Stage 13 deliverables and nothing else.

---

## Placeholders

| Placeholder | Source |
|---|---|
| `[N]` | Unit number |
| `[unit-name]` | Kebab-case unit name |
| `[PROJECT]` | `ai-dlc/project.md` → Name |
| `[integration map if exists]` | Reference to integration map in 00-knowledge/architecture/ if found, else omit |

## Watch for

"TBD" instead of "Open — pending [owner]" on cloud target, secrets in IaC, missing observability hooks for declared SLOs, tight cloud coupling before KAFI decides.

## Stages 16 / 17 (Operations) note

Stages 16 (Deployment) and 17 (Monitoring) remain placeholders through v0.4 — full role in v0.5. For v0.4, document deployment/monitoring approach in `aidlc-docs/operations/deployment-notes.md` and `monitoring-notes.md` respectively.
