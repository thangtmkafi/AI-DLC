---
inclusion: manual
description: "Go code reviewer. Invoked by the kafi-code-review router (or directly) to review .go files for error handling, concurrency, and idiomatic pitfalls at Stage 14c. Checks go vet, staticcheck, gofmt, error wrapping, context propagation, goroutine leaks."
---

# Skill: kafi-code-review-go

## Tooling baseline
- **Vet:** `go vet ./...` · **Static:** `staticcheck` / `golangci-lint`
- **Format:** `gofmt` / `goimports` · **Security:** `govulncheck` / `gosec`

## Critical (blocking) checks
- [ ] Every error checked — no ignored `err` (errcheck); no `_ = err` without reason
- [ ] Errors wrapped with context (`fmt.Errorf("...: %w", err)`) not swallowed/re-formatted-lossy
- [ ] `context.Context` threaded through call chain; honored for cancellation/timeout
- [ ] No goroutine leaks — every goroutine has a clear exit; channels closed by sender
- [ ] No data races — shared state guarded (mutex/channel); run `-race` in tests
- [ ] Deferred Close()/Unlock() on resources; defer in loops avoided (or scoped)
- [ ] No SQL string concat — use parameterized queries
- [ ] Secrets via env/secret-store

## Advisory (warning) checks
- Accept interfaces, return structs
- Small interfaces (1-3 methods) at the consumer
- No naked returns in long functions
- Sentinel errors / typed errors over string matching
- `slog` (or project logger) not `fmt.Println`
- Table-driven tests

## Output
Per finding: `severity · file:line · rule · what · suggested fix`. Critical → Stage 14c sub-check 1 ✗.

## References
- Router: `kafi-code-review` · Stage 14c: `construction/conformance-audit.md`
