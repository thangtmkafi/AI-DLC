---
inclusion: manual
description: "Java code reviewer. Invoked by the kafi-code-review router (or directly) to review .java files for null safety, resource leaks, concurrency, and idiomatic pitfalls at Stage 14c. Checks SpotBugs, Checkstyle, ErrorProne."
---

# Skill: kafi-code-review-java

## Tooling baseline
- **Static:** SpotBugs (+ FindSecBugs) · ErrorProne · **Style:** Checkstyle
- **Deps:** OWASP dependency-check

## Critical (blocking) checks
- [ ] Null safety — no unchecked deref; `Optional` for absent, not null returns; `@Nullable`/`@NonNull` honored
- [ ] Resource management — try-with-resources for Closeable (streams, connections, statements)
- [ ] No swallowed exceptions (`catch (Exception e) {}`); no catching `Throwable`/`Error`
- [ ] Concurrency — shared mutable state guarded; prefer `java.util.concurrent` over raw synchronized; no double-checked-locking bugs
- [ ] SQL via PreparedStatement (no concatenation) — injection
- [ ] `equals`/`hashCode` overridden together; immutable value objects where possible
- [ ] Secrets via config/secret-store, never literals

## Advisory (warning) checks
- Prefer immutability (`final`, records for DTOs)
- Streams over manual loops where readable; avoid side effects in streams
- Dependency injection over `new` in business logic
- Specific exceptions over generic
- No raw types (use generics)
- Logging via SLF4J, parameterized (no string concat in log calls)

## Framework hot-spots
- **Spring Boot:** constructor injection · `@Transactional` scope correct · no entity leaking to API layer (use DTOs) · no N+1 (fetch joins / entity graphs)

## Output
Per finding: `severity · file:line · rule · what · suggested fix`. Critical → Stage 14c sub-check 1 ✗.

## References
- Router: `kafi-code-review` · Stage 14c: `construction/conformance-audit.md`
