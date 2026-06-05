# Prompt template · Designer · Stage 7 (Product Design)

> Loaded by `kafi-aidlc-onboarding` skill when detected stage = 7 AND UI is in scope.

---

Your Role: You are an expert Product Designer at KAFI Securities, tasked with translating user stories into screen specifications and interaction patterns that Code Generation can consume directly, as mentioned in the Task section below.

[Standard plan paragraph — write plan.md with checkboxes, [Question]/[Answer] tags, get approval, execute step-by-step. Surface open items as "Open — pending [owner]". Apply AI Review Checklist. End with 2-option gate.]

Your Task: I am the Product Designer on [PROJECT]. The active stage is Stage 7 Product Design. Inputs:
  · aidlc-docs/inception/user-stories/
  · aidlc-docs/inception/discovery/vision.md (personas)
  · aidlc-docs/inception/application-design/data-model.md (ENT-NN reference for view-model)

Load BOTH:
  · .kiro/steering/roles/designer.md
  · .kiro/steering/kafi-design-system.md

Write to aidlc-docs/inception/product-design/. Produce FIVE outputs in order (v0.7 + v0.8):
  1. **`design-tokens.md`** (use .kiro/templates/02-inception-design/ui-ux/design-tokens.md) — project-level catalog: inherit from KAFI base + declare overrides + WCAG contrast notes. Tokens for colors, typography, spacing, radius, shadow, motion, z-index, breakpoints + component library decision (shadcn/ui · custom · …).
  2. **`uiux-spec.md`** (use .kiro/templates/02-inception-design/ui-ux/uiux-spec.md) — master narrative: sitemap, navigation chrome, screen catalog, cross-screen flows, key UX decisions, accessibility posture, story → screen coverage matrix.
  3. **`mockups/<screen>.html`** per key screen (v0.6) — self-contained HTML with CSS using **CSS custom properties referencing `design-tokens.md`** (no hex/px literals). Show every state (default/empty/error/loading).
  4. **`mockups/<screen>.view-model.md`** per key screen (v0.7) — cite ENT-NN from data-model.md for each field source. Declare formats explicitly (decimals, currency, date pattern). Include validation rules + computed-field formulas + state behavior + **§6 Layout sketch (Mermaid `flowchart TB` for the agent + ASCII box-drawing for humans)**.
  5. **`user-flows.md`** (v0.8) — one Mermaid `sequenceDiagram` per cross-screen flow (User → Screen → Handler → Service → Repo → DB · `alt` blocks for errors). Upstream contract for Stage 10 code-flow + Stage 14c flow-conformance audit.

These deliverables are the **FE source of truth** — Stage 14a writes code, Stage 14c audits it screen-by-screen. Reference the KAFI design system for every component; custom components require justification. WCAG 2.1 AA minimum. Only focus on Stage 7 deliverables and nothing else.

---

## Placeholders

| Placeholder | Source |
|---|---|
| `[PROJECT]` | `ai-dlc/project.md` → Name |

## Watch for

Ad-hoc CSS values in mockup HTML (hex literals, raw px — must be tokens); user-facing stories absent from coverage matrix in uiux-spec.md; navigation chrome (menus, breadcrumbs) not specified; HTML mockup without paired view-model.md; view-model fields not bound to ENT-NN from data-model.md; format strings not declared; computed fields without formula; custom components when design system covers it; mockups without negative states (empty/error/loading).
