---
name: kafi-code-review-database
description: Database / SQL code reviewer. Invoked by the kafi-code-review router (or directly) to review .sql files, migrations, and schema/ORM definitions for injection, index usage, transaction scope, and migration safety at Stage 14c. Checks sqlfluff, migration linters.
inclusion: manual
---

# Skill: kafi-code-review-database

## Tooling baseline
- **Lint:** sqlfluff (dialect-aware) · pg_lint / equivalent
- **Migrations:** project migration linter (reversibility, locking)

## Critical (blocking) checks
- [ ] No SQL injection surface — parameterized everywhere; no string-built queries from input
- [ ] Migrations forward-compatible — old code works against new schema (additive first); destructive changes (drop column/table) split across two releases
- [ ] Migrations reversible (down provided) OR explicitly flagged irreversible with rationale
- [ ] No long-blocking locks on large tables (e.g. add-column-with-default on hot tables — use safe pattern)
- [ ] Indexes for every foreign key + every column in a WHERE/JOIN/ORDER on a large table
- [ ] Transaction scope correct — no partial-commit on multi-step invariants; isolation level appropriate
- [ ] PII columns classified + protected per privacy extension (encryption/masking); audit columns per audit-trail
- [ ] Constraints match `data-model.md` invariants (NOT NULL, CHECK, UNIQUE, FK)

## Advisory (warning) checks
- Avoid `SELECT *` in app queries
- Naming consistent with conventions (snake_case tables/columns)
- Sensible types (no money in float; use numeric/decimal)
- N+1 patterns flagged (batch / join instead)
- Soft-delete vs hard-delete consistent with policy
- Timezone-aware timestamps

## Output
Per finding: `severity · file:line · rule · what · suggested fix`. Critical → Stage 14c sub-check 1 ✗. Schema mismatches vs `data-model.md` also feed sub-check 1.

## References
- Router: `kafi-code-review` · Stage 14c: `construction/conformance-audit.md`
- `data-model.md` (schema source of truth) · `deployment-runbook.md` (migration execution)
