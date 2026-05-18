# Functional Design — UNIT-{NN}: {unit-name}

> Stage 10 deliverable · BA + SA owned · One file per unit
> Technology-agnostic — business logic only, no infrastructure

## Business logic model

### Process: {process name}

- **Trigger:** {what initiates this process}
- **Inputs:** {data / events feeding in}
- **Steps:**
  1. {Step 1 in business terms}
  2. {Step 2}
- **Decisions:** {branches and conditions — what determines which path}
- **Outputs:** {data / events produced}
- **Errors:** {what can go wrong · how it's surfaced}

### Process: ...

## Business rules

### Rule: {RULE-NN-name}

- **Statement:** {if/then, invariant, or precondition}
- **Applies to:** {process(es) that enforce this}
- **Examples:**
  - Given {scenario A}, then {outcome}
  - Given {scenario B}, then {outcome}
- **Source:** REQ-NN · {regulation} · BRD §

### Decision table: {scenario}

| Condition A | Condition B | Outcome |
|---|---|---|
| {value} | {value} | {action} |
| ... | ... | ... |

## Domain entities

### Entity: {EntityName}

- **Purpose:** {1-line role in the domain}
- **Identity:** {what makes one instance distinct}
- **Properties:**
  - `field_name` ({type}, {constraints}) — {meaning}
  - ...
- **Invariants:** {rules that must always hold true}
- **Lifecycle:** {creation conditions · valid state transitions · termination}

### Aggregate boundaries

- **{Aggregate root}** owns: {entities under its consistency boundary}
- Cross-aggregate references: {how separate aggregates communicate}

## Frontend components (if UI involved)

### Component: {ComponentName}

- **Role:** {what this component does for the user}
- **State:** {local state managed}
- **Props:** {inputs from parent / store}
- **Events:** {what it emits}
- **Renders:** {child components / patterns from KAFI design system}
- **Stories covered:** US-NN, US-NN

## Open items
- Open — pending {owner}: {decision}

---
KB cited: {sections}
Related: REQ-NN · US-NN · ADR-NN · UNIT-NN dependencies · pairs with `nfr-requirements.md`
