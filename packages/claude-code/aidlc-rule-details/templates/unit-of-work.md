# Units of Work — {Project / Feature Name}

> Stage 9 deliverable · SA owned
> One section per unit. Each unit gets a corresponding folder under `aidlc-docs/construction/UNIT-NN-name/`

## Decomposition strategy

{1-2 paragraphs: why these unit boundaries. Bounded contexts · team alignment · deployment independence · etc.}

---

## UNIT-01: {Name}

### Intent

{1-2 sentences: what this unit delivers and why it exists as a unit}

### Stories covered

- US-NN: {title}
- US-NN: {title}

### Dependencies

- Depends on: {other UNIT-NNs, or "none"}
- Used by: {other UNIT-NNs that consume this}

### Boundaries

- **Owns:** {data · processes · capabilities inside this unit}
- **Does NOT own:** {explicitly delegated to other UNITs}
- **Cross-boundary calls:** {list — each requires an ADR}

### Pinned context (for the agent)

When the agent works on this unit, load only:
- KB sections: `00-knowledge/architecture/X.md` §Y, ...
- Open items: {relevant entries from open-items.md}
- ADRs: ADR-NN-{name}, ...

Token budget: < 4k

### Exit criteria

- [ ] All stories' acceptance criteria met
- [ ] All NFR thresholds met (see `nfr-requirements.md` for this unit)
- [ ] Code coverage ≥ {N}% on critical modules
- [ ] Build successful (per `build-instructions.md`)
- [ ] Code reviewed (PR merged to main)
- [ ] Audit trail wired (audit-trail extension verified)
- [ ] Privacy enforcement wired if PII touched

### Open items
- Open — pending {owner}: {decision}

---

## UNIT-02: {Name}

(repeat structure)

---

## Notes

- Story coverage check: {all US-NN assigned to a unit}
- Dependency cycles: {none / list}
- Each unit has its own folder under `aidlc-docs/construction/UNIT-NN-name/` containing:
  `intent.md` (extracted from this file) · `pinned-context.md` · plus per-stage subfolders (functional-design/, nfr-requirements/, etc.)

---
KB cited: {sections}
Related: REQ-NN · US-NN · `application-design/` outputs · `unit-of-work-dependency.md` · `unit-of-work-story-map.md`
