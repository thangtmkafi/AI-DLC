---
name: kafi-design-system
description: Apply Kafi's official design system to any dashboard, report, or UI output. Use this skill when building HTML dashboards, React components, data visualizations, or any product UI that needs to follow Kafi brand and visual standards. Covers both Light Theme (product surfaces, reports, tools) and Dark Theme (OKR dashboards, monitoring views, executive briefings). Includes exact design tokens, typography scale, component patterns, spacing system, and the 5-step content flow framework used across all Kafi dashboard outputs.
version: 2.2
updated: 2026-05
source: Synthesized from Kafi Brand Guidelines v2.0 (Jan 2026), 17 Design System PDFs, OKR v4, Business Performance, Mobile Executive Briefing, Leadership Dashboard, OKR Platform Light Theme build (May 2026), OKR Platform Dark Theme refinements (May 2026)
---

# Kafi Design System — Dashboard & UI Skill

**Version:** 2.2 · **Updated:** May 2026

Use this skill to apply consistent Kafi brand, theme, and style to any dashboard or UI output. **Read this file in full before writing any code.**

| | |
|---|---|
| **Scope** | HTML dashboards, React components, data visualizations, product UI |
| **Themes** | Light (product surfaces, reports, tools) · Dark (OKR dashboards, executive briefings) |
| **Source** | Kafi Brand Guidelines v2.0 · 17 Design System PDFs · OKR Platform builds (May 2026) |

---

## Table of Contents

**Foundations**
- [1. Design Philosophy](#1-design-philosophy)
- [2. Theme Choice Guide](#2-theme-choice-guide)
- [3. Design Tokens](#3-design-tokens) — 3.1 Light · 3.2 Dark · 3.3 React/JS Object
- [4. Typography Scale](#4-typography-scale)

**Components**
- [5. Component Patterns](#5-component-patterns) — Cards · Buttons · Type Labels · Badges · Progress Bars · Sidebar · Top Bar · Avatars · KPI Cards · Tables · Detail Panel · Modal · Connectors · Section Rows · Bottom Sheet

**Layout & Content**
- [6. Layout System](#6-layout-system)
- [7. Content Flow Framework](#7-content-flow-framework)

**Color & Style**
- [8. Color Usage Rules](#8-color-usage-rules)
- [9. Brand Colors Quick Reference](#9-brand-colors-quick-reference)
- [10. Animation](#10-animation)

**Dark Theme**
- [11. Dark Theme — Card & Surface Rules](#11-dark-theme--card--surface-rules) — 11.1 Border-Only Cards · 11.2 Solid Surfaces · 11.3 Canvas · 11.4 Glassmorphism
- [11A. Dark Theme — Navigation Active State](#11a-dark-theme--navigation-active-state)
- [11B. Dark Theme — Ultimate Goal Card](#11b-dark-theme--ultimate-goal-card)

**Quality & Reference**
- [12. Anti-Patterns](#12-anti-patterns--never-do-these)
- [13. Mobile Dashboard Rules](#13-mobile-dashboard-rules)
- [14. Font Import](#14-font-import)
- [15. QA Checklist](#15-qa-checklist)
- [16. Copy-Paste Starter Blocks](#16-copy-paste-starter-blocks)
- [17. Brand Assets — Embedded Logos](#17-brand-assets--embedded-logos)

---

## ⚡ ACTIVATION — Ask These First

> **Before writing any code or producing any output, ask the following questions.**
> Wait for all answers before proceeding. Do not assume defaults.

---

### Q1 — Which theme?

Ask:
> "Light theme or dark theme?"

- **Light** → use token set `T` (§3.1 + §3.3)
- **Dark** → use token set `D` (§3.2 + §3.3) and apply §11–11B dark surface rules

The chosen theme applies to **all** components, surfaces, and outputs in this build.

---

### Q2 — Which layout?

Ask:
> "Should I follow the default Kafi dashboard layout, or do you have a custom layout in mind?"

**Option A — Default layout**
Use the standard Kafi platform structure:
- Left sidebar (200px) with text-only nav
- Top bar (50px) with page title + action buttons
- Main content area (Strategy Map or Active Goals list view)
- Right detail panel (460px, conditional on selection)
- Add/Edit modal overlay

→ Proceed directly with §6 Layout System.

**Option B — Custom layout**
The teammate will provide their layout via one or more of:
- 📐 **IA / wireframe diagram** — upload an image or paste a text structure
- 🖼 **Screenshots** — reference UI to match or adapt
- 📝 **Text description** — written description of the intended structure

Ask: *"Please share your layout — as an IA diagram, screenshot, or text description — and I'll adapt the Kafi design system tokens to it."*

→ Apply all Kafi tokens (§3) and component patterns (§5) to the provided structure.

---

### Q3 — What is the output type?

Ask:
> "What format should the final output be?"

| Option | Description |
|---|---|
| **Full platform** | Complete app with sidebar, views, detail panel, modal (React JSX) |
| **Single view** | One specific view only — e.g. Strategy Map, Active Goals list, or Dashboard |
| **Component** | A reusable UI component — card, sidebar, table, modal, etc. |
| **HTML dashboard** | Self-contained `.html` file (no React) |
| **Spec / doc** | Written component spec or design doc — no code output |

→ Match code structure and file format to the chosen output type.

---

## 1. DESIGN PHILOSOPHY

| Principle | Rule |
|---|---|
| **Minimalism first** | Core content only. No decorative elements, no bell-and-whistles. |
| **Clarity over cleverness** | Information hierarchy before visual flair. |
| **Role-aware density** | Presentation views = low density. Operational views = high density, scannable. |
| **Consistent tokens** | Always reference CSS variables / JS token objects. Never hardcode hex values inline. |
| **Border-only cards** | Cards are defined by stroke, never by fill color. |
| **Single scroll** | Prefer one scrollable view over tabbed layouts. |
| **Vietnamese context** | Use real VND amounts, real feature names, real persona names (e.g. Minh, Lan, Hùng). No placeholder data. |
| **Icon-free product surfaces** | Navigation items and card type labels use text only. No emoji or icon libraries in sidebars, nav rows, or card headers. Type hierarchy is communicated through size, weight, and spacing — not icons. |
| **Green-only accent (light theme)** | In light-theme product surfaces, `#00C694` is the sole accent color for CTAs, active states, progress, and focus rings. Blue, purple, and red are reserved for semantic status only — never used for UI chrome, type labels, or decorative elements. |

---

## 2. THEME CHOICE GUIDE

| Context | Theme | When to use |
|---|---|---|
| **Light Theme** | `light` | Product surfaces, tools, OKR platforms, reports, PRDs, hiring docs, any doc shared externally |
| **Dark Theme** | `dark` | OKR dashboards, monitoring views, BOD presentations, executive briefings, real-time operational views |

Both themes share the same token names — only the values change. Build once, switch by swapping the `:root` block.

---

## 3. DESIGN TOKENS

### 3.1 Light Theme `:root`

```css
@import url('https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700&display=swap');

:root {
  /* BRAND */
  --kafi-green:        #00C694;   /* Primary brand, CTA, progress fill, active states */
  --kafi-teal:         #07756D;   /* On Track text, secondary brand */
  --kafi-teal-mid:     #0C6070;   /* Hover states, supporting elements */
  --kafi-dark:         #101820;   /* Headings, secondary button fill */
  --kafi-yellow:       #F9CC4E;   /* Warnings, deadlines, alert highlights */
  --kafi-mint:         #D8F5EE;   /* Progress tracks — softer mint for light surfaces */
  --kafi-mint-light:   #E6FBF4;   /* Sheet action bg, success bg, focus highlight */

  /* SEMANTIC STATUS */
  --color-success:     #00C694;
  --color-success-bg:  #E6FBF4;
  --color-success-text:#07756D;
  --color-warning:     #D4770A;
  --color-warning-bg:  #FFF8E1;
  --color-warning-text:#A05C00;
  --color-danger:      #D93025;
  --color-danger-bg:   #FFF0F0;
  --color-danger-text: #B02020;
  --color-info:        #2D5BFF;
  --color-info-bg:     #EEF2FF;
  --color-info-text:   #1A3CC8;
  --color-purple:      #962DFF;
  --color-purple-bg:   #F5EEFF;

  /* SURFACES */
  --page-bg:            #F2F4F7;  /* Page canvas */
  --card-bg:            #FFFFFF;  /* Primary card surface */
  --sidebar-bg:         #FFFFFF;  /* Sidebar */
  --sidebar-active-bg:  #F2F4F7;  /* Active/expanded nav group */
  --table-header-bg:    #F7F8FA;  /* Column header rows */
  --section-alt:        #FAFCFB;  /* Detail panel footer, alternate surface */

  /* TEXT — max 3 shades per view */
  --text-primary:      #101820;   /* Headings, high-emphasis */
  --text-secondary:    #585667;   /* Body, labels, row text */
  --text-muted:        #9095A0;   /* Type labels, placeholders — neutral gray, NOT purplish */
  --text-brand:        #00C694;   /* Links, interactive, active nav item */
  --text-inverse:      #FFFFFF;   /* Text on dark/brand surfaces */

  /* BORDERS */
  --border-card:       1.5px solid rgba(0,0,0,0.08);   /* Card boundary */
  --border-internal:   1px solid rgba(0,0,0,0.06);     /* Row dividers, section separators */
  --border-sidebar:    1px solid rgba(0,0,0,0.06);     /* Sidebar right border */
  --border-focus:      1.5px solid #00C694;            /* Focus ring, active input */
  --border-nav-active: 2px solid #00C694;              /* Left-border indicator on active nav item */

  /* RADIUS */
  --radius-card:       18px;   /* Cards, panels, modals */
  --radius-button:     32px;   /* Pill buttons */
  --radius-badge:      20px;   /* Pill badges / chips */
  --radius-input:      11px;   /* Form inputs */
  --radius-sm:         8px;    /* Small inner elements */
  --radius-md:         12px;   /* Medium inner elements */

  /* SHADOWS */
  --shadow-sm:    0 1px 4px rgba(0,0,0,0.05);
  --shadow-md:    0 3px 12px rgba(0,0,0,0.08);
  --shadow-lg:    0 4px 20px rgba(0,0,0,0.12);
  --shadow-xl:    0 8px 32px rgba(0,0,0,0.14);

  /* SPACING (4px base) */
  --sp1:4px; --sp2:8px; --sp3:12px; --sp4:16px; --sp5:24px;
  --sp6:32px; --sp7:48px; --sp8:64px; --sp9:96px; --sp10:128px;

  /* TYPOGRAPHY */
  --font: 'Inter', sans-serif;
}
```

---

### 3.2 Dark Theme `:root`

```css
@import url('https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700&display=swap');

:root {
  /* BRAND (same as light) */
  --kafi-green:#00C694; --kafi-teal:#07756D; --kafi-teal-mid:#0C6070;
  --kafi-dark:#101820;  --kafi-yellow:#F9CC4E;
  --kafi-mint:#BEF6E9;  --kafi-mint-light:#E6FBF4;

  /* SEMANTIC STATUS (muted for dark bg) */
  --color-success:#00C694;       --color-success-bg:rgba(0,198,148,0.15);   --color-success-text:#00C694;
  --color-warning:#F9CC4E;       --color-warning-bg:rgba(249,204,78,0.15);  --color-warning-text:#F9CC4E;
  --color-danger:#FF4C42;        --color-danger-bg:rgba(255,76,66,0.15);    --color-danger-text:#FF4C42;
  --color-info:#5B8DEF;          --color-info-bg:rgba(91,141,239,0.15);     --color-info-text:#5B8DEF;

  /* SURFACES — border-only cards, deep canvas */
  --page-bg:        #080D12;             /* Deep canvas — darker for higher contrast */
  --card-bg:        transparent;         /* Border-only: no fill on cards */
  --sidebar-bg:     #0C1219;             /* Solid elevated surface for sidebar + top bar */
  --modal-bg:       #0C1219;             /* Solid fill for modals (overlay needs opacity) */
  --sidebar-active-bg: rgba(255,255,255,0.06); /* Subtle active parent group tint */
  --section-alt:    rgba(255,255,255,0.03);    /* Minimal tint for header rows inside cards */

  /* TEXT — brighter than previous for higher contrast on deep bg */
  --text-primary:   #F0F4F8;   /* Headings, high-emphasis */
  --text-secondary: #A8B5C0;   /* Body, labels, row text */
  --text-muted:     #546070;   /* Type labels, placeholders */
  --text-brand:     #00C694;
  --text-inverse:   #101820;

  /* BORDERS — stronger on deep canvas */
  --border-card:       1.5px solid rgba(255,255,255,0.12);
  --border-internal:   1px solid rgba(255,255,255,0.08);
  --border-sidebar:    1px solid rgba(255,255,255,0.08);
  --border-focus:      1.5px solid #00C694;
  --border-nav-active: 2px solid #00C694;

  /* RADIUS (identical to light) */
  --radius-card:18px; --radius-button:32px; --radius-badge:20px;
  --radius-input:11px; --radius-sm:8px; --radius-md:12px;

  /* SHADOWS */
  --shadow-sm:0 0 0 1px rgba(255,255,255,0.12);  /* Border-emphasis outline */
  --shadow-md:0 3px 16px rgba(0,0,0,0.40);
  --shadow-lg:0 4px 24px rgba(0,0,0,0.50);
  --shadow-xl:0 8px 48px rgba(0,0,0,0.60);
  --shadow-panel:-8px 0 32px rgba(0,0,0,0.50);    /* Right detail panel drop shadow */

  /* SPACING (identical to light) */
  --sp1:4px;--sp2:8px;--sp3:12px;--sp4:16px;--sp5:24px;
  --sp6:32px;--sp7:48px;--sp8:64px;--sp9:96px;--sp10:128px;

  --font:'Inter',sans-serif;
}
```

---

### 3.3 React / JS Token Object

Use this directly in React artifacts. Token names map 1:1 to the CSS variables above.

```javascript
// Light theme
const T = {
  // Brand
  green:        '#00C694',
  teal:         '#07756D',
  mint:         '#D8F5EE',    // progress track
  mintLight:    '#E6FBF4',    // success bg, focus highlight

  // Surfaces
  pageBg:       '#F2F4F7',
  cardBg:       '#FFFFFF',
  sideBg:       '#FFFFFF',
  sideActive:   '#F2F4F7',    // active/expanded nav group
  tableHeaderBg:'#F7F8FA',
  sectionAlt:   '#FAFCFB',

  // Text — 3 shades max per view
  text1:        '#101820',    // primary
  text2:        '#585667',    // secondary
  text3:        '#9095A0',    // muted — neutral gray, NOT purplish

  // Semantic (status only, not UI chrome)
  danger:       '#D93025',
  info:         '#2D5BFF',
  warning:      '#D4770A',
  purple:       '#962DFF',

  // Borders
  border:       '1.5px solid rgba(0,0,0,0.08)',
  borderThin:   '1px solid rgba(0,0,0,0.06)',

  // Radius
  rCard:        '18px',
  rBtn:         '32px',
  rInput:       '11px',
  rSm:          '8px',
  rMd:          '12px',

  // Shadows
  shSm:         '0 1px 4px rgba(0,0,0,0.05)',
  shMd:         '0 3px 12px rgba(0,0,0,0.08)',
  shLg:         '0 4px 20px rgba(0,0,0,0.12)',
};

// Dark theme
const D = {
  green:      '#00C694',
  mint:       '#BEF6E9',
  pageBg:     '#080D12',           // deep canvas
  cardBg:     'transparent',       // border-only, no fill
  sideBg:     '#0C1219',           // solid elevated sidebar + top bar
  modalBg:    '#0C1219',           // solid fill for modal overlay
  sideActive: 'rgba(255,255,255,0.06)',
  sectionAlt: 'rgba(255,255,255,0.03)',
  text1:      '#F0F4F8',           // primary — brighter for deep bg
  text2:      '#A8B5C0',           // secondary
  text3:      '#546070',           // muted
  border:     '1.5px solid rgba(255,255,255,0.12)',
  borderThin: '1px solid rgba(255,255,255,0.08)',
  rCard:      '18px',
  rBtn:       '32px',
  shSm:       '0 0 0 1px rgba(255,255,255,0.12)',  // border-emphasis outline
  shMd:       '0 3px 16px rgba(0,0,0,0.40)',
  shPanel:    '-8px 0 32px rgba(0,0,0,0.50)',       // right panel shadow
};
```

---

## 4. TYPOGRAPHY SCALE

Always use `font-family: var(--font)` / `fontFamily: "'Inter', sans-serif"`.

| Role | Size | Weight | Line Height | Usage |
|---|---|---|---|---|
| Dashboard title | 14.5–15px | 700 | 1.3 | Top bar page title |
| H2 | 36px | 700 | 46px | Section headings (presentation) |
| H3 | 24px | 700 | 34px | Subsection headings |
| Card title | 17–18px | 700 | 1.45 | Ultimate Goal title, major card heading |
| Row title | 13px | 700 | 1.45 | KR names, goal row titles |
| Type label | 9.5px | 700 | 1.3 | UPPERCASE, letter-spacing: 0.10em, color: text-muted — identifies card entity type |
| Body / row | 12–12.5px | 400–500 | 1.5–1.6 | Table cells, list rows, body text |
| Caption | 11–11.5px | 400–500 | 1.4 | Stage labels, timestamps, meta fields |
| Micro | 10–10.5px | 600–700 | 1.3 | Timeframe pills, connector labels |

**Rules:** Max 4 font sizes per view. Max 3 text shades (text1 / text2 / text3).

---

## 5. COMPONENT PATTERNS

### 5.1 Cards

```css
.card {
  background: var(--card-bg);           /* #FFFFFF */
  border: var(--border-card);           /* 1.5px solid rgba(0,0,0,0.08) */
  border-radius: var(--radius-card);    /* 18px */
  box-shadow: var(--shadow-sm);
  padding: 14px 16px;
  transition: box-shadow 0.16s ease, transform 0.16s ease;
}

.card--interactive:hover {
  box-shadow: var(--shadow-md);
  transform: translateY(-1px);
}
```

**Rule:** Cards are defined by border only — never fill color.

---

### 5.2 Buttons

```css
/* Primary CTA */
.btn-primary {
  background: var(--kafi-green);
  color: #FFFFFF;
  border: none;
  border-radius: var(--radius-button);
  padding: 5px 16px;
  font-size: 12.5px;
  font-weight: 700;
  cursor: pointer;
}

/* Secondary / outline */
.btn-outline {
  background: transparent;
  color: var(--text-secondary);
  border: var(--border-card);
  border-radius: var(--radius-button);
  padding: 5px 14px;
  font-size: 12.5px;
}

/* Sizes */
.btn--sm { height: 30px; padding: 0 12px; font-size: 11.5px; }
.btn--md { height: 36px; padding: 0 16px; font-size: 12.5px; }
.btn--lg { height: 44px; padding: 0 22px; font-size: 14px;   }
```

---

### 5.3 Type Labels

Type labels identify the entity kind on a card. Always neutral muted — never colored.

```css
.type-label {
  font-size: 9.5px;
  font-weight: 700;
  letter-spacing: 0.10em;
  text-transform: uppercase;
  color: var(--text-muted);   /* #9095A0 — neutral only, no blue/teal/green */
  display: block;
  margin-bottom: 6px;
}
```

React:
```jsx
function TypeLabel({ label }) {
  return (
    <span style={{ fontSize: 9.5, fontWeight: 700, letterSpacing: '0.10em',
      textTransform: 'uppercase', color: T.text3 }}>
      {label}
    </span>
  );
}
```

---

### 5.4 Status Badges

```css
/* Prefer neutral plain text over colored chips in product tools */
.stage-label { font-size: 11px; color: var(--text-muted); }

/* Explicit RAG status only */
.badge { padding: 2px 8px; border-radius: 20px; font-size: 10.5px; font-weight: 600; }
.badge--green  { background: var(--color-success-bg);  color: var(--color-success-text); }
.badge--yellow { background: var(--color-warning-bg);  color: var(--color-warning-text); }
.badge--red    { background: var(--color-danger-bg);   color: var(--color-danger-text);  }
```

RAG convention: On Track → `--kafi-teal` text; At Risk → `--color-warning`; Off Track → `--color-danger`; plain stage (Active/Closed) → `--text-muted` plain text, no chip.

---

### 5.5 Progress Bars

```css
/* Inline (inside cards / list rows) — thin */
.progress-track {
  height: 3px;
  background: var(--kafi-mint);   /* #D8F5EE */
  border-radius: 4px;
  width: 100%;
}
.progress-fill {
  height: 100%;
  background: var(--kafi-green);
  border-radius: 4px;
  transition: width 0.4s ease;
}

/* Standalone KPI context — thicker */
.progress-track--lg { height: 6px; border-radius: 99px; }

/* Dark theme — same green fill, low-opacity green track (NOT mint — too bright on deep bg) */
.progress-track--dark {
  height: 3px;
  background: rgba(0,198,148,0.18);   /* Same hue as fill, 18% opacity — soft pairing */
  border-radius: 4px;
}
/* Standalone dark context */
.progress-track--dark-lg {
  height: 5px;
  background: rgba(0,198,148,0.18);
}
```

**Dark theme progress bar rule:** Use `rgba(0,198,148,0.18)` as the track — not `#BEF6E9` (too bright/contrasting on deep canvas). The track and fill share the same hue, making them read as a pair without the track competing for attention.

Progress ring (detail panels):
```jsx
function ProgressRing({ value = 0, size = 36 }) {
  const r = (size - 5) / 2, circ = 2 * Math.PI * r;
  return (
    <svg width={size} height={size} viewBox={`0 0 ${size} ${size}`}>
      <circle cx={size/2} cy={size/2} r={r} fill="none" stroke={T.mint} strokeWidth={3.5}/>
      <circle cx={size/2} cy={size/2} r={r} fill="none" stroke={T.green} strokeWidth={3.5}
        strokeDasharray={`${circ*value/100} ${circ}`} strokeLinecap="round"
        transform={`rotate(-90 ${size/2} ${size/2})`}/>
      <text x={size/2} y={size/2+3.5} textAnchor="middle" fontSize={9.5} fontWeight={700} fill={T.text1}>
        {value}%
      </text>
    </svg>
  );
}
```

---

### 5.6 Sidebar Navigation (Light Theme)

White background, text-only nav items, green left-border active indicator. **No icons anywhere in the sidebar.**

```css
.sidebar {
  width: 200px;
  background: var(--sidebar-bg);        /* #FFFFFF */
  border-right: var(--border-sidebar);  /* 1px solid rgba(0,0,0,0.06) */
  display: flex;
  flex-direction: column;
  font-family: var(--font);
}

.sidebar__logo {
  padding: 14px 18px;
  border-bottom: var(--border-internal);
}

/* Main nav item */
.sidebar__item {
  padding: 7px 18px;
  font-size: 12.5px;
  font-weight: 400;
  color: var(--text-muted);         /* #9095A0 */
  cursor: pointer;
  transition: color 0.12s;
}
.sidebar__item:hover          { color: var(--text-secondary); }
.sidebar__item--open          { background: var(--sidebar-active-bg); color: var(--text-primary); font-weight: 600; }

/* Subview item */
.sidebar__subitem {
  padding: 7px 18px;
  font-size: 12.5px;
  border-left: 2px solid transparent;
  color: var(--text-muted);
  cursor: pointer;
  transition: all 0.12s;
}
.sidebar__subitem:hover        { color: var(--text-secondary); }
.sidebar__subitem--active {
  border-left: var(--border-nav-active);   /* 2px solid #00C694 */
  background: rgba(0,198,148,0.08);
  color: var(--kafi-green);
  font-weight: 600;
}

/* Status dot at bottom */
.sidebar__status {
  margin-top: auto;
  padding: 12px 18px;
  border-top: var(--border-internal);
  display: flex;
  align-items: center;
  gap: 7px;
  font-size: 11px;
  color: var(--text-muted);
}
```

React active item pattern:
```jsx
<div style={{
  padding: '7px 18px', fontSize: 12.5, cursor: 'pointer',
  borderLeft: isActive ? `2px solid ${T.green}` : '2px solid transparent',
  color: isActive ? T.green : T.text3,
  fontWeight: isActive ? 600 : 400,
  background: isActive ? 'rgba(0,198,148,0.08)' : 'transparent',
  transition: 'all 0.12s',
}} />
```

---

### 5.7 Top Bar

```css
.topbar {
  background: var(--card-bg);
  height: 50px;
  padding: 0 22px;
  border-bottom: var(--border-internal);
  display: flex;
  align-items: center;
  gap: 10px;
  box-shadow: var(--shadow-sm);
  flex-shrink: 0;
}

.topbar__title { font-size: 14.5px; font-weight: 700; color: var(--text-primary); }

.topbar__pill {
  padding: 4px 11px;
  border: var(--border-card);
  border-radius: 20px;
  font-size: 12px;
  background: transparent;
  color: var(--text-secondary);
  cursor: pointer;
}
```

---

### 5.8 Avatars (Neutral)

In light-theme product surfaces, avatars use a neutral gray background — not colored by role.

```css
.avatar {
  border-radius: 50%;
  background: rgba(0,0,0,0.08);   /* neutral — NOT colored */
  color: var(--text-secondary);
  display: flex;
  align-items: center;
  justify-content: center;
  font-weight: 700;
  flex-shrink: 0;
}
.avatar--xs { width: 16px; height: 16px; font-size: 6px;   }
.avatar--sm { width: 20px; height: 20px; font-size: 7.5px; }
.avatar--md { width: 32px; height: 32px; font-size: 12px;  }
.avatar--lg { width: 48px; height: 48px; font-size: 18px;  }
```

React:
```jsx
function Avatar({ name = '', size = 20 }) {
  const letters = name.split(' ').map(w => w[0]||'').join('').slice(0,2).toUpperCase();
  return (
    <div style={{ width:size, height:size, borderRadius:'50%',
      background:'rgba(0,0,0,0.08)', color:T.text2,
      display:'flex', alignItems:'center', justifyContent:'center',
      fontSize:size*0.38, fontWeight:700, flexShrink:0 }}>
      {letters}
    </div>
  );
}
```

---

### 5.9 KPI Metric Card

```css
.kpi-card { background:var(--card-bg); border:var(--border-card); border-radius:var(--radius-card); padding:var(--sp5); }
.kpi-card__label { font-size:9.5px; font-weight:700; color:var(--text-muted); text-transform:uppercase; letter-spacing:0.10em; }
.kpi-card__value { font-size:28px; font-weight:700; color:var(--text-primary); line-height:1.2; }
.kpi-card__delta--up   { color:var(--kafi-green); font-size:13px; font-weight:500; }
.kpi-card__delta--down { color:var(--color-danger); font-size:13px; }
.kpi-card__delta--flat { color:var(--text-muted); font-size:13px; }
```

---

### 5.10 Data Tables / List Views

```css
.list-view {
  background: var(--card-bg);
  border: var(--border-card);
  border-radius: var(--radius-card);
  overflow: hidden;
}

.list-view__header {
  display: grid;
  padding: 9px 20px;
  background: var(--table-header-bg);  /* #F7F8FA */
  border-bottom: var(--border-card);
}

.list-view__header-cell {
  font-size: 10.5px; font-weight: 600; color: var(--text-muted);
  text-transform: uppercase; letter-spacing: 0.07em;
}

.list-view__row {
  display: grid;
  padding: 10px 20px;
  border-bottom: var(--border-internal);
  align-items: center;
}

.list-view__row:last-child { border-bottom: none; }
```

---

### 5.11 Detail Panel (Right Drawer)

```css
.detail-panel {
  width: 460px;
  flex-shrink: 0;
  background: var(--card-bg);
  border-left: var(--border-card);
  box-shadow: -4px 0 20px rgba(0,0,0,0.06);
  display: flex;
  flex-direction: column;
  overflow: hidden;
}

.detail-panel__header { padding: 18px 22px 16px; border-bottom: var(--border-internal); }
.detail-panel__body   { flex: 1; overflow-y: auto; padding: 0 22px; }
.detail-panel__meta   { border-top: var(--border-card); padding: 16px 22px; background: var(--section-alt); }

.meta-row { display: flex; align-items: center; margin-bottom: 10px; }
.meta-row__label { font-size: 11.5px; color: var(--text-muted); min-width: 116px; }
```

---

### 5.12 Modal

```css
.modal-overlay {
  position: fixed; inset: 0;
  background: rgba(10,18,28,0.38);
  display: flex; align-items: center; justify-content: center;
  z-index: 999;
}
.modal {
  background: var(--card-bg);
  border-radius: 20px;
  width: 640px; max-height: 90vh; overflow: auto;
  box-shadow: 0 24px 64px rgba(0,0,0,0.20);
  animation: modalIn 0.18s ease;
}
.modal__header { padding: 17px 24px; border-bottom: var(--border-internal); display: flex; align-items: center; justify-content: space-between; }
.modal__footer { padding: 13px 24px; border-top: var(--border-internal); display: flex; justify-content: flex-end; gap: 10px; }

@keyframes modalIn {
  from { opacity:0; transform:scale(0.97) translateY(6px); }
  to   { opacity:1; transform:scale(1) translateY(0); }
}
```

---

### 5.13 Connector Lines (Hierarchy Maps)

```css
/* Vertical dashed connector between hierarchy levels in strategy maps */
.connector {
  width: 1px;
  height: 22px;
  border-left: 1px dashed rgba(0,0,0,0.15);
  flex-shrink: 0;
}
```

---

### 5.14 Section Header Rows (Inside Panels)

```css
.section-row {
  display: flex; align-items: center; gap: 8px;
  padding: 12px 0;
  border-bottom: var(--border-internal);
}
.section-row__label { font-weight: 600; font-size: 12.5px; color: var(--text-primary); }
.section-row__count {
  font-size: 11px; color: var(--text-muted);
  background: rgba(0,0,0,0.05);
  padding: 1px 7px; border-radius: 20px;
}
```

---

### 5.15 Bottom Sheet (Mobile)

```css
.sheet {
  position: fixed; bottom: 0; left: 0; right: 0;
  background: var(--card-bg);
  border-radius: 24px 24px 0 0;
  border-top: var(--border-card);
  box-shadow: var(--shadow-xl);
  max-width: 430px; margin: 0 auto;
}
.sheet__handle { width:36px; height:4px; border-radius:99px; background:rgba(0,0,0,0.12); margin:12px auto 0; }
.sheet__body   { padding: var(--sp5); background: #FFFFFF; }
```

---

## 6. LAYOUT SYSTEM

### Dashboard Layout

```
┌────────────────────────────────────────────────────────────────┐
│ SIDEBAR (200px)        │  TOP BAR (50px, full width)           │
│ White, border-right    ├───────────────────────────────────────┤
│                        │  MAIN CONTENT (flex:1, overflow:auto) │
│  Logo (22px height)    │  padding: 22–28px                     │
│  ─────────────────     │                                       │
│  Main nav (text only)  │  [VIEW CONTENT]                       │
│  ─────────────────     │                                       │
│  Subview nav           │  RIGHT PANEL (460px, conditional)     │
│   Active: green left   │  slides in when item selected         │
│   border + tint        │                                       │
│  ─────────────────     │                                       │
│  Status dot            │                                       │
└────────────────────────────────────────────────────────────────┘
```

### Spacing Rules

- **Between major sections:** `--sp9` = 96px
- **Between cards in a section:** `--sp4` = 16px
- **Inside a card:** 14px 16px
- **Between label and value:** 6–8px gap
- **Sidebar nav item:** 7px 18px padding
- **Top bar height:** 50px

### Grid

| Breakpoint | Columns | Gutter | Max Width |
|---|---|---|---|
| Desktop | 12 | 24px | 1440px |
| Tablet | 8 | 16px | 1024px |
| Mobile | 4 | 16px | 430px |

---

## 7. CONTENT FLOW FRAMEWORK

All Kafi dashboards follow this 5-step flow:

| Step | Section | Question answered | Example content |
|---|---|---|---|
| **01** | `#sec-pulse` | What's happening now? | Overall score, top-line KPIs |
| **02** | `#sec-attention` | What's at risk? | RAG items, deadline alerts |
| **03** | `#sec-objectives` | Why does it matter? | Objective cards + KR progress |
| **04** | `#sec-confidence` | Who's confident and why? | Heatmap, blockers |
| **05** | `#sec-cadence` | What to do next? | Action items, ownership table |

---

## 8. COLOR USAGE RULES

### Light Theme — Green-Only Accent

In light-theme product surfaces, **green is the only UI accent color**:

| Element | Value |
|---|---|
| CTA button | `#00C694` fill |
| Active nav left border | `2px solid #00C694` |
| Active nav text | `#00C694` |
| Active nav tint | `rgba(0,198,148,0.08)` |
| Progress fill | `#00C694` |
| Focus ring | `1.5px solid #00C694` |
| Interactive link | `#00C694` |
| Status dot (online) | `#00C694` |

Blue / purple / red → semantic status badges only. Never for UI chrome.

### 60 / 30 / 10 Ratio (Light)

| Proportion | Colors | Usage |
|---|---|---|
| **60%** | `#FFFFFF`, `#F2F4F7`, `#F7F8FA` | Backgrounds, canvas |
| **30%** | `#101820`, `#585667`, `#9095A0` | Typography hierarchy |
| **10%** | `#00C694`, `#D8F5EE` | CTAs, active states, progress |

### Semantic Color Rules

- **On Track** → `--kafi-teal` (#07756D) text; `--kafi-green` fills
- **At Risk** → `--color-warning` (#D4770A)
- **Off Track** → `--color-danger` (#D93025)
- **Plain stage label** → `--text-muted` plain text, no background chip

---

## 9. BRAND COLORS QUICK REFERENCE

| Name | Hex | Role |
|---|---|---|
| Kafi Green | `#00C694` | CTA, progress, active, brand primary |
| Kafi Teal Deep | `#07756D` | On Track text, section headers |
| Kafi Teal Mid | `#0C6070` | Hover, supporting |
| Kafi Dark | `#101820` | Headings, primary text |
| Kafi Yellow | `#F9CC4E` | Warnings, deadlines |
| Kafi Mint | `#D8F5EE` | Progress tracks (light theme) |
| Kafi Mint Light | `#E6FBF4` | Success bg, focus highlight |
| Info Blue | `#2D5BFF` | Semantic info only |
| Purple | `#962DFF` | Semantic premium / KAI only |
| Danger Red | `#D93025` | Semantic error / off-track only |

---

## 10. ANIMATION

```css
@keyframes fadeIn {
  from { opacity:0; transform:translateY(4px); }
  to   { opacity:1; transform:translateY(0);   }
}

@keyframes modalIn {
  from { opacity:0; transform:scale(0.97) translateY(6px); }
  to   { opacity:1; transform:scale(1) translateY(0);      }
}

.animate-in { animation: fadeIn 0.22s ease forwards; }

.stagger-in:nth-child(1) { animation: fadeIn 0.5s 0.05s ease forwards; opacity:0; }
.stagger-in:nth-child(2) { animation: fadeIn 0.5s 0.10s ease forwards; opacity:0; }
.stagger-in:nth-child(3) { animation: fadeIn 0.5s 0.15s ease forwards; opacity:0; }
.stagger-in:nth-child(4) { animation: fadeIn 0.5s 0.20s ease forwards; opacity:0; }
.stagger-in:nth-child(5) { animation: fadeIn 0.5s 0.25s ease forwards; opacity:0; }
```

Use for: view transitions, modal entry, card hover lift, progress bar fill on mount.
Do NOT animate: table row data, inline values, anything that could disorient.

---

## 11. DARK THEME — CARD & SURFACE RULES

### 11.1 Border-Only Cards (Standard)

Dark theme cards use **no fill** — borders define the shape. This creates a clean, high-contrast look against the deep page canvas.

```css
.card--dark {
  background: transparent;
  border: 1.5px solid rgba(255,255,255,0.12);
  border-radius: var(--radius-card);   /* 18px */
}

/* Table/list header row inside a border-only card */
.card--dark .list-header {
  background: rgba(255,255,255,0.05);  /* Subtle tint to separate header */
  border-bottom: 1.5px solid rgba(255,255,255,0.12);
}
```

React:
```jsx
// Standard dark card — no fill, border only
<div style={{
  background: 'transparent',
  border: '1.5px solid rgba(255,255,255,0.12)',
  borderRadius: D.rCard,
}} />
```

### 11.2 Solid Surface Elements

Sidebar, top bar, and modals use a **solid dark surface** (`#0C1219`) to maintain clear separation from the transparent canvas.

```css
.sidebar--dark, .topbar--dark { background: #0C1219; }
.modal--dark {
  background: #0C1219;
  border: 1.5px solid rgba(255,255,255,0.12);
  box-shadow: 0 24px 64px rgba(0,0,0,0.70);
}
```

### 11.3 Background Canvas

```css
body.dark {
  background: #080D12;
  /* Subtle brand glow at top — optional */
  background-image: radial-gradient(
    ellipse 60% 35% at 50% -5%,
    rgba(0,198,148,0.06) 0%,
    transparent 55%
  );
}
```

### 11.4 Glassmorphism (Use Sparingly)

Reserve glass effects for floating overlays only (tooltips, popovers, dropdown menus). Never on main card surfaces.

```css
.glass-overlay {
  background: rgba(12,18,25,0.85);
  backdrop-filter: blur(16px);
  -webkit-backdrop-filter: blur(16px);
  border: 1px solid rgba(255,255,255,0.10);
  border-radius: var(--radius-md);
}
```


---

## 11A. DARK THEME — NAVIGATION ACTIVE STATE

### Sidebar Active Item (dark)

Same left-border pattern as light theme but with adjusted colors for the dark surface.

```css
/* Active subview item */
.sidebar__subitem--active--dark {
  border-left: 2px solid #00C694;
  background: rgba(0,198,148,0.08);    /* Slightly stronger tint on dark */
  color: #00C694;
  font-weight: 600;
}

/* Parent nav group — no highlight when a child is active */
/* Parent item is the same color/weight as all other inactive items */
.sidebar__item--dark {
  color: #546070;       /* var(--text-muted) */
  font-weight: 400;
  background: transparent;  /* NO highlight on parent */
}

.sidebar__item--dark:hover {
  color: #A8B5C0;       /* var(--text-secondary) */
}
```

**Rule:** When a subview item (e.g. Strategy Map) is active, its **parent** nav item (Explore) gets NO background or color treatment — it stays at `--text-muted` like all other inactive items. The active state belongs exclusively to the subview.

React:
```jsx
// Parent nav item — always flat, regardless of which subview is active
<div style={{
  background: 'transparent',
  color: D.text3,        // same as all other inactive items
  fontWeight: 400,
}} />

// Active subview item
<div style={{
  borderLeft: `2px solid ${D.green}`,
  background: 'rgba(0,198,148,0.08)',
  color: D.green,
  fontWeight: 600,
}} />
```

---

## 11B. DARK THEME — ULTIMATE GOAL CARD

The Ultimate Goal card in Strategy Map view uses the **white logo** variant and omits the workspace name as text (it's already in the logo lockup).

```jsx
// CORRECT — logo only, no duplicate text title
<div style={{ background:'transparent', border:D.border,
  borderRadius:D.rCard, padding:'22px 36px', textAlign:'center' }}>

  <TypeLabel label="Ultimate Goal" />

  {/* White logo — centered, no avatar, no text title below */}
  <div style={{ marginTop:16, display:'flex', justifyContent:'center' }}>
    <img src={KAFI_LOGO_WHITE} alt="Kafi" style={{ height:28, display:'block' }} />
  </div>

  {/* Goal description — 16px top margin for breathing room */}
  <div style={{ fontSize:12.5, color:D.text2, lineHeight:1.7, marginTop:16 }}>
    {UG.desc}
  </div>
</div>
```

**Rules:**
- Use `KAFI_LOGO_WHITE` (see §17) — not the dark logo, not an avatar
- No workspace name text below the logo — the logo lockup already includes "Kafi"
- `marginTop: 16` between logo and description (not 8 or 12 — needs breathing room)
- Logo height: `28px` (larger than sidebar 22px since this is a hero element)


---

## 12. ANTI-PATTERNS — NEVER DO THESE

| ❌ Anti-pattern | ✅ Correct approach |
|---|---|
| Hardcode hex values inline | Use token object / CSS variables |
| Solid colored card backgrounds | Border-only cards (`--border-card`) |
| Fill cards with brand colors | Reserve fills for buttons, progress, badges |
| Sharp corners (0px radius) | Minimum `--radius-sm` = 8px |
| Section spacing < 48px | `--sp9` = 96px between major sections |
| More than 4 font sizes per view | Strict 4-size scale maximum |
| More than 3 text shades | text1 / text2 / text3 only |
| Neon/glow borders | `rgba(0,0,0,0.08)` borders in light theme |
| Glass effect in light theme | Use `--shadow-md` instead |
| Tabbed multi-view layout | Single scrollable view |
| **Icons in sidebar navigation** | **Text-only nav — no emoji, no lucide icons in nav** |
| **Colored type labels on cards** | **Type labels: `--text-muted` only — no blue flags, teal landmarks, green targets** |
| **Colored avatars** | **Neutral gray `rgba(0,0,0,0.08)` bg, `--text-secondary` text** |
| **Multiple accent colors in light UI chrome** | **Green only — blue/purple/red for semantic status only** |
| **Purplish muted text (`#7F7CA2`) in product surfaces** | **Use neutral gray `#9095A0` — purplish tones are dark-theme only** |
| Dark sidebar in light theme | White sidebar with `--border-sidebar` |
| Dark theme On Track in bright green | `--kafi-teal` (#07756D) for On Track text |
| PNG logos with opaque black backgrounds | Use the alpha-transparent base64 PNG from §17 (pre-stripped) — never a drawn SVG substitute |
| **Detail panel meta with light bg on dark theme** | **Use `rgba(255,255,255,0.03)` or `transparent` — never `#FAFCFB`** |
| **Close/hover button using light bg (`#F0F2F5`) on dark** | **Use `rgba(255,255,255,0.08)` for hover state on dark surfaces** |
| **Parent nav item highlighted when child subview is active** | **Only the subview item gets green border + tint; parent stays muted** |
| **Duplicate workspace name below logo in Ultimate Goal card** | **Logo lockup already contains the name — text title is redundant** |
| **Using `#BEF6E9` mint as progress track on dark canvas** | **Use `rgba(0,198,148,0.18)` — same hue, low opacity, no contrast clash** |
| **Glassmorphism on main card surfaces (dark theme)** | **Border-only transparent cards on deep canvas; glass only for floating overlays** |

---

## 13. MOBILE DASHBOARD RULES

```css
.mobile-dashboard { max-width:430px; margin:0 auto; padding:var(--sp4) var(--sp4) 100px; font-family:var(--font); }
.mobile-nav { position:fixed; bottom:0; left:0; right:0; max-width:430px; margin:0 auto; background:var(--card-bg); border-top:var(--border-card); display:flex; justify-content:space-around; padding:var(--sp2) 0; z-index:100; }
.mobile-kpi { font-size:22px; font-weight:700; }
.mobile-tag { font-size:10px; font-weight:500; padding:2px 6px; border-radius:8px; }
.status-dot { width:8px; height:8px; border-radius:50%; flex-shrink:0; }
.dot--green  { background:var(--kafi-green); }
.dot--yellow { background:var(--kafi-yellow); }
.dot--red    { background:var(--color-danger); }
.dot--gray   { background:var(--text-muted); }
```

---

## 14. FONT IMPORT

```html
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700&display=swap" rel="stylesheet">
```

CSS / React: `@import url('https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700&display=swap');`

Excel fallback: `Calibri`

---

## 15. QA CHECKLIST

**Foundation**
- [ ] Font is Inter throughout
- [ ] Page background is `#F2F4F7`
- [ ] No dark fills on cards (white only)
- [ ] All text readable (min 4.5:1 contrast)

**Color discipline**
- [ ] Green (`#00C694`) is the only accent color in UI chrome
- [ ] No blue/purple/red on type labels, nav items, or decorative elements
- [ ] Muted text is `#9095A0` (neutral gray) — not `#7F7CA2` (purplish)
- [ ] Semantic colors appear only in explicit RAG status badges

**Components**
- [ ] CTA buttons: green fill + 32px pill radius
- [ ] Cards: 18px border-radius, white bg, 1.5px border
- [ ] Progress bars: 3px height inline, green fill on `#D8F5EE` track
- [ ] Sidebar: white, 1px right border, text-only nav items (no icons)
- [ ] Active nav: `2px solid #00C694` left border + `rgba(0,198,148,0.08)` bg
- [ ] Type labels: `9.5px / 700 / 0.10em / #9095A0` — no colored icons
- [ ] Avatars: `rgba(0,0,0,0.08)` background, not colored

**Spacing**
- [ ] 96px between major sections
- [ ] 14–16px card padding
- [ ] Top bar height 50px

**Content**
- [ ] No placeholder data — real values, real Vietnamese names
- [ ] Max 4 font sizes per view
- [ ] Max 3 text shades (text1 / text2 / text3)

**Dark theme additional checks**
- [ ] Page canvas is `#080D12` — not `#0F1419` or plain black
- [ ] Cards are `transparent` bg with `rgba(255,255,255,0.12)` border — no fill
- [ ] Sidebar and top bar use `#0C1219` solid (not transparent, not card bg)
- [ ] Modal uses `#0C1219` solid bg — not transparent
- [ ] Active nav item: `2px solid #00C694` left border + `rgba(0,198,148,0.08)` bg
- [ ] Parent nav item (Explore) has NO highlight — same `#546070` as all inactive items
- [ ] Progress bar track: `rgba(0,198,148,0.18)` — not `#BEF6E9`
- [ ] Ultimate Goal card: white logo centered, no duplicate workspace title text
- [ ] Detail panel meta footer: `rgba(255,255,255,0.03)` — not `#FAFCFB`
- [ ] Close/hover states use `rgba(255,255,255,0.08)` — no light hex values
- [ ] Text `onBlur` border resets to `rgba(255,255,255,0.10)` — not `rgba(0,0,0,0.08)`
- [ ] Logo in dark sidebar: `KAFI_LOGO_WHITE` base64 — not dark logo

---

## 16. COPY-PASTE: STARTER BLOCKS

### CSS (Light Theme)

```css
@import url('https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700&display=swap');

:root {
  --kafi-green:#00C694; --kafi-teal:#07756D; --kafi-teal-mid:#0C6070;
  --kafi-dark:#101820;  --kafi-yellow:#F9CC4E;
  --kafi-mint:#D8F5EE;  --kafi-mint-light:#E6FBF4;
  --color-success:#00C694; --color-success-bg:#E6FBF4; --color-success-text:#07756D;
  --color-warning:#D4770A; --color-warning-bg:#FFF8E1; --color-warning-text:#A05C00;
  --color-danger:#D93025;  --color-danger-bg:#FFF0F0;  --color-danger-text:#B02020;
  --color-info:#2D5BFF;    --color-info-bg:#EEF2FF;    --color-info-text:#1A3CC8;
  --page-bg:#F2F4F7; --card-bg:#FFFFFF; --sidebar-bg:#FFFFFF;
  --sidebar-active-bg:#F2F4F7; --table-header-bg:#F7F8FA; --section-alt:#FAFCFB;
  --text-primary:#101820; --text-secondary:#585667; --text-muted:#9095A0;
  --text-brand:#00C694;
  --border-card:1.5px solid rgba(0,0,0,0.08);
  --border-internal:1px solid rgba(0,0,0,0.06);
  --border-sidebar:1px solid rgba(0,0,0,0.06);
  --border-nav-active:2px solid #00C694;
  --radius-card:18px; --radius-button:32px; --radius-badge:20px;
  --radius-input:11px; --radius-sm:8px; --radius-md:12px;
  --shadow-sm:0 1px 4px rgba(0,0,0,0.05);
  --shadow-md:0 3px 12px rgba(0,0,0,0.08);
  --shadow-lg:0 4px 20px rgba(0,0,0,0.12);
  --sp1:4px;--sp2:8px;--sp3:12px;--sp4:16px;--sp5:24px;
  --sp6:32px;--sp7:48px;--sp8:64px;--sp9:96px;
  --font:'Inter',sans-serif;
}
* { box-sizing:border-box; margin:0; padding:0; }
body { font-family:var(--font); background:var(--page-bg); color:var(--text-primary); }
```

### React / JS Token Object

```javascript
const T = {
  green:'#00C694', teal:'#07756D', mint:'#D8F5EE', mintLight:'#E6FBF4',
  pageBg:'#F2F4F7', cardBg:'#FFFFFF', sideBg:'#FFFFFF',
  sideActive:'#F2F4F7', tableHeaderBg:'#F7F8FA', sectionAlt:'#FAFCFB',
  text1:'#101820', text2:'#585667', text3:'#9095A0',
  border:'1.5px solid rgba(0,0,0,0.08)', borderThin:'1px solid rgba(0,0,0,0.06)',
  rCard:'18px', rBtn:'32px', rInput:'11px', rSm:'8px', rMd:'12px',
  shSm:'0 1px 4px rgba(0,0,0,0.05)', shMd:'0 3px 12px rgba(0,0,0,0.08)',
};
```

---

---

## 17. BRAND ASSETS — EMBEDDED LOGOS

Pre-processed logo files with transparent backgrounds, ready to use directly. No upload needed.

### Kafi Logo — Dark (for light backgrounds)

This is the standard `KAFI_Logo_Solid_Dark.png` with the black background stripped, resized to 2× retina (144×44px display at 22px height).

**Usage in React:**
```jsx
const KAFI_LOGO_DARK = "data:image/png;base64,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";

// In sidebar or header:
<img src={KAFI_LOGO_DARK} alt="Kafi" style={{ height: 22, display: 'block' }} />
```

**Usage in HTML:**
```html
<img src="data:image/png;base64,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" alt="Kafi" style="height:22px;display:block;">
```

**Raw base64 (2× / 144×44px — use at height:22px):**
```
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
```

**Raw base64 (3× / 216×66px — use at height:22px for high-DPI or height:33px standard):**
```
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
```

### Kafi Logo — White (for dark backgrounds)

This is `KAFI_Logo_Solid_White.png` with the black background stripped. Use this on dark surfaces (`#0F1419`, dark glass cards, etc.).

**Usage in React (dark theme sidebar):**
```jsx
const KAFI_LOGO_WHITE = "data:image/png;base64,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";

<img src={KAFI_LOGO_WHITE} alt="Kafi" style={{ height: 22, display: 'block' }} />
```

**Raw base64 (2× / 144×44px — display at height:22px):**
```
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
```

**Raw base64 (3× / 216×66px):**
```
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
```


### Logo Usage Rules

| Context | Logo version | Height | Notes |
|---|---|---|---|
| Sidebar header (light theme) | Dark logo | 22px | Standard usage |
| Top bar (light theme) | Dark logo | 20–22px | Same asset |
| Report / document header | Dark logo | 28–32px | Use 3× base64 for sharpness |
| Dark background surface | White logo | 22px | Use `KAFI_LOGO_WHITE` base64 above |

### Logo Do's and Don'ts

- ✅ Use on white (`#FFFFFF`) or light gray (`#F2F4F7`) backgrounds
- ✅ Always preserve aspect ratio — never stretch
- ✅ Minimum display height: 18px
- ❌ Do not apply color filters, drop shadows, or opacity
- ❌ Do not place on dark backgrounds (use a light-variant logo instead)
- ❌ Do not crop or rearrange the K mark and wordmark

### ⛔ The logo is a fixed asset — NEVER recreate it

The KAFI logo (the **K mark** + "Kafi" wordmark) is a fixed brand asset. **Do NOT generate, draw, trace, approximate, or recreate it** — no SVG `<line>`/`<path>`/`<text>` mark, no CSS shapes (rotated bars or pseudo-elements), no font-rendered or AI-drawn "Kafi". The mark is a stylized **K** (not an "X"); any recreated version is a brand violation.

**Always embed the official base64 PNG from this section** (brand-accurate, pixel-exact) and match the variant to the surface theme:

| Surface theme | Logo variant | Embed |
|---|---|---|
| **Light** — `#FFFFFF`, `#F2F4F7`, light cards / light-theme mockups | Dark logo | `KAFI_LOGO_DARK` |
| **Dark** — `#0F1419`, `#080D12`, dark glass / sidebars / dark-theme mockups | White logo | `KAFI_LOGO_WHITE` |

Match the variant to the theme **every time**: a light-theme mockup / prototype / design uses `KAFI_LOGO_DARK`; a dark-theme one uses `KAFI_LOGO_WHITE`. Never put the dark logo on a dark surface or the white logo on a light surface — it vanishes.

**There is no SVG fallback and no "approximate" version.** If an environment cannot embed base64, reference the PNG by file path or stop and request the asset — never inline a hand-built substitute.

---

*v2.2 — Updated May 2026. Sources: Kafi Brand Guidelines v2.0 · 17 Design System PDFs · OKR Dashboard v4 · Business Performance Dashboard · Mobile Executive Briefing · Leadership Dashboard · OKR Platform Light Theme (May 2026 build) · OKR Platform Dark Theme refinements (May 2026 build).*
