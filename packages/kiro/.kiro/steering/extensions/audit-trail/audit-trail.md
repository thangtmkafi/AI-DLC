---
inclusion: always
description: "Extension: Audit Trail"
---

# Extension: Audit Trail

**KAFI regulatory standard.** Every KAFI operational system must produce an immutable audit trail.

## Rules (always enforced)

1. Every state-changing operation must be logged with:
   - Timestamp (ISO 8601)
   - Actor (user ID, system ID — never anonymous)
   - Operation (verb + entity)
   - Before/after state (for non-trivial changes)
   - Correlation ID (for tracing across systems)
2. Audit records are **append-only**. Never updated, never deleted.
3. Field-level audit for sensitive operations (financial transactions, identity changes, permission changes).
4. Audit records stored separately from operational data (different table/store).
5. Retention: minimum 7 years for financial operations.

## Code Generation hooks

When Code Generation runs, auto-wire audit trail:

```typescript
// Example: every state-changing operation gets audit wrapper
async function executeOperation(actor: Actor, op: Operation) {
  const auditEntry = {
    timestamp: new Date().toISOString(),
    actor: actor.id,
    operation: op.name,
    before: snapshot(),
    correlationId: getOrCreateCorrelation(),
  };
  
  const result = await op.execute();
  
  auditEntry.after = snapshot();
  await auditStore.append(auditEntry);  // append-only
  
  return result;
}
```

## Schema requirements

| Field | Type | Notes |
|---|---|---|
| `id` | uuid | Primary key |
| `timestamp` | timestamp_with_tz | ISO 8601 |
| `actor_id` | string | User or system identifier |
| `actor_type` | enum | `user` · `system` · `scheduled` |
| `operation` | string | Verb describing the action |
| `entity_type` | string | Type of object affected |
| `entity_id` | string | ID of the object affected |
| `before_state` | jsonb | nullable for create ops |
| `after_state` | jsonb | nullable for delete ops |
| `correlation_id` | uuid | Trace ID across systems |
| `metadata` | jsonb | IP, user agent, request headers |

## Verification

Auto-generated tests (when test stage exists in v0.4+):
- Every operation in `business-rules.md` has an audit hook
- Audit records have all required fields
- Append-only constraint enforced at DB level

## Compliance citation

KAFI internal: TT 96/2020 audit requirements.
