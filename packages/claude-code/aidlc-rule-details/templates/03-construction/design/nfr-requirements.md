# NFR Requirements — UNIT-{NN}: {unit-name}

> Stage 11 deliverable · SA owned · One file per unit
> Every requirement is measurable. No "should be fast" without numbers.

## Performance
- [NFR-PERF-01] {operation}: p{percentile} < {N}ms under {load profile}
- [NFR-PERF-02] ...

## Scalability
- [NFR-SCAL-01] Support {N} concurrent {actors} in {phase}; grow to {N} by {date}
- [NFR-SCAL-02] Peak throughput {N} {ops}/hour during {window}
- [NFR-SCAL-03] Data volume: {N} records · growth {N}/year

## Availability
- [NFR-AVAIL-01] {N}% uptime during {hours}
- [NFR-AVAIL-02] Graceful degradation: {behavior} when {dependency} unavailable
- [NFR-AVAIL-03] RTO < {N} min · RPO < {N} min

## Data integrity
- [NFR-DATA-01] {critical fields} captured at {moment} — NOT NULL, validated server-side
- [NFR-DATA-02] {transaction rule}

## Security
- [NFR-SEC-01] {data} encrypted at rest ({algo})
- [NFR-SEC-02] {role separation rule}
- [NFR-SEC-03] Authentication via {method} · session timeout {duration}

## Observability
- [NFR-OBS-01] {events} logged to `audit.md` per TT 96/2020
- [NFR-OBS-02] {metric} visible in dashboard within {N}s
- [NFR-OBS-03] Alert on {condition}

## Compliance
- [NFR-COMP-01] {regulation citation} → {specific requirement}
- [NFR-COMP-02] Open items affecting compliance: {list}

## Maintainability
- [NFR-MAINT-01] {module structure pattern}
- [NFR-MAINT-02] All environment config in env vars — no hardcoded endpoints

## Accessibility (if UI involved)
- [NFR-A11Y-01] WCAG 2.1 AA on all user-facing screens
- [NFR-A11Y-02] {keyboard / status / focus rules}

## Open NFR items
- Open — pending {owner}: {what's undecided}

---
KB cited: {sections}
Related: REQ-NN (functional traceability) · {regulatory citations}
