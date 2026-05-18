---
extension: personal-data-privacy
category: KAFI-wide
status: opt-in (auto-enable on PII)
trigger: artifact touches personal data
---

# Extension: Personal Data Privacy (Opt-in)

Auto-enables when any artifact (requirement, story, code) touches personal data.

## Triggers (auto-enable when detected)

- Customer name, ID, phone, email
- Financial profile data
- Identity documents
- Behavioral / preference data
- Any field tagged "PII" in data model

## What happens when enabled

Load `personal-data-privacy.md` (full rules).

Add compliance summary at every stage:
- Privacy: ✓ enabled (auto)

Inject privacy considerations into:
- Requirements (data classification)
- Application Design (data flow + consent points)
- Code Generation (encryption, masking, access control)

## How to manually enable

In `ai-dlc/project.md`, under the `## Active Extensions` section, add:

```markdown
- `personal-data-privacy` — enabled (manual)
```

This is mostly unnecessary in practice — the extension auto-enables whenever any artifact touches PII fields.

## How to disable

Cannot be disabled when PII is touched. Required by KAFI regulatory standard.
