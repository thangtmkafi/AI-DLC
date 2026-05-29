# Monitoring Runbook — [System / Service]

> Stage 17 deliverable · DevOps + SRE-owned · how the system is watched + how oncall responds
> Cites NFR thresholds (Stage 11/12) as the SLO source of truth

**Status:** Draft | Approved
**Owner:** [DevOps / SRE name]
**Last updated:** [Date]
**Cites:** `nfr-requirements/` · `nfr-design/` · `deployment-runbook.md`

---

## 1. SLIs / SLOs

Derived from NFR thresholds. Each SLO has an SLI (the measurement) + target.

| SLI (measurement) | SLO (target) | Source NFR | Alert threshold |
|---|---|---|---|
| p95 request latency | < 500ms | NFR-perf-01 | > 800ms for 5 min |
| Availability | ≥ 99.9% monthly | NFR-avail-01 | < 99.9% rolling |
| Error rate (5xx) | < 0.5% | NFR-rel-01 | > 1% for 5 min |
| EOD batch completion | by 23:00 | NFR-perf-03 | not done by 22:30 |

## 2. Dashboards

| Dashboard | What it shows | Link |
|---|---|---|
| Service overview | latency · error rate · throughput · saturation (RED/USE) | [url] |
| Business metrics | deals/hour · NAV refresh lag · settlement queue | [url] |
| Infra | CPU · mem · disk · network · pod restarts | [url] |

## 3. Alerts

| Alert | Condition | Severity | Routes to | Runbook section |
|---|---|---|---|---|
| HighLatency | p95 > 800ms · 5 min | warning | #oncall-channel | §5.1 |
| HighErrorRate | 5xx > 1% · 5 min | critical | page oncall | §5.2 |
| ServiceDown | health fail · 2 min | critical | page oncall | §5.3 |
| BatchLate | EOD not done by 22:30 | critical | page + ops lead | §5.4 |

## 4. Logging

- **Where:** [aggregator · index pattern]
- **Retention:** [N days hot · M days cold] · audit logs append-only per audit-trail extension
- **PII:** never logged in plaintext (privacy extension) · masked fields: [list]
- **Correlation:** every request carries [trace-id]; logs + traces joined on it

## 5. Oncall playbooks (per alert)

### 5.1 HighLatency
1. Check [dashboard] for the slow endpoint / dependency
2. [common causes + first remediations]
3. Escalate to [role] if not resolved in [N] min

### 5.2 HighErrorRate
1. [steps]

### 5.3 ServiceDown
1. Check recent deploy (see `deployment-runbook.md`) — rollback candidate?
2. [steps]

### 5.4 BatchLate
1. [steps]

## 6. Escalation

| Level | Who | When |
|---|---|---|
| L1 | Oncall engineer | first responder |
| L2 | [team lead] | not resolved in 30 min OR critical |
| L3 | [eng manager + ops] | customer-impacting > 1h |

Incident → write a `postmortem.md` within [N] business days.

---

KB cited: `nfr-requirements/` · `nfr-design/` · `architecture-boundaries.md`
Related: `deployment-runbook.md` · `postmortem.md` · audit-trail + privacy extensions
