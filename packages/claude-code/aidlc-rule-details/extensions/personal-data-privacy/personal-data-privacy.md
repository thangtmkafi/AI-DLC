---
extension: personal-data-privacy
category: KAFI-wide
status: opt-in (auto-enable on PII)
---

# Extension: Personal Data Privacy

**KAFI regulatory standard** for handling personal data.

## Rules

### 1. Data classification

Every personal data field tagged:
- **PII** — name, ID, contact details
- **Sensitive PII** — financial, health, biometric
- **Behavioral** — preferences, usage patterns

### 2. Consent tracking

For every personal data collection point:
- Purpose stated explicitly
- Consent timestamp recorded
- Consent revocable

### 3. Data minimization

- Collect only what's needed for stated purpose
- Default retention: shortest reasonable period
- Delete on revocation

### 4. Access control

- Role-based access to personal data
- Audit log every access (per audit-trail extension)
- Encrypted at rest + in transit

### 5. Subject rights

Support data subject:
- Right to access (export their data)
- Right to rectification (correct their data)
- Right to erasure (delete on request, where legal)
- Right to portability (export in standard format)

## Stage hooks

### Requirements Analysis
- Identify PII fields → add to data classification table
- For each PII collection point, require consent design

### Application Design
- Data flow diagrams must show PII flow + consent gates
- Storage choices must support encryption at rest

### Code Generation auto-wires:
- Field-level encryption for Sensitive PII
- Access logging via audit-trail
- Consent check before personal data operations
- Erasure endpoint for subject rights

## Compliance citation

KAFI internal: Decree 13/2023 personal data protection.

## Watch for

- PII in logs (mask before logging)
- PII in URLs (use POST bodies)
- PII in error messages (sanitize)
- PII in third-party API calls (review contracts)
