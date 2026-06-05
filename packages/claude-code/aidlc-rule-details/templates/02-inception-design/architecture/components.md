# Components — {Project / Feature Name}

> Stage 8 deliverable · SA owned · Detail view
> Companion to `application-design.md` (consolidated) and `component-methods.md` (signatures)

## Component: {ComponentName}

- **Purpose:** {1-line role in the system}
- **Layer:** {presentation · application · domain · infrastructure}
- **Owner:** {team}
- **Status:** New / Modified / Existing
- **KB reference:** {00-knowledge/architecture/X.md §Y if applicable}

### Responsibilities

- {Responsibility 1 — bounded, single}
- {Responsibility 2}

### Interfaces (public surface)

- **{Interface name}:** {what it exposes — signatures detailed in `component-methods.md`}

### Dependencies

- **{Other component / external system}** — for {capability needed}
  - Communication: {sync HTTP · async event · shared library}
  - ADR: {ADR-NN if cross-boundary or non-obvious}

### Constraints

- {Constraint that shapes design — e.g. "must be stateless for horizontal scaling"}
- {Constraint sourced from architecture-boundaries.md}

### State

- **Stateful?** {yes / no}
- **State location:** {DB · cache · in-memory · client}
- **Persistence:** {what is persisted and where}

## Component: ...

(repeat structure)

---
KB cited: {sections}
Related: `application-design.md` · `component-methods.md` · `services.md` · `component-dependency.md` · ADR-NN
