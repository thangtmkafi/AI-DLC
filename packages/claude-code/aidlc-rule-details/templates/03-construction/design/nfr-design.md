# NFR Design — UNIT-{NN}: {unit-name}

> Stage 12 deliverable · SA owned · One file per unit
> Pairs each NFR requirement with the pattern / tech that satisfies it.
> Every non-obvious pick opens an ADR.

## Performance design

Pattern: {pattern name}
  Addresses: NFR-PERF-NN
  Tech: {specific tech} · {key config}
  Latency budget: {breakdown showing the threshold is met}
  ADR-NN: {trade-off, if non-obvious}

Pattern: ...

## Scalability design

Pattern: {pattern name}
  Addresses: NFR-SCAL-NN
  Approach: {scaling strategy — stateless · sharding · read replicas}
  Limits: {when this stops working — capacity ceiling}
  ADR-NN: {if applicable}

## Availability design

Pattern: {redundancy / fallback pattern}
  Addresses: NFR-AVAIL-NN
  Topology: {instances · regions · zones}
  Health check: {what's checked, frequency}
  Failure mode: {what happens when X breaks}
  ADR-NN: {if applicable}

## Data integrity design

Pattern: {constraint / transaction pattern}
  Addresses: NFR-DATA-NN
  Enforcement layer: {DB · service · gateway}

## Security design

Pattern: {auth · encryption · access pattern}
  Addresses: NFR-SEC-NN
  Tech: {specific impl}
  Key management: {how secrets are stored, rotated}

## Observability design

Pattern: {tracing · metrics · logging pattern}
  Addresses: NFR-OBS-NN
  Tools: {APM · metrics backend · log aggregator}

## Compliance design

Pattern: {how regulatory requirement is enforced in code/architecture}
  Addresses: NFR-COMP-NN
  Verification: {how compliance is proven on each release}

## Maintainability design

Pattern: {module · config · dependency pattern}
  Addresses: NFR-MAINT-NN

## Accessibility design

Pattern: {component library · testing strategy}
  Addresses: NFR-A11Y-NN
  Verification: {automated checks · manual review · external audit}

## Open design items
- Open — pending {owner}: {design decision deferred}

---
KB cited: {sections}
Related ADRs: {list}
Pairs with: `nfr-requirements.md` (every pattern addresses an NFR-* requirement)
