---
inclusion: manual
description: "Stage 16: Deployment"
---

# Stage 16: Deployment

**Owner:** DevOps · **Always runs** (when project goes to an environment) · **Approval required**

## Purpose

Deploy built artifacts to a target environment with a repeatable, rollback-safe procedure. Output is a runbook anyone can execute — not tribal knowledge.

## Inputs

- Build artifacts + `aidlc-docs/construction/build/build-instructions.md` (Stage 15)
- `aidlc-docs/construction/{unit}/infrastructure-design/` per unit (Stage 13)
- `aidlc-docs/inception/discovery/technical-environment.md` — runtime + platform
- `00-knowledge/conventions/` — environment + secrets policy
- Compliance extensions (audit-trail, privacy) — any deploy-time obligations

## Steps

1. Author `aidlc-docs/operations/deployment-runbook.md` using `aidlc-rule-details/templates/deployment-runbook.md`:
   - Prerequisites (access, tools+versions, secrets present, build artifact, approvals)
   - Pre-deploy checks
   - Ordered deploy steps (commands)
   - Database migrations (forward-compatible; destructive splits across releases)
   - Smoke verification (health, version stamp, critical flow, logs, metrics)
   - Rollback procedure
   - Post-deploy (release notes, tag, monitor window)
2. Dry-run on staging before production.
3. Execute against the target env per the runbook.
4. Run smoke verification; if it fails, execute the rollback section.
5. Update `release-notes.md` (use template) with what shipped.
6. Append `audit.md`; update `aidlc-state.md`.

## Outputs

To `aidlc-docs/operations/`:

| File | Content |
|---|---|
| `deployment-runbook.md` | The executable deploy + rollback procedure (use `templates/deployment-runbook.md`) |
| `deployment-log.md` | Per-deploy record: version, env, timestamp, smoke result, who ran it |

Plus `release-notes.md` (user-facing changelog) at repo root or `aidlc-docs/operations/`.

## Approval gate

```
Deployment for [env] complete.
- Version deployed: [tag]
- Migrations applied: [list or none]
- Smoke verification: [✓ / ✗ details]
- Rollback tested available: ✓
- Release notes updated: ✓

→ Request Changes (if smoke ✗ → rollback + fix)
→ Continue to Stage 17 (Monitoring)
```

## Watch for

- Secrets in the runbook (NEVER — reference vault/secret names only)
- Destructive migration in same release as code depending on old schema
- No rollback path documented
- Deploy steps that only the author can run (must be context-free reproducible)

KB cited: `infrastructure-design/` · `build/` · `technical-environment.md` · extensions
Related: `monitoring-runbook.md` (Stage 17) · `release-notes.md` · `postmortem.md`
