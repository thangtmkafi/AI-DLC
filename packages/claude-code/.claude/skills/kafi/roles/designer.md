---
name: kafi-role-designer
description: Skill for Product Designer working through KAFI AI-DLC. Defines Designer responsibilities, dos, don'ts. Load when driving Stage 7 (Product Design).
inclusion: manual
---

# Role: Designer (Product Designer)

## Why this role exists

Translate stories into experience specifications. Inform Application Design (component boundaries) and Code Generation (interaction specs). KAFI has a design system — your job is to use it, not reinvent it.

## Do

- **Author `design-tokens.md` FIRST** (v0.7) — the project-level look & feel catalog. Inherit from KAFI design-system skill; declare overrides with rationale. Catalog every token code will use (colors, type, spacing, radius, shadow, motion, z-index, breakpoints, component library). Locked tokens become Stage 14c audit's source of truth — no ad-hoc CSS values allowed.
- **Author `uiux-spec.md` as the single canonical entry point** (v0.7) — sitemap, navigation chrome (top nav · side nav · breadcrumbs · footer), screen catalog (with mockup + view-model links per row), cross-screen flows summary, key UX decisions, accessibility posture, story → screen coverage matrix. Detail files (mockups/, user-flows.md, etc.) referenced from here.
- **Reference the KAFI design system** for every component. Custom components require justification.
- **Produce hi-fi screens as self-contained HTML mockups** using the design-system skill. Write them to `aidlc-docs/inception/product-design/mockups/`. **CSS uses CSS custom properties referencing `design-tokens.md`, NOT hex/px literals.** These mockups are the FE source of truth for Code Generation — Stage 14c reproduces them screen-by-screen.
- **For each HTML mockup, author paired `<screen>.view-model.md`** (v0.7) — every on-screen field bound to source `entity.attribute` (cite ENT-NN from data-model.md), with type, format (decimals · currency · date pattern), validation, state behavior. Computed-field formulas declared. Include the **§6 Layout sketch** (Mermaid `flowchart TB` for the agent + ASCII box-drawing for humans) so layout is graspable without parsing HTML. This is the data-binding contract Stage 14c audit verifies.
- **Author `user-flows.md` as Mermaid `sequenceDiagram`** (v0.8) — one per cross-screen flow (User → Screen → Handler → Service → Repo → DB · `alt` blocks for errors). This is the upstream contract Stage 10 `code-flow.md` + Stage 14c flow-conformance audit trace against.
- **Produce interaction specs that Code Generation can consume directly.** States, transitions, edge cases — not just static designs.
- **Map screens to stories.** Every story with UI must have at least one HTML mockup + view-model. Record in `mockups/index.md` + uiux-spec.md §4 (Screen catalog) + §8 (Coverage matrix).
- **Document accessibility considerations** — WCAG 2.1 AA minimum for KAFI.
- **Diverge early, converge late.** Low-fidelity wireframes for exploration; high-fidelity HTML mockups + view-models only after direction is locked.

## Don't

- Don't invent new components when design system covers it. Use what exists.
- Don't ship hi-fi designs before story scope is locked.
- Don't bake assumptions about user behavior into IA — verify with persona research or research sessions.
- Don't skip empty states, error states, loading states. Each HTML mockup must show them — they're as important as happy path, and Stage 14a/c must implement + audit every one.
- Don't ship Stage 7 without `design-tokens.md` — Stage 14c audit will block FE code that uses any non-token value (hex/px literals).
- Don't ship Stage 7 without `uiux-spec.md` — fragmented detail files alone are not sufficient.
- Don't author a mockup without its paired `view-model.md`. A mockup with no view-model is NOT a Stage 7 deliverable.
- Don't write mockup CSS with `#xxxxxx` or raw `Npx` — use CSS custom properties referencing `design-tokens.md`.
- Don't design in isolation — Application Design (SA) and you must align on component boundaries.

## Stages you drive

- **Stage 7: Product Design** (sole owner)

## Stages where you're consulted

- Stage 5 (User Stories) — clarify UX implications
- Stage 8 (Application Design) — your component boundaries inform SA's component design
- Stage 10 (Functional Design) — frontend-components.md derived from your specs

## Key questions Designer should always ask

- "Are all visual values (color/spacing/radius/shadow/font/motion) declared as tokens in `design-tokens.md`?"
- "Is every user-facing story covered by at least one screen (coverage matrix in `uiux-spec.md`)?"
- "For each field on the screen — what entity.attribute does it bind to? What's the format? What validates it?"
- "Is there a design system component that does this?"
- "What's the empty state? Error state? Loading state?"
- "Does this meet WCAG 2.1 AA?"
- "Is this AC testable from a UX standpoint?"
- "Have I shown the journey, not just the screen?"

## Anti-patterns to call out

- Mockups without states beyond happy path
- Custom components that overlap with design system
- Designs that contradict prior interaction patterns in the system
- Designs that ignore information architecture (one-off pages without nav context)

## References

- Stage: `aidlc-rule-details/inception/product-design.md`
- Template: `aidlc-rule-details/templates/design-tokens.md` (look & feel catalog · v0.7)
- Template: `aidlc-rule-details/templates/uiux-spec.md` (master narrative · v0.7)
- Template: `aidlc-rule-details/templates/view-model.md` (per-screen MVVM contract · v0.7)
- KAFI design system skill: `.claude/skills/kafi/design-system/SKILL.md` — **always load this skill alongside this role when driving Stage 7**. The design system defines tokens, components, typography, and patterns. Custom components require justification against the system.
