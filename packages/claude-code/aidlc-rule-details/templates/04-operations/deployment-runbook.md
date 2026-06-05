# Deployment Runbook — [System / Service]

> Stage 16 deliverable · DevOps-owned · the executable deploy procedure
> Someone with zero context should be able to deploy + roll back from this alone

**Status:** Draft | Approved
**Owner:** [DevOps name]
**Last updated:** [Date]
**Environments:** dev · staging · production
**Cites:** `infrastructure-design/` · `build/build-instructions.md`

---

## 1. Prerequisites

- [ ] Access: [cloud account · kube context · registry creds — where stored, never in repo]
- [ ] Tools + versions: [kubectl X · helm Y · terraform Z · docker]
- [ ] Secrets present in target env: [list env vars / secret names — values in vault, not here]
- [ ] Build artifact available: [image tag · package version from Stage 15]
- [ ] Approvals: [who signs off prod deploy]

## 2. Pre-deploy checks

- [ ] Target env health green (current version responding)
- [ ] Migration plan reviewed (see §4)
- [ ] Rollback artifact (previous version) confirmed available
- [ ] Maintenance window / traffic considerations noted

## 3. Deploy steps (ordered)

```bash
# 1. Confirm target
kubectl config current-context   # must be [expected]

# 2. Apply DB migrations (if any) — see §4
[migration command]

# 3. Deploy new version
[helm upgrade / kubectl apply / terraform apply]

# 4. Wait for rollout
kubectl rollout status deploy/[name] --timeout=300s
```

## 4. Database migrations

| Migration | Forward | Reversible? | Notes |
|---|---|---|---|
| [NN_add_column] | [command] | yes/no | [backfill needed?] |

**Rule:** migrations are forward-compatible (old code works with new schema) so deploy +
migrate can interleave without downtime. Destructive migrations (drop column) split across
two releases.

## 5. Smoke verification (post-deploy)

- [ ] Health endpoint 200: `curl https://[host]/health`
- [ ] Version stamp matches deployed tag
- [ ] Critical user flow works (see `user-flows.md` happy path): [1-2 manual checks]
- [ ] Logs clean (no error spike in first 5 min)
- [ ] Key metrics nominal (see `monitoring-runbook.md`)

## 6. Rollback procedure

```bash
# If smoke checks fail:
[helm rollback [name] [previous-revision]]
# OR
[kubectl rollout undo deploy/[name]]
```

- [ ] Confirm previous version healthy
- [ ] Reverse migration if it was applied AND is reversible (else forward-fix)
- [ ] Notify stakeholders + open incident if user-impacting (see `postmortem.md`)

## 7. Post-deploy

- [ ] Update `release-notes.md` with what shipped
- [ ] Tag release in version control
- [ ] Monitor dashboards for [N] hours (see `monitoring-runbook.md`)

---

KB cited: `infrastructure-design/` · `build/` · `architecture-boundaries.md`
Related: `monitoring-runbook.md` · `release-notes.md` · `postmortem.md`
