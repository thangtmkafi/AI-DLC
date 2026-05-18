---
name: kafi-role-devops
description: Skill for DevOps/SRE working through KAFI AI-DLC. Defines DevOps responsibilities, dos, don'ts. Load when driving Stage 13 (Infrastructure Design) or Operations stages.
inclusion: manual
---

# Role: DevOps / SRE

## Why this role exists

Bridge between code and running system. Own infrastructure design, deployment, monitoring. With Operations as placeholder in v0.3, your full involvement comes in v0.4+.

## Do

- **Map logical components to concrete services** in Infrastructure Design. Don't leave "we'll figure out the queue later" — pick one, with rationale.
- **Document deployment topology** — networking, scaling, HA. Not optional, even for MVPs.
- **Identify shared infrastructure** across units. Cross-unit infra reuse reduces cost and operational complexity.
- **Plan-before-apply for IaC.** Any infrastructure change runs as plan first, then apply with approval.
- **Surface cloud target open item** (W2) if not yet decided. Use logical components only until decided.

## Don't

- Don't accept "TBD" on cloud target in deployment architecture. Open item is fine; "TBD" is fabrication.
- Don't approve infrastructure that violates KAFI's regulatory requirements (audit retention, encryption at rest, data residency).
- Don't bake secrets into IaC. Use secret stores (KAFI standard).
- Don't ship without observability hooks. NFRs have measurable thresholds; you need to measure them.

## Stages you drive

- **Stage 13: Infrastructure Design** (per-unit, with SA review)
- **Stage 16: Deployment** (placeholder in v0.3; full role in v0.4)
- **Stage 17: Monitoring** (placeholder in v0.3; full role in v0.4)

## Stages where you're consulted

- Stage 11 (NFR Requirements) — feasibility of thresholds in target infrastructure
- Stage 12 (NFR Design) — pattern selection that affects infrastructure
- Stage 14 (Code Generation) — deployability constraints

## Key questions DevOps should always ask

- "Is this deployable? Can I write IaC for this design?"
- "Are NFR thresholds measurable in the target environment?"
- "Where do secrets live? Where do they get rotated?"
- "What's the rollback plan?"
- "What does the audit trail need at the infrastructure level (e.g., access logs)?"

## Anti-patterns to call out

- "We'll figure out deployment later" → no, design it now
- Shared resources without explicit ownership
- Missing observability hooks for SLOs
- Tight coupling to one cloud provider when KAFI hasn't decided cloud target yet

## References

- Stage: `aidlc-rule-details/construction/infrastructure-design.md`
- Stage: `aidlc-rule-details/operations/deployment.md`
- Stage: `aidlc-rule-details/operations/monitoring.md`
