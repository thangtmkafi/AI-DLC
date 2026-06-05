# Mockup Index — screen manifest

> Stage 7 deliverable · Designer-owned · Authored to `aidlc-docs/inception/product-design/mockups/index.md`
> Machine-readable manifest: every screen → its HTML mockup → paired view-model → stories → target unit → states shown
> Stage 14c UI-fidelity audit and Units Generation read this to map screens to units and detect coverage gaps

**Status:** Draft | Approved
**Owner:** [Designer name]
**Last updated:** [Date]
**Derives from:** `uiux-spec.md` (screen catalog · §3 sitemap) · `user-stories/stories.md` (US-NN) · `mockups/*.html` + `mockups/*.view-model.md`

---

## How to use

One row per screen. The manifest is the index of truth for the FE source-of-truth set: it
binds each rendered HTML mockup to its paired `view-model.md`, the stories it satisfies, the
target Construction unit, and the states the mockup demonstrates. Keep it 1:1 — every
`mockups/*.html` has a row; every row has an HTML file AND a view-model. Coverage gaps
(a story with no screen, or a screen with no view-model) are blocking at Stage 14c.

States vocabulary: `default · empty · error · loading` (+ `hover · disabled` where relevant).

---

## Screens

| Screen ID | Route | HTML mockup | View-model | Stories (US-NN) | Target unit | States shown |
|---|---|---|---|---|---|---|
| SCR-01 Deals List | `/deals` | `deals-list.html` | `deals-list.view-model.md` | US-01, US-03 | UNIT-02 | default · empty · loading |
| SCR-02 Deal Capture | `/deals/new` | `deal-capture.html` | `deal-capture.view-model.md` | US-04 | UNIT-02 | default · error · loading |
| [SCR-NN] | [route] | [file.html] | [file.view-model.md] | [US-NN] | [UNIT-NN] | [states] |

---

## Sitemap (navigation chrome)

Mirror `uiux-spec.md` §3 — top-level nav and how the screens above connect.

```
[Top nav: Logo · Deals · Portfolio · Reports · User menu]
  Deals ─┬─ SCR-01 Deals List ──(New deal)── SCR-02 Deal Capture
         └─ ...
```

---

## Coverage check (Designer self-verify before handoff)

- [ ] Every story in `stories.md` maps to ≥1 screen here (no orphan story → would block at Stage 14c)
- [ ] Every HTML mockup has a paired `view-model.md` (1:1)
- [ ] Every mockup shows its negative states (empty / error / loading) — required, not optional
- [ ] Every cross-screen transition here has a matching flow in `user-flows.md`
- [ ] No ad-hoc CSS values in the HTML mockups — all visual values reference `design-tokens.md`

KB cited: `uiux-spec.md` · `user-stories/stories.md` · `design-tokens.md`
Related: `user-flows.md` (cross-screen journeys) · `view-model.md` (per-screen data binding) · `unit-of-work.md` (Stage 9 target units)
