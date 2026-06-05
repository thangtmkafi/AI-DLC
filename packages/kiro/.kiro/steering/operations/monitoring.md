---
inclusion: manual
description: "Stage 17: Monitoring"
---

# Stage 17: Monitoring

**Owner:** DevOps + SRE · **Always runs** (post-deploy) · **Approval required**

## Purpose

Make the deployed system observable + define how oncall responds. SLOs derive from NFR thresholds — monitoring is the executable form of the NFR contract.

## Inputs

- `aidlc-docs/construction/{unit}/nfr-requirements/` + `nfr-design/` — thresholds become SLOs
- `aidlc-docs/operations/deployment-runbook.md` (Stage 16)
- Deployed system access (metrics, logs, traces)
- Audit-trail + privacy extension config (logging obligations)

## Steps

1. Author `aidlc-docs/operations/monitoring-runbook.md` using `aidlc-rule-details/templates/04-operations/monitoring-runbook.md`:
   - SLIs / SLOs (each tied to a source NFR + alert threshold)
   - Dashboards (service overview · business metrics · infra)
   - Alerts (condition · severity · routing · runbook section)
   - Logging (where · retention · PII masking · correlation id)
   - Oncall playbooks (per alert)
   - Escalation ladder
2. Wire metrics/logs/traces per the runbook.
3. Validate each alert fires (synthetic trigger) + routes correctly.
4. Confirm PII never logged in plaintext (privacy extension); audit logs append-only (audit-trail extension).
5. Append `audit.md`; update `aidlc-state.md`.

## Outputs

To `aidlc-docs/operations/`:

| File | Content |
|---|---|
| `monitoring-runbook.md` | SLOs · dashboards · alerts · logging · oncall playbooks · escalation (use `templates/04-operations/monitoring-runbook.md`) |

When an incident occurs, write a `postmortem.md` (use `templates/04-operations/postmortem.md`) and feed lessons back via `kafi-memory`.

## Approval gate

```
Monitoring for [system] complete.
- SLIs/SLOs defined: [N] (each tied to a source NFR)
- Dashboards live: [list]
- Alerts wired + test-fired: [N / N]
- Logging: PII masked ✓ · audit append-only ✓ · correlation id ✓
- Oncall playbooks: [N alerts covered]

→ Request Changes
→ Operations live · workflow complete for this phase
```

## Watch for

- An SLO with no source NFR (where did the target come from?)
- An alert with no oncall playbook section (who knows what to do?)
- PII in logs (privacy extension violation — blocking)
- Dashboards no one owns / no one reads

KB cited: `nfr-requirements/` · `nfr-design/` · extensions
Related: `deployment-runbook.md` (Stage 16) · `postmortem.md` · `kafi-memory` (incident → learning)
