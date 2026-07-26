# KAFI AI-DLC

> **AI-Driven Development Lifecycle for KAFI Securities.** A methodology layer that gives a supported AI coding agent a governed, evidence-first workflow. **The agent executes; humans govern at the gates.**

[![License](https://img.shields.io/badge/license-Apache_2.0-585667)](LICENSE)
[![Agents](https://img.shields.io/badge/agents-Codex_·_Claude_Code_·_Kiro-101820)](#supported-agents)

**What is published today** is listed on the [Releases page](https://github.com/thangtmkafi/AI-DLC/releases). Read the release notes for the version you intend to use, and pin it.

**Docs:** [Introduction (v1.0)](https://thangtmkafi.github.io/AI-DLC/ai-dlc-v1.0-article-vi.html) · [Install / Upgrade + User Guide (v1.0)](https://thangtmkafi.github.io/AI-DLC/ai-dlc-v1.0-install-upgrade-by-prompt.html) · [Documentation index](https://thangtmkafi.github.io/AI-DLC/index.html)

---

<a id="supported-agents"></a>

## One universal release, three agents

AI-DLC v1.0 ships a single universal release. There is no edition to choose and no per-host download.

| Agent | Managed entry file |
|---|---|
| **Codex** | `AGENTS.md` |
| **Claude Code** | `CLAUDE.md` |
| **Kiro IDE** | `AGENTS.md` |

The same committed project state is readable by all three, so work started in one host resumes in another.

---

## How v1.0 installs — by prompt

v1.0 publishes **no installation script**. You paste one prompt into your agent. It discovers the release, inspects your project, and returns an exact plan and its digest. Nothing is created, moved, backed up, or deleted until you approve **that exact digest**.

```text
Use the KAFI AI-DLC Bootstrap Locator at
https://raw.githubusercontent.com/thangtmkafi/AI-DLC/main/.well-known/kafi-aidlc-bootstrap.json.
Inspect this project and the immutable public release, then present the exact
installation or upgrade plan and its digest. Do not create, update, merge,
move, delete, back up, or migrate any project file until I approve that digest.
Preserve the project root README.md.
```

That URL is the single trust anchor. If a page, a message, or an agent offers you a different one, stop.

- **No administrator rights and no new runtime** on supported hosts. On Windows the agent stages through PowerShell 5.1 without changing execution policy and runs no `.ps1`, `.bat`, `.cmd`, or `.exe`.
- **The release is immutable.** Published assets cannot be replaced afterwards, so an approved digest keeps meaning the same bytes.
- **Your root `README.md` is never taken.** AI-DLC packages never claim a consuming project's root README.
- **Direct upgrade from `v0.3`–`v0.9.x`.** No staged hops, and no automatic relocation of your content: anything the plan would move is listed in the plan you approve.

After installation the daily surface is four commands: `/kafi-aidlc-onboarding`, `/kafi-aidlc-status`, `/kafi-aidlc-next`, `/kafi-aidlc-check`. Part 2 of the combined guide covers operating the methodology, not just installing it.

---

## What authorizes a change to your project

An approved plan digest, per operation. The agent shows you the exact plan and its digest, and writes nothing until you approve that digest. Move, delete, migration, repair, upgrade, and adapter changes are explicit rows in that plan — none is inferred, and none is hidden inside an installer.

A merged pull request is never a substitute for an approval.

Releases are immutable, so the digest you approved keeps meaning the same bytes for as long as the release exists.

---

<!-- legacy:v0.x -->
## Legacy v0.x

**Legacy v0.x** — the v0 line is preserved here as history and for existing installations. Its `tools/install.sh`, `tools/install.ps1`, and edition ZIPs are v0.x distribution mechanisms: they can move or back up project content, and they do not implement the v1 approval and transaction model.

Do not treat them as AI-DLC v1. If you depend on a v0 version, pin it exactly and read its release notes before running a legacy installer.

Reaching v1.0 from v0 does not require the v0 installer: the v1 bootstrap prompt migrates `v0.3`–`v0.9.x` directly.
<!-- /legacy -->

---

Licensed under [Apache 2.0](LICENSE).
