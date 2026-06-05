# Design Tokens — [Project]

> Stage 7 deliverable · Designer-owned · FIRST output of Stage 7
> Project-resolved token catalog · inherits from KAFI design system + project overrides
> Stage 14 audit enforces no ad-hoc CSS values — every visual literal in FE code MUST be a token here

**Status:** Draft | Locked
**Owner:** [Designer name]
**Last updated:** [Date]
**Inherits from:** `.kiro/steering/kafi-design-system.md` (KAFI brand base)
**Version:** [v0.X]

---

## 1. Overrides on KAFI base

Project-specific tokens that diverge from the KAFI brand base. Each override needs rationale.

| Token | KAFI base | Project override | Rationale |
|---|---|---|---|
| `--kafi-primary-500` | `#00C694` | `#1E40AF` | Project's brand palette differs · approved by BTS |
| ... | ... | ... | ... |

If no overrides: state "No overrides — full KAFI base in effect."

## 2. Color palette

### Semantic tokens

| Token | Value | Usage | WCAG contrast (on white / on surface) |
|---|---|---|---|
| `--kafi-color-primary-500` | `#00C694` | Primary actions, brand emphasis | AA / AA |
| `--kafi-color-secondary-500` | `#101820` | Secondary text, headers | AAA / AAA |
| `--kafi-color-success-500` | `#0E9F6E` | Success states | AA / AA |
| `--kafi-color-warning-500` | `#F59E0B` | Warning states | AA / AA |
| `--kafi-color-error-500` | `#DC2626` | Error states | AA / AA |
| `--kafi-color-info-500` | `#3B82F6` | Info states | AA / AA |
| `--kafi-color-surface-default` | `#FFFFFF` | Card / panel background | — |
| `--kafi-color-surface-muted` | `#F4F5F7` | Muted background | — |
| `--kafi-color-text-default` | `#101820` | Body text | AAA on surface-default |
| `--kafi-color-text-muted` | `#585667` | Secondary text | AA on surface-default |
| `--kafi-color-text-disabled` | `#9095A0` | Disabled text | AA borderline — avoid for critical text |

### Raw scale (50 → 950 per hue family, for state variations)

```
primary:   50, 100, 200, 300, 400, 500, 600, 700, 800, 900, 950
neutral:   50, 100, 200, 300, 400, 500, 600, 700, 800, 900, 950
success:   50, 100, 200, 300, 400, 500, 600, 700, 800, 900, 950
warning:   50, 100, 200, 300, 400, 500, 600, 700, 800, 900, 950
error:     50, 100, 200, 300, 400, 500, 600, 700, 800, 900, 950
info:      50, 100, 200, 300, 400, 500, 600, 700, 800, 900, 950
```

Hover/active/disabled derivations: use 600/700 for hover, 800 for active, 200 for disabled background.

## 3. Typography

- **Sans stack:** `Inter, -apple-system, BlinkMacSystemFont, "Segoe UI", sans-serif`
- **Mono stack:** `"JetBrains Mono", ui-monospace, SFMono-Regular, Consolas, monospace`
- **Serif stack (if applicable):** `Georgia, "Times New Roman", serif`

### Type scale

| Token | Font size / Line height | Weight | Usage |
|---|---|---|---|
| `--kafi-type-display` | 48px / 56px | 700 | Hero / landing |
| `--kafi-type-h1` | 32px / 40px | 700 | Page title |
| `--kafi-type-h2` | 24px / 32px | 600 | Section title |
| `--kafi-type-h3` | 20px / 28px | 600 | Subsection |
| `--kafi-type-h4` | 18px / 26px | 600 | Card title |
| `--kafi-type-body-lg` | 16px / 24px | 400 | Emphasized body |
| `--kafi-type-body` | 14px / 22px | 400 | Default body |
| `--kafi-type-body-sm` | 13px / 20px | 400 | Secondary body |
| `--kafi-type-caption` | 12px / 18px | 400 | Captions / labels |
| `--kafi-type-code` | 13px / 20px | 400 (mono) | Inline code |

## 4. Spacing (4pt grid)

| Token | Value |
|---|---|
| `--kafi-sp-0` | 0 |
| `--kafi-sp-1` | 4px |
| `--kafi-sp-2` | 8px |
| `--kafi-sp-3` | 12px |
| `--kafi-sp-4` | 16px |
| `--kafi-sp-5` | 24px |
| `--kafi-sp-6` | 32px |
| `--kafi-sp-7` | 48px |
| `--kafi-sp-8` | 64px |
| `--kafi-sp-9` | 96px |
| `--kafi-sp-10` | 128px |

## 5. Radius

| Token | Value | Usage |
|---|---|---|
| `--kafi-r-none` | 0 | Sharp corners |
| `--kafi-r-sm` | 6px | Small chips, badges |
| `--kafi-r-md` | 12px | Buttons, inputs |
| `--kafi-r-lg` | 18px | Cards, panels (KAFI default) |
| `--kafi-r-xl` | 24px | Modal, dialog |
| `--kafi-r-full` | 9999px | Pills, avatars |

## 6. Shadow elevation

| Token | Value | Usage |
|---|---|---|
| `--kafi-shadow-1` | `0 1px 2px rgba(16, 24, 32, 0.06)` | Subtle separation |
| `--kafi-shadow-2` | `0 2px 6px rgba(16, 24, 32, 0.08)` | Card resting |
| `--kafi-shadow-3` | `0 6px 16px rgba(16, 24, 32, 0.10)` | Card hover, dropdown |
| `--kafi-shadow-4` | `0 12px 32px rgba(16, 24, 32, 0.14)` | Modal, popover |
| `--kafi-shadow-5` | `0 24px 60px rgba(16, 24, 32, 0.18)` | Top-level overlay |

## 7. Motion

### Duration tokens
- `--kafi-dur-instant` 0ms
- `--kafi-dur-fast` 120ms
- `--kafi-dur-base` 200ms
- `--kafi-dur-slow` 320ms
- `--kafi-dur-page` 480ms

### Easing tokens
- `--kafi-ease-standard` `cubic-bezier(0.2, 0, 0, 1)` — default UI motion
- `--kafi-ease-emphasized` `cubic-bezier(0.2, 0, 0, 1.2)` — entrances, attention
- `--kafi-ease-decel` `cubic-bezier(0, 0, 0, 1)` — incoming
- `--kafi-ease-accel` `cubic-bezier(0.3, 0, 1, 1)` — outgoing

## 8. Z-index scale

| Token | Value | Usage |
|---|---|---|
| `--kafi-z-base` | 0 | Default content |
| `--kafi-z-sticky` | 100 | Sticky headers / sidebar |
| `--kafi-z-dropdown` | 200 | Dropdowns, popovers |
| `--kafi-z-modal-backdrop` | 300 | Modal backdrop |
| `--kafi-z-modal` | 400 | Modal dialog |
| `--kafi-z-toast` | 500 | Toast notifications |
| `--kafi-z-tooltip` | 600 | Tooltips (top) |

## 9. Breakpoints

| Token | Min width | Usage |
|---|---|---|
| `--kafi-bp-sm` | 640px | Tablet portrait |
| `--kafi-bp-md` | 768px | Tablet landscape |
| `--kafi-bp-lg` | 1024px | Desktop |
| `--kafi-bp-xl` | 1280px | Wide desktop |
| `--kafi-bp-2xl` | 1536px | Extra-wide |

## 10. Component library decision

- **Library:** [shadcn/ui · Radix · Material UI · Ant Design · in-house · …]
- **Rationale:** [why this choice]
- **Component overrides:** [list of components this project re-skins on top of the library]
- **Forbidden libraries:** [if any, with rationale]

## 11. Token naming convention

`--kafi-{category}-{name}-{step}`

Examples:
- `--kafi-color-primary-500`
- `--kafi-sp-4`
- `--kafi-r-lg`
- `--kafi-shadow-3`

Code MUST use these names, NEVER raw hex/px/ms literals.

## 12. Iconography

- **Icon set:** [Lucide · Heroicons · custom · …]
- **Default size:** 20px
- **Stroke width (if outline set):** 1.5px
- **Color binding:** inherits `currentColor` from text

---

## Audit hook (Stage 14c · Token discipline)

Code FE references tokens from this file (or the inherited KAFI base) for ALL style values. Stage 14c audit scans for raw `#xxx`, `Npx/rem/em`, `Nms` literals outside CSS variable definitions; mismatch ⇒ Request Changes.

KB cited: KAFI design system skill · Stage 7 product-design.md
Related: `uiux-spec.md` · `mockups/*.html` · `mockups/*.view-model.md`
