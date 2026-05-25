# CLAUDE.md · KAFI AI-DLC Repo Development Context

> **Auto-loaded by Claude Code on every session start.** This file primes context for developing the AI-DLC platform itself. For current task state and in-flight work, read `SESSION_HANDOFF.md` next.

---

## What this repo is

The methodology layer for KAFI engineering — workflow rules, role guides, templates, and IDE integrations for Claude Code + Kiro IDE.

**This is not a product repo.** No KOS-MO code, no TRS specs, no project-specific knowledge bases live here. Those belong in separate repos that *consume* this one.

Two editions ship in parity:

- `packages/claude-code/` — Claude Code edition · `CLAUDE.md` + `.claude/skills/` + `aidlc-rule-details/`
- `packages/kiro/` — Kiro IDE edition · `AGENTS.md` + `.kiro/steering/` with YAML `inclusion` modes

---

## The one rule that matters most

**Parity rule.** Every change touches both editions in the same PR. Claude Code edition uses no front-matter; Kiro edition uses YAML `inclusion: always|manual`. Content stays in sync between platforms.

If you're about to edit one edition without the other, stop and verify parity will be maintained before writing.

---

## How to engage

| For… | Read |
|---|---|
| Current backlog, in-flight work, resume context | `SESSION_HANDOFF.md` |
| Contribution process, release flow, style | `CONTRIBUTING.md` |
| What the workflow rules actually say | `docs/KAFI-AIDLC-Handbook-Claude.html` or `-Kiro.html` |
| Public-facing intro | `README.md` |

Use the Handbook docs to understand the existing rules before changing them. The rules are content; this repo is the source-of-truth for that content.

---

## Output expectations

- **Markdown:** standard syntax · no extensions
- **Front-matter (Kiro steering files only):** YAML with `inclusion: always|manual` + `description: "..."` · no other keys
- **HTML docs:** KAFI design system v2.2
  - Inter font · JetBrains Mono for code/paths
  - Kafi-green `#00C694` as sole accent color
  - Border-only cards · 18 px radius
  - Maximum 3 text shades — `#101820` / `#585667` / `#9095A0`
  - No emojis except in clearly-marked illustration sections
- **No fabricated authority:** rules cite KAFI's own KB sections, not external "best practices" unless explicitly attributed
- **Voice:** declarative, present tense, brief — *"The agent loads X"* not *"X will be loaded"*
- **Bilingual context:** Vietnamese contextual replies welcome (this is KAFI); English for content/code/file names

---

## File map for orientation

| Path | What it is |
|---|---|
| `SESSION_HANDOFF.md` | Dynamic state · current backlog · resume prompts |
| `CONTRIBUTING.md` | Parity rule details · PR process · release flow |
| `CHANGELOG.md` | Version history · `[Unreleased]` = active backlog |
| `README.md` | Public entry point |
| `LICENSE` | Apache 2.0 |
| `packages/claude-code/` | Source for Claude Code edition |
| `packages/kiro/` | Source for Kiro edition |
| `docs/` | 4 rendered HTML reference docs · both editions |
| `releases/v0.3/` | Built distributable zips |
| `tools/build-releases.sh` | Local build automation |
| `.github/workflows/build-release.yml` | CI: auto-build zips on tag push |
| `.github/PULL_REQUEST_TEMPLATE.md` | PR checklist enforcing parity |

---

## Meta point · this CLAUDE.md vs `packages/claude-code/CLAUDE.md`

There are **two `CLAUDE.md` files** in this repo. They serve different purposes — don't conflate.

| File | Purpose | When changes happen |
|---|---|---|
| `/CLAUDE.md` (this file) | Development context for working ON this repo | Rarely · only when repo conventions change |
| `/packages/claude-code/CLAUDE.md` | The AI-DLC workflow content shipped to end-users | Per release · requires parity with `packages/kiro/AGENTS.md` |

Editing this file affects only how Claude Code engages with this repo for development work.

Editing `packages/claude-code/CLAUDE.md` ships to every KAFI project that uses AI-DLC — and requires parity with the Kiro version.

---

## First-prompt suggestions

See `SESSION_HANDOFF.md` "Suggested first prompts" for full templates. Quick options:

- *"Read SESSION_HANDOFF.md. Propose what to tackle next from the v0.4 backlog."*
- *"Read SESSION_HANDOFF.md. Run a parity check between `packages/claude-code/` and `packages/kiro/`. Report any drift."*
- *"Read CHANGELOG.md and SESSION_HANDOFF.md. Summarize state for me."*

---

## Common pitfalls to avoid

1. **Editing one edition only.** Always touch both Claude Code and Kiro versions in the same PR.
2. **Forgetting Kiro front-matter.** Every `.kiro/steering/*.md` needs `inclusion: always|manual`.
3. **Confusing the two `CLAUDE.md` files.** See meta point above.
4. **Editing release zips directly.** Zips are build artifacts — edit `packages/`, then run `tools/build-releases.sh`.
5. **Updating docs but not packages (or vice versa).** Docs explain the rules; packages contain them. Both must move together.

---

*Stable file. Mutations to current state belong in `SESSION_HANDOFF.md`, not here.*
