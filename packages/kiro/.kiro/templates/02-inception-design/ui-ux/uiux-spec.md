# UI/UX Specification — [Project]

> Stage 7 deliverable · Designer-owned
> Master narrative for the whole UI/UX · single canonical entry point
> Detail lives in companion files (`mockups/`, `user-flows.md`, `interaction-specs.md`, `accessibility-notes.md`)

**Status:** Draft | Approved
**Owner:** [Designer name]
**Last updated:** [Date]
**Version:** [v0.X]

---

## 1. Purpose + design principles

[1-2 paragraphs: what UI experience are we building, for whom, with what tonal qualities.]

Design principles (3-5 max):
- **[Principle 1]** — [one-line behavior implication]
- **[Principle 2]** — [...]

References: `design-tokens.md` (look & feel catalog) · KAFI design system skill (brand base).

## 2. Sitemap

Top-level page tree of the entire product.

```
/                            Landing
├── /auth
│   ├── /login               Login screen
│   ├── /reset-password
│   └── /verify-otp
├── /dashboard               Dashboard (post-login home)
│   ├── /deals               Deals list
│   │   ├── /deals/new       Deal capture
│   │   └── /deals/:id       Deal detail
│   ├── /portfolio           Portfolio
│   └── /settings
│       ├── /settings/profile
│       └── /settings/preferences
└── /admin                   (Admin-only)
    └── /admin/users
```

Format: tree of routes with one-line purpose. Routes that don't render a top-level screen (e.g., redirects, side panels) noted inline.

## 3. Navigation chrome

Cross-screen UI elements that appear on every (or most) screens.

### Top nav
- **Logo** (left) — links to `/dashboard`
- **Primary nav items** (center): [Deals · Portfolio · Reports · …]
- **User menu** (right): avatar dropdown · profile · preferences · sign out
- **Sticky?** Yes / No · scroll behavior

### Side nav (if applicable)
- **Items:** [list]
- **Collapse state:** [default open · default collapsed · per-user pref]
- **Active state indicator:** [...]

### Breadcrumbs
- **Rule:** show on screens depth ≥ 2 from sitemap root
- **Format:** `Dashboard / Deals / Deal #1234`
- **Last segment:** non-clickable, current screen

### Footer (if applicable)
- **Items:** [Privacy · Terms · Help · Version stamp · …]

## 4. Screen catalog

The full list of screens in the product, with traceability to stories + target unit.

| ID | Screen name | Route | Mockup file | View-model file | Stories (US-NN) | Target unit | States covered |
|---|---|---|---|---|---|---|---|
| S-01 | Login | /auth/login | mockups/login.html | mockups/login.view-model.md | US-01 | UNIT-01 | default · error · loading |
| S-02 | Dashboard home | /dashboard | mockups/dashboard.html | mockups/dashboard.view-model.md | US-02 | UNIT-01 | default · empty · loading |
| S-03 | Deal capture | /deals/new | mockups/deal-capture.html | mockups/deal-capture.view-model.md | US-03, US-04 | UNIT-02 | default · empty · error · loading |
| S-04 | Deal detail | /deals/:id | mockups/deal-detail.html | mockups/deal-detail.view-model.md | US-05 | UNIT-02 | default · loading · not-found |
| ... | ... | ... | ... | ... | ... | ... | ... |

This catalog IS the `mockups/index.md` content — keep the two in sync.

## 5. Cross-screen flows (summary)

Each flow ties multiple screens into a user journey. Detail in `user-flows.md`.

| Flow ID | Name | Screens (in order) | Stories served |
|---|---|---|---|
| F-01 | First-time login | Login → 2FA → Dashboard | US-01 |
| F-02 | Capture a deal | Dashboard → Deal capture → Deal detail | US-03, US-04, US-05 |
| F-03 | Update portfolio | Dashboard → Portfolio → Position detail | US-07 |
| ... | ... | ... | ... |

## 6. Key UX decisions / ADRs

Architectural UX choices worth documenting. Each item: decision + rationale + impact.

- **[D-01]** [Decision] — [rationale] — [impact on which screens / behaviors]
- **[D-02]** [...] 

Major decisions affecting code (e.g., "Modal vs full-page form") may also be captured in `adrs/`.

## 7. Accessibility posture

Top-level commitment. Detail per-screen in `accessibility-notes.md`.

- **Target standard:** WCAG 2.1 Level AA (KAFI minimum)
- **Color contrast:** All text + UI controls meet AA (verified in `design-tokens.md`)
- **Keyboard navigation:** Full app navigable without mouse · tab order matches visual order
- **Screen reader:** All interactive elements have accessible names · ARIA where needed
- **Focus visible:** All focusable elements show clear focus indicator (≥ 2px outline)
- **Motion:** Respects `prefers-reduced-motion` for non-essential animation

## 8. Coverage matrix · stories → screens

Surfaces gaps where a user-facing story has no covering screen. Built from Screen catalog (Section 4) reversed.

| Story (US-NN) | Title | Covering screens | Status |
|---|---|---|---|
| US-01 | User logs in | S-01 Login | ✓ Covered |
| US-02 | View dashboard | S-02 Dashboard | ✓ Covered |
| US-03 | Capture new deal | S-03 Deal capture | ✓ Covered |
| US-04 | Edit pending deal | — | ✗ **GAP** — no covering screen, escalate to PM |
| ... | ... | ... | ... |

Approval rule: every user-facing US-NN must be ✓ Covered before Stage 7 gate.

## 9. References

- `design-tokens.md` — project look & feel token catalog
- `mockups/*.html` — per-screen visual (HTML)
- `mockups/*.view-model.md` — per-screen data binding (MVVM)
- `mockups/index.md` — machine-readable manifest
- `user-flows.md` — cross-screen flow detail
- `interaction-specs.md` — system-wide interaction patterns
- `accessibility-notes.md` — per-screen a11y detail
- `aidlc-docs/inception/application-design/data-model.md` — entities cited by view-models
- KAFI design system skill — brand base

---

KB cited: Vision §personas · Stage 5 user-stories.md · KAFI design system
Related: every Stage 7 detail file listed above
