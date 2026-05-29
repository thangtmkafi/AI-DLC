---
inclusion: manual
description: "C# code reviewer. Invoked by the kafi-code-review router (or directly) to review .cs files for null safety, async correctness, and idiomatic pitfalls at Stage 14c. Checks Roslyn analyzers, StyleCop."
---

# Skill: kafi-code-review-csharp

## Tooling baseline
- **Static:** Roslyn analyzers (`<Nullable>enable</Nullable>`, `<TreatWarningsAsErrors>`) · StyleCop
- **Security:** `dotnet list package --vulnerable`

## Critical (blocking) checks
- [ ] Nullable reference types enabled + honored — no `!` null-forgiving on truly-nullable; no CS8600-family warnings suppressed
- [ ] Async correctness — `async`/`await` all the way; no `.Result`/`.Wait()` (deadlock); `ConfigureAwait(false)` in libraries; `CancellationToken` threaded
- [ ] `IDisposable` disposed — `using` declarations/statements; async dispose where applicable
- [ ] No swallowed exceptions; no `catch {}`; specific exception types
- [ ] SQL parameterized (no string concat); EF Core no raw interpolation into `FromSqlRaw`
- [ ] Secrets via configuration/secret-store (no literals)

## Advisory (warning) checks
- Records for immutable DTOs; init-only setters
- LINQ readable, not over-nested; avoid multiple enumeration of `IEnumerable`
- Prefer dependency injection over `new` in services
- Pattern matching / switch expressions over if-else chains
- No N+1 in EF Core (use Include/projection); no entity leaking to API (use DTOs)
- Guard clauses for argument validation

## Output
Per finding: `severity · file:line · rule · what · suggested fix`. Critical → Stage 14c sub-check 1 ✗.

## References
- Router: `kafi-code-review` · Stage 14c: `construction/conformance-audit.md`
