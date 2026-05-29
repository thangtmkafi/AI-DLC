---
name: kafi-code-review-typescript
description: TypeScript/JavaScript code reviewer. Invoked by the kafi-code-review router (or directly) to review .ts/.tsx/.js/.jsx files for type safety, lint, and idiomatic pitfalls at Stage 14c. Checks tsc strict, eslint, prettier, type narrowing, exhaustive switches, any-leakage.
inclusion: manual
---

# Skill: kafi-code-review-typescript

## Tooling baseline
- **Types:** `tsc --noEmit` with `strict: true` (no implicit any, strictNullChecks)
- **Lint:** `eslint` (+ `@typescript-eslint`) · **Format:** `prettier`
- **Deps:** `npm audit` / `pnpm audit`

## Critical (blocking) checks
- [ ] No `any` leakage — explicit `any`, `as any`, or implicit any in public signatures
- [ ] `strictNullChecks` honored — no unchecked `!` non-null assertions on nullable values
- [ ] Exhaustive `switch` on unions (use `never` default-case guard)
- [ ] No floating promises (await or `void` explicitly) — `@typescript-eslint/no-floating-promises`
- [ ] No `// @ts-ignore` without justification comment
- [ ] Error handling: no swallowed catches; typed errors not `catch(e: any)` re-thrown bare
- [ ] Secrets: no hardcoded keys/tokens — env only

## Advisory (warning) checks
- Prefer `type`/`interface` over inline shapes repeated 2+ times
- Prefer discriminated unions over optional-field soup
- Narrowing via type guards over casts
- `readonly` + `const` where mutation isn't needed
- No barrel-file import cycles
- Consistent naming (camelCase vars, PascalCase types)

## Framework hot-spots
- **React:** hook deps arrays complete · no setState in render · keys stable · no derived state duplication
- **Node:** stream/handle cleanup · no sync fs in request path

## Output
Per finding: `severity · file:line · rule · what · suggested fix`. Critical → Stage 14c sub-check 1 ✗.

## References
- Router: `kafi-code-review` · Stage 14c: `construction/conformance-audit.md`
- view-model formats (FE) · api-spec (handlers) are the behavioral contract — this skill checks *how*, the audit checks *conformance to spec*.
