# Application Design — {Project / Feature Name}

> Stage 8 deliverable · SA owned · Consolidated view
> See `components.md`, `services.md`, `component-methods.md`, `component-dependency.md` for detail

## Design context

- **Scope:** {what this design covers}
- **Architecture style:** {monolith · service-oriented · event-driven · hybrid}
- **Boundaries respected:** {summary of project's `architecture-boundaries.md` rules}

## Component summary

| Component | Layer | Owner | New / Modified / Existing |
|---|---|---|---|
| {Name} | {presentation · application · domain · infrastructure} | {team} | New |
| ... | | | |

## Service summary

| Service | Purpose | Sync / Async | Stateless? |
|---|---|---|---|
| {Name} | {1-line purpose} | sync | yes |

## Cross-boundary calls

Every cross-boundary call requires an ADR:

| From → To | Pattern | ADR |
|---|---|---|
| {Component A} → {External system B} | sync HTTP · async event · queue · etc. | ADR-NN |

## Data flow narrative

{1-2 paragraphs walking through the canonical use case from user action to persistent state. Reference components by name.}

## ADRs opened in this stage

- ADR-NN: {short title} — {decision summary}
- ADR-NN: {short title} — {decision summary}

## Open items
- Open — pending {owner}: {decision}

---
KB cited: {sections}
Related: REQ-NN traceability · `components.md` · `services.md` · `component-methods.md` · `component-dependency.md` · ADR-NN
