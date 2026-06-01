---
name: kafi-code-review-rust
description: Rust code reviewer. Invoked by the kafi-code-review router (or directly) to review .rs files for borrow correctness, unsafe blocks, panics, and idiomatic pitfalls at Stage 14c. Checks clippy, rustfmt, cargo audit.
inclusion: manual
---

# Skill: kafi-code-review-rust

## Tooling baseline
- **Lint:** `clippy` (`-D warnings`) · **Format:** `rustfmt`
- **Security:** `cargo audit` · `cargo deny`

## Critical (blocking) checks
- [ ] No `unwrap()`/`expect()` on fallible paths reachable from input — propagate with `?`/`Result`; reserve unwrap for proven-infallible + comment
- [ ] No `panic!`/`unreachable!` on user-reachable input
- [ ] `unsafe` blocks justified with a `// SAFETY:` comment proving the invariant; minimized scope
- [ ] Error handling — `Result<T, E>` with meaningful error types (thiserror/anyhow); no swallowed errors
- [ ] No blocking calls inside async (`.await`) contexts; correct runtime usage
- [ ] No data races — `Send`/`Sync` honored; shared state via `Arc<Mutex>`/channels
- [ ] SQL parameterized (sqlx/diesel); secrets via env/secret-store

## Advisory (warning) checks
- Prefer borrowing over cloning; avoid needless `.clone()`
- Iterators over index loops
- `match` exhaustive; avoid catch-all `_` that hides new variants
- Newtype pattern for domain types
- `impl Trait` / generics over `Box<dyn>` where perf matters
- Clippy pedantic suggestions addressed or `#[allow]`-with-reason

## Output
Per finding: `severity · file:line · rule · what · suggested fix`. Critical → Stage 14c sub-check 1 ✗.

## References
- Router: `kafi-code-review` · Stage 14c: `construction/conformance-audit.md`
