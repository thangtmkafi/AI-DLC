# Postmortem — [Incident title]

> Stage 17 / Operations artifact · written after any user-impacting incident
> Blameless · focus on systems + process, not people · produces prevention items

**Incident ID:** [INC-NN]
**Severity:** SEV1 (critical) | SEV2 (major) | SEV3 (minor)
**Author:** [name]
**Date of incident:** [Date] · **Postmortem date:** [Date]
**Status:** Draft | Reviewed | Actions tracked

---

## 1. Summary

[2-3 sentences: what happened, who was affected, for how long, resolution.]

## 2. Impact

- **Users affected:** [count / segment]
- **Duration:** [start → detection → mitigation → resolution timestamps]
- **Business impact:** [transactions lost · SLO breach · regulatory exposure]
- **SLO impact:** [which SLO from monitoring-runbook breached, by how much]

## 3. Timeline (UTC+7)

| Time | Event |
|---|---|
| HH:MM | [trigger / change that started it] |
| HH:MM | [first symptom] |
| HH:MM | [alert fired / detected] (see monitoring-runbook §3) |
| HH:MM | [investigation started] |
| HH:MM | [mitigation applied] |
| HH:MM | [resolved + verified] |

## 4. Root cause

[The actual cause. Use 5-whys to get past the surface symptom.]

- Why did [symptom]? → [because A]
- Why A? → [because B]
- Why B? → [because C]
- Why C? → [because D]
- Why D? → [root cause]

## 5. What went well / what went poorly

**Well:**
- [e.g. alert fired promptly · rollback was clean]

**Poorly:**
- [e.g. no alert on the actual failing dependency · runbook step ambiguous]

## 6. Action items (prevention)

| Action | Type | Owner | Due | Tracking |
|---|---|---|---|---|
| [Add alert on X] | detect | [name] | [date] | [open-item / ticket] |
| [Add test case for Y] | prevent | [name] | [date] | TC-NN |
| [Fix runbook step Z] | respond | [name] | [date] | monitoring-runbook §5.x |
| [ADR for the design gap] | prevent | [name] | [date] | ADR-NN |

## 7. Lessons → feed back into AI-DLC

[Patterns worth promoting: a new test-case category, a new audit sub-check, a glossary term,
an ADR. Hand to `kafi-memory` skill for org-level promotion consideration.]

---

KB cited: `monitoring-runbook.md` · `deployment-runbook.md` · audit logs
Related: `risk-register.md` (was this a known risk?) · ADRs · `kafi-memory` learnings
