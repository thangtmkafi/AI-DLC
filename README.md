# KAFI AI-DLC

> **AI-Driven Development Lifecycle for KAFI Securities** · Adaptive 17-stage workflow with two human modes and six role playbooks. Ships as a drop-in package for Claude Code or Kiro IDE.

[![Version](https://img.shields.io/badge/version-0.3-00C694)](CHANGELOG.md)
[![Claude Code](https://img.shields.io/badge/edition-Claude_Code-orange)](releases/v0.3/)
[![Kiro IDE](https://img.shields.io/badge/edition-Kiro-00C694)](releases/v0.3/)

Adapted from [AWS Labs AI-DLC](https://github.com/aws-samples/sample-ai-driven-development-lifecycle) and the Toan Huynh enterprise AI engineering playbook. Maintained by **Kafi Securities Transformation Office**.

---

## What this is

A drop-in workflow package that turns an AI coding agent into a discipline-enforcing partner for engineering work. Two AI IDEs supported with 100% content parity:

- **Claude Code Edition** — for teams using [Claude Code](https://claude.com/product/claude-code)
- **Kiro Edition** — for teams using [Kiro IDE](https://kiro.dev)

Built around:

- **17-stage adaptive workflow** across Pre-Inception → Inception → Construction → Operations
- **Two human modes:** Lite (greenfield + clean inputs) and Standard (brownfield or needs prep)
- **Six role playbooks:** PM · BA · SA · Designer · Dev · DevOps
- **Source-of-truth precedence:** Project KB > Vision > BRDs/PRDs > derived views
- **Compliance by default:** append-only audit trail (always); PDPA/PII enforcement (opt-in)
- **Standardized completion gates:** every stage closes with a 2-option message — *Request Changes* or *Continue*

---

## Pick your edition

| | Claude Code | Kiro IDE |
|---|---|---|
| **Target IDE** | Claude Code (Anthropic) | Kiro IDE (AWS) |
| **Root file** | `CLAUDE.md` | `AGENTS.md` |
| **Rule library** | `.claude/skills/` + `aidlc-rule-details/` | `.kiro/steering/` with YAML `inclusion` modes |
| **Skill loading** | Slash-command or prompt | `#filename` reference in chat |
| **Native spec mode** | — | `.kiro/specs/<feature>/` (requirements + design + tasks) |
| **Latest package** | [`v0.3-claude-code.zip`](releases/v0.3/) | [`v0.3-kiro.zip`](releases/v0.3/) |
| **Introduction** | [HTML](docs/KAFI-AIDLC-Introduction-Claude.html) | [HTML](docs/KAFI-AIDLC-Introduction-Kiro.html) |
| **Handbook** | [HTML](docs/KAFI-AIDLC-Handbook-Claude.html) | [HTML](docs/KAFI-AIDLC-Handbook-Kiro.html) |

Both editions ship the **same rules, same roles, same templates** — only the loading mechanism and folder syntax differ. A team can switch editions without losing institutional knowledge.

---

## Quick start

### Claude Code

```bash
# Download the latest release
wget https://github.com/kafi-securities/kafi-ai-dlc/releases/download/v0.3/kafi-aidlc-v0.3-claude-code.zip
unzip kafi-aidlc-v0.3-claude-code.zip -d my-project/

# Open in Claude Code
cd my-project
claude
```

Claude Code auto-reads `CLAUDE.md` on first prompt. Type `Help me kick off a new project` to begin the AI-DLC workflow.

### Kiro IDE

```bash
# Download the latest release
wget https://github.com/kafi-securities/kafi-ai-dlc/releases/download/v0.3/kafi-aidlc-v0.3-kiro.zip
unzip kafi-aidlc-v0.3-kiro.zip -d my-project/

# Open in Kiro
kiro my-project
```

Kiro auto-loads `AGENTS.md` plus the 8 always-included steering files. Type `#pm` (or `#ba`, `#sa`, etc.) to engage a role guide, or just describe what you want to build.

---

## Repository structure

```
kafi-ai-dlc/
├── README.md                         ← you are here
├── CHANGELOG.md                      ← version history
├── LICENSE                           ← Apache 2.0
├── CONTRIBUTING.md                   ← how to propose changes
│
├── docs/                             ← rendered HTML reference docs
│   ├── KAFI-AIDLC-Introduction-Claude.html    (high-level overview)
│   ├── KAFI-AIDLC-Introduction-Kiro.html
│   ├── KAFI-AIDLC-Handbook-Claude.html        (per-stage reference)
│   └── KAFI-AIDLC-Handbook-Kiro.html
│
├── packages/                         ← editable source for each platform
│   ├── claude-code/                  ← Claude Code edition source
│   │   ├── README.md                 ← Claude-specific setup
│   │   ├── CLAUDE.md                 ← root context file
│   │   ├── .claude/
│   │   │   ├── settings.json
│   │   │   └── skills/kafi/
│   │   │       ├── design-system/SKILL.md
│   │   │       └── roles/ (6 files)
│   │   └── aidlc-rule-details/       ← workflow rule library
│   │       ├── common/ · pre-inception/ · inception/
│   │       ├── construction/ · operations/ · extensions/
│   │       └── templates/ (11 artifact templates)
│   │
│   └── kiro/                         ← Kiro edition source
│       ├── README.md                 ← Kiro-specific setup
│       ├── AGENTS.md                 ← root agent context (universal agents.md spec)
│       └── .kiro/
│           ├── settings/config.json
│           ├── steering/             ← rule library with YAML inclusion modes
│           │   ├── kafi-design-system.md      (inclusion: always)
│           │   ├── common/ (6)                (inclusion: always)
│           │   ├── roles/ (6)                 (inclusion: manual)
│           │   ├── pre-inception/ (6)         (inclusion: manual)
│           │   ├── inception/ (9)             (inclusion: manual)
│           │   ├── construction/ (6)          (inclusion: manual)
│           │   ├── operations/ (2)            (inclusion: manual)
│           │   └── extensions/                (mixed)
│           ├── specs/_template/      ← spec-driven blank template
│           └── templates/            ← same 11 templates as Claude edition
│
├── releases/                         ← distributable zips per version
│   └── v0.3/
│       ├── kafi-aidlc-v0.3-claude-code.zip   (120 KB)
│       └── kafi-aidlc-v0.3-kiro.zip          (120 KB)
│
├── tools/                            ← build automation
│   └── build-releases.sh             ← zips packages/ into releases/
│
└── .github/
    ├── ISSUE_TEMPLATE/
    ├── PULL_REQUEST_TEMPLATE.md
    └── workflows/
        └── build-release.yml         ← auto-build zips on tag push
```

---

## Versioning strategy

### Single version, multiple editions

One version number covers both platforms. `v0.3` ships **both** the Claude Code package and the Kiro package — they're always released together with content parity.

```
v0.3
├── kafi-aidlc-v0.3-claude-code.zip
└── kafi-aidlc-v0.3-kiro.zip
```

No `v0.3-claude` vs `v0.3-kiro` split. If a rule change applies to one platform but not the other, that's a parity bug — file an issue.

### Branches

| Branch | Purpose |
|---|---|
| `main` | Stable. Only release-tagged commits. Protected. |
| `develop` | Active work. PRs merge here first. |
| `feature/<name>` | Short-lived feature branches; merge into `develop`. |

**No platform-specific branches.** Every change touches both `packages/claude-code/` and `packages/kiro/` in the same PR.

### Tags + Releases

- Tag from `main` after merging `develop`: `git tag v0.4 && git push --tags`
- GitHub Actions workflow `.github/workflows/build-release.yml` triggers on tag push, builds both zips, attaches to a new GitHub Release.
- `CHANGELOG.md` updated as part of the release PR.

### Parity check (CI gate)

A simple CI script verifies parity on every PR:

```bash
# tools/check-parity.sh (sketch)
diff <(find packages/claude-code -name '*.md' | xargs cat | wc -w) \
     <(find packages/kiro -name '*.md'        | xargs cat | wc -w)
```

Threshold tuneable — small word-count drift is normal (front-matter syntax differs); large drift means content forked accidentally.

---

## How to update the package

### Adding a new rule

1. Decide which folder it belongs to (common / role / stage / extension)
2. Drop the `.md` file into **both** platforms:
   - `packages/claude-code/aidlc-rule-details/<folder>/new-rule.md`
   - `packages/kiro/.kiro/steering/<folder>/new-rule.md` (with YAML front-matter declaring `inclusion: always|manual`)
3. Reference it from `CLAUDE.md` AND `AGENTS.md` if it's a top-level rule
4. Update relevant section in `docs/KAFI-AIDLC-Handbook-*.html`
5. Open PR — CI runs parity check

### Adding a new role

1. Create role guide in **both** locations:
   - `packages/claude-code/.claude/skills/kafi/roles/<role>.md`
   - `packages/kiro/.kiro/steering/roles/<role>.md` (with `inclusion: manual`)
2. Add starter prompt in `docs/KAFI-AIDLC-Introduction-*.html`
3. Add row to Roles table in both `Introduction` files
4. Add row to Skills table in both `Handbook` files

### Changing a template

1. Edit in `packages/claude-code/aidlc-rule-details/templates/<name>.md`
2. Mirror to `packages/kiro/.kiro/templates/<name>.md` (templates have no front-matter — clean copy is fine)
3. Document the change in `CHANGELOG.md`

---

## Roadmap

### v0.4 · Planned

- **Test artifacts** — first-class test stage with template
- **Compliance verification** — pre-deploy stage
- **Operations expanded** — replace placeholder with concrete deploy + monitor specs
- **Project extension YAMLs** — examples for `architecture-boundaries`, `naming-conventions`, `phase-discipline`
- **CI parity check** — Phase 2 of the parity gate (semantic diff, not just word count)

### v0.5 · Speculative

- **Shared core architecture** — `core/` + `adapters/<platform>/` to fully eliminate platform duplication
- **Additional IDE editions** — Cursor, Continue.dev, Windsurf if there's team demand
- **Vietnamese translations** of docs/

### Out of scope

- This repo does **not** contain product code or KOS-MO architecture — those live in separate KAFI repos. AI-DLC is the methodology layer only.
- This repo does **not** distribute the AI models themselves — bring your own Claude / Kiro / local LLM. See companion docs for local LLM deployment guidance.

---

## Contributing

KAFI engineers and partners can propose changes via PR. See [CONTRIBUTING.md](CONTRIBUTING.md) for the full process. Quick summary:

1. Fork or branch from `develop`
2. Make changes **in both** `packages/claude-code/` and `packages/kiro/`
3. Update relevant `docs/*.html` reference docs
4. Add a CHANGELOG entry under `## Unreleased`
5. Open PR — Transformation Office reviews
6. CODEOWNERS approval required for changes in `packages/` or `docs/`

**Out-of-scope contributions:** product-specific rules, project-specific KB content, IDE-specific tooling. These belong in your project repo, not in the platform repo.

---

## License

Apache 2.0 — see [LICENSE](LICENSE). Free to fork, adapt, redistribute. If you adapt for your organization, please credit Kafi Securities and AWS Labs AI-DLC.

---

## Acknowledgments

- [AWS Labs · sample-ai-driven-development-lifecycle](https://github.com/aws-samples/sample-ai-driven-development-lifecycle) — foundational workflow pattern
- **Toan Huynh** — enterprise AI engineering playbook
- [agents.md](https://agents.md) — universal agent context spec adopted in Kiro Edition
- Kafi Securities Transformation Office — KAFI design system, role taxonomy, compliance extensions

---

*Maintained by Kafi Securities Transformation Office · Issues: [github.com/kafi-securities/kafi-ai-dlc/issues](https://github.com/kafi-securities/kafi-ai-dlc/issues)*
