# API Specification — [Service / Feature]

> Stage 8 deliverable (alongside `components.md`) · SA-owned · for units with external-facing or inter-service APIs
> Contract that Stage 14a code must implement and Stage 14c audits

**Status:** Draft | Approved
**Owner:** [SA name]
**Last updated:** [Date]
**Style:** REST | GraphQL | gRPC
**Base URL / schema:** [/api/v1 · graphql endpoint · proto package]

---

## Conventions

- **Auth:** [Bearer JWT · session · mTLS] · which endpoints are public vs protected
- **Versioning:** [URL `/v1` · header · field]
- **Errors:** standard envelope `{ code, message, details }` · codes table below
- **Pagination:** [cursor · offset] · default page size
- **Idempotency:** [idempotency-key header for POST] where required

## Endpoints

### `POST /deals` — Create a deal

**Auth:** required (role: trader) · **Idempotent:** yes (Idempotency-Key)
**Cites:** REQ-NN · US-NN · entity ENT-NN

**Request:**
```json
{
  "bond_id": "uuid",
  "face_value": 5000000000,
  "yield": 7.25,
  "settlement_date": "2026-06-30"
}
```

**Field rules:** (mirror `data-model.md` + `view-model.md`)
| Field | Type | Required | Constraint |
|---|---|---|---|
| face_value | integer | yes | 1_000_000 ≤ x ≤ 10_000_000_000 |
| yield | number | yes | 0 ≤ x ≤ 100 · 4 dp |
| settlement_date | date | yes | future only |

**Responses:**
| Status | Body | When |
|---|---|---|
| 201 | `{ id, status: "draft" }` | created |
| 422 | `{ code: "VALIDATION", details: [...] }` | field rules fail |
| 401 | `{ code: "UNAUTHORIZED" }` | no/invalid token |
| 409 | `{ code: "DUPLICATE" }` | idempotency replay |

### `GET /deals/:id` — Fetch a deal

[Same shape]

## Error code catalog

| Code | HTTP | Meaning | Retryable |
|---|---|---|---|
| VALIDATION | 422 | Request failed field rules | no |
| UNAUTHORIZED | 401 | Auth missing/invalid | no |
| FORBIDDEN | 403 | Role lacks permission | no |
| NOT_FOUND | 404 | Resource absent | no |
| CONFLICT | 409 | State/idempotency conflict | no |
| RATE_LIMIT | 429 | Too many requests | yes (backoff) |
| INTERNAL | 500 | Server error | yes |

## Rate limits

| Endpoint group | Limit | Window |
|---|---|---|
| write (POST/PUT) | [N] | per minute per user |
| read (GET) | [N] | per minute per user |

## Schemas (shared types)

[Reference `data-model.md` ENT-NN. Declare request/response DTOs that differ from entities.]

---

## Audit hook (Stage 14c · Code audit)

Generated handlers must match this spec: paths, methods, request/response shapes, status
codes, error envelope, auth requirements. Field rules must match `data-model.md` + `view-model.md`.

KB cited: `data-model.md` · `components.md` · REQ-NN · `architecture-boundaries.md`
Related: `view-model.md` (FE consumes these) · `code-flow.md` (call sequences) · ADRs
