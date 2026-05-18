---
inclusion: always
description: "Welcome Message"
---

# Welcome Message

Display this once per session, after Workspace Detection completes.

## Template

```
👋 KAFI AI-DLC Workflow active

Mode: [Lite | Standard] — auto-detected
Project: [name from ai-dlc/project.md]
Phase: [active phase if defined]

I'll guide you through:
  🟦 Pre-Inception (Standard mode only) — get inputs ready
  🟣 Inception — what to build and why
  🟢 Construction — how to build it
  🟠 Operations — deploy and monitor

For every stage:
  • I'll write a plan with questions
  • You answer in [Answer]: tags
  • I generate; you review; we proceed

Override mode anytime by saying "switch to [Lite|Standard] mode".

Next step: [Stage Name] — proceeding...
```

## Behavior

- Display only ONCE per session (check audit.md for prior welcome entry).
- Do not display on resume after session interruption — just announce resumed state.
- Keep terse — full handbook is at `KAFI-AIDLC-Handbook.html`.
