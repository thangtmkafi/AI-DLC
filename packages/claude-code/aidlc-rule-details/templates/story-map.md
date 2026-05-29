# Story Map — [Project]

> Stage 5 artifact · BA-owned · the user-story map across the user journey
> Activities (backbone) → user tasks → stories, sliced by release

**Status:** Draft | Approved
**Owner:** [BA name]
**Last updated:** [Date]
**Parent:** Vision · PRD-NN · Epics

---

## How to read

- **Backbone (top row):** sequential user *activities* — the high-level steps a user takes, left → right in journey order.
- **Under each activity:** *user tasks* (sub-steps).
- **Under each task:** *stories* (US-NN), stacked by priority.
- **Release slices (horizontal lines):** which stories ship in MVP vs later.

## Map

```
ACTIVITY →   [Onboard]        [Capture deal]      [Review]          [Settle]
─────────────────────────────────────────────────────────────────────────────
tasks:       login            enter terms         view pending      approve
             set profile      validate            filter/sort       export

── MVP ──────────────────────────────────────────────────────────────────────
stories:     US-01 login      US-03 capture       US-05 list        US-08 approve
             US-02 profile    US-04 validate      US-06 detail      US-09 settle

── Release 2 ──────────────────────────────────────────────────────────────────
             —                US-10 templates     US-07 bulk filter US-11 bulk approve
```

## Activity → Epic → Story table

| Activity | Epic | Stories (MVP) | Stories (later) |
|---|---|---|---|
| Onboard | EPIC-01 | US-01, US-02 | — |
| Capture deal | EPIC-02 | US-03, US-04 | US-10 |
| Review | EPIC-03 | US-05, US-06 | US-07 |
| Settle | EPIC-04 | US-08, US-09 | US-11 |

## MVP walking skeleton

[The thinnest left-to-right slice that delivers an end-to-end usable flow. Lists the minimum
stories that, together, let a user complete the whole journey once.]

- US-01 → US-03 → US-05 → US-08 (one deal, login to settle)

## Release plan

| Release | Theme | Stories | Target |
|---|---|---|---|
| MVP | Core capture-to-settle | US-01..09 | [phase 1] |
| R2 | Bulk + templates | US-10, US-11, US-07 | [phase 2] |

---

KB cited: Vision · `prd-*.md` · Epics
Related: `epic.md` · `user-story.md` (US-NN) · `personas.md` (whose journey)
