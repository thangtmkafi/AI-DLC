# Risk Register — [Project]

> Pre-Inception / Stage 4 artifact · PM-owned · living document
> Catalog of project risks with likelihood × impact + mitigation owners

**Status:** Living document
**Owner:** [PM name]
**Last updated:** [Date]

---

## Scoring

- **Likelihood:** L (rare) · M (possible) · H (likely)
- **Impact:** L (minor) · M (significant) · H (severe / blocks go-live)
- **Score:** Likelihood × Impact → priority (HH/HM = act now · ML = monitor · LL = accept)

## Register

| ID | Risk | Category | Likelihood | Impact | Score | Mitigation | Owner | Status |
|---|---|---|---|---|---|---|---|---|
| RISK-01 | [External pricing API unreliable] | Technical | M | H | HM | [cache last good + fallback + ADR-04] | [SA] | Open |
| RISK-02 | [TT 96/2020 audit gaps] | Regulatory | L | H | — | [audit-trail extension on all txn] | [PM] | Mitigated |
| RISK-03 | [Scope creep beyond MVP] | Project | H | M | HM | [phase discipline + scope OUT in PRD] | [PM] | Monitoring |
| RISK-04 | [PII leak] | Security | L | H | — | [privacy extension + masking + access log] | [SA] | Mitigated |

## Categories

Technical · Regulatory · Security · Project (schedule/scope/resource) · External dependency · Operational

## Escalation

Any risk reaching **HH** (high likelihood × high impact) escalates to [sponsor] immediately
and may trigger a scope/timeline decision.

## Closed / accepted risks

| ID | Risk | Resolution | Date |
|---|---|---|---|
| RISK-NN | [...] | [accepted / mitigated / no longer applies] | [date] |

---

KB cited: Vision §8 (risks) · `00-knowledge/` · regulatory KB
Related: `vision.md` · `brief.md` §6 (constraints) · ADRs (mitigations) · `postmortem.md` (realized risks)
