# KAFI AI-DLC v0.3 · Kiro Port

**Drop-in package for Kiro IDE.** Ports the original Claude Code package (`CLAUDE.md` + `.claude/skills/`) to Kiro's native `AGENTS.md` + `.kiro/steering/` conventions.

> **Companion docs:** `KAFI-AIDLC-Introduction.html` · `KAFI-AIDLC-Handbook.html` for narrative reference.

---

## Quick start

```bash
# Drop this package into your project root
cp -r kafi-aidlc-v03-kiro/* my-project/
cp -r kafi-aidlc-v03-kiro/.kiro my-project/

# Open in Kiro IDE
kiro my-project

# Kiro will auto-detect AGENTS.md + .kiro/steering/ on first chat
```

Then in Kiro chat:

```
@AGENTS.md
Help me plan a new AI-DLC project.
```

The AI agent will read AGENTS.md (always-loaded), plus everything in `.kiro/steering/` flagged `inclusion: always` (common rules, design system, audit-trail).

---

## Folder structure

```
project-root/
├── AGENTS.md                          # universal agent context (Kiro auto-reads)
├── README.md                          # this file
├── .kiro/
│   ├── settings/
│   │   └── config.json                # Kiro workspace config
│   ├── steering/                      # 39 rule files
│   │   ├── kafi-design-system.md      # always
│   │   ├── common/ (6)                # always — process rules
│   │   ├── roles/ (6)                 # manual — PM/BA/SA/Designer/Dev/DevOps
│   │   ├── pre-inception/ (6)         # manual — sub-flows A/B/C/D
│   │   ├── inception/ (9)             # manual — 9 stages
│   │   ├── construction/ (6)          # manual — 6 stages
│   │   ├── operations/ (2)            # manual — placeholder
│   │   └── extensions/ (3)            # mix — audit-trail always, PDPA manual
│   ├── specs/
│   │   └── _template/                 # blank Kiro spec template
│   │       ├── spec.json
│   │       ├── requirements.md
│   │       ├── design.md
│   │       └── tasks.md
│   └── templates/                     # 11 AI-DLC artifact templates
│       ├── vision.md · adr.md · user-story.md
│       ├── requirements.md · functional-design.md
│       ├── nfr-requirements.md · nfr-design.md
│       ├── application-design.md · components.md
│       ├── technical-environment.md · unit-of-work.md
└── 00-knowledge/                      # YOUR project KB (you create this)
    ├── architecture/
    ├── glossary/
    ├── conventions/
    └── context-pins.md
```

---

## How Kiro loads steering files

Each `.md` file in `.kiro/steering/` has YAML front-matter:

```yaml
---
inclusion: always
description: "Process Overview"
---
```

Three inclusion modes:

| Mode | When loaded | Example files |
|---|---|---|
| `always` | Every chat session | common rules, design system, audit-trail |
| `manual` | When user types `#filename` in chat | role guides, stage rules, opt-in extensions |
| `fileMatch` | When matching files referenced in chat | (not used in v0.3; reserve for v0.4) |

To load a role manually: `#sa` → loads `.kiro/steering/roles/sa.md`
To load a stage: `#requirements-analysis` → loads `.kiro/steering/inception/requirements-analysis.md`

---

## Key differences from Claude Code package

| | Claude Code v0.3 | Kiro v0.3 |
|---|---|---|
| Root rules file | `CLAUDE.md` | `AGENTS.md` (universal agents.md spec) |
| Skills folder | `.claude/skills/kafi/` | `.kiro/steering/` |
| Loading mechanism | Plugin / SKILL.md discovery | YAML front-matter `inclusion` mode |
| Manual skill load | Slash-command or explicit prompt | `#filename` in chat |
| Settings | `.claude/settings.json` | `.kiro/settings/config.json` |
| Spec-driven mode | Not native | `.kiro/specs/<feature>/` with `requirements.md` + `design.md` + `tasks.md` |
| Templates | `aidlc-rule-details/templates/` | `.kiro/templates/` |

**Content parity:** All 53 rule + role + template files from v0.3 are preserved. Only paths and front-matter are reorganized for Kiro idioms.

---

## Two ways to use this package

### A · AI-DLC workflow (full lifecycle)

Use when starting a new project from intent to production. Kiro will route through the 17-stage workflow defined in AGENTS.md.

```
You: Help me kick off a new AI-DLC project for [feature]
Kiro: [reads AGENTS.md, common rules, design system; asks Mode question; runs Pre-Inception if Standard mode]
```

### B · Kiro spec-driven (single feature)

Use when you have a scoped feature and want lightweight requirements/design/tasks artifacts. Copy `_template/`:

```bash
cp -r .kiro/specs/_template .kiro/specs/my-feature
# Edit spec.json with feature name + owner
# Fill in requirements.md
```

Then:
```
You: #requirements
     Let's flesh out the user stories for my-feature
Kiro: [reads .kiro/specs/my-feature/requirements.md and helps iterate]
```

The two modes are complementary. AI-DLC Inception output feeds Kiro spec `requirements.md` and `design.md`.

---

## Verification checklist

After dropping into a project:

- [ ] `AGENTS.md` visible at root
- [ ] `.kiro/steering/` contains 39 .md files
- [ ] `.kiro/templates/` contains 11 .md files
- [ ] `.kiro/specs/_template/` contains 4 files (spec.json + 3 .md)
- [ ] `00-knowledge/` directory created (empty is fine; populate as you go)
- [ ] Kiro IDE shows AGENTS.md in agent context panel
- [ ] Test load: type `#sa` in chat → SA role guide should appear

---

## Adapting per project

1. **Project KB** — create `00-knowledge/architecture/` and put your canonical reference doc there
2. **Context pins** — create `00-knowledge/context-pins.md` listing the most-relevant KB sections
3. **Project extensions** — drop project-specific YAML into `.kiro/steering/extensions/` (architecture-boundaries, naming-conventions, etc. as defined in AGENTS.md)
4. **Templates override** — if your project needs custom templates, drop them in `00-knowledge/templates/` (overrides `.kiro/templates/`)

---

## Versioning

- **v0.3-kiro** · 15 May 2026 · Initial Kiro port from v0.3 Claude Code package
- Roadmap items deferred to v0.4: test artifacts, compliance verification, full Operations phase, project-extension YAML examples

---

*KAFI Transformation Office · Adapted from AWS Labs AI-DLC + Toan Huynh enterprise playbook*
