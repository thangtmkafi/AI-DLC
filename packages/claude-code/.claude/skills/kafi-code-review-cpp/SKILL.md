---
name: kafi-code-review-cpp
description: C++ code reviewer. Invoked by the kafi-code-review router (or directly) to review .cpp/.cc/.hpp/.h files for memory safety, RAII, and undefined behavior at Stage 14c. Checks clang-tidy, cppcheck, sanitizers.
inclusion: manual
---

# Skill: kafi-code-review-cpp

## Tooling baseline
- **Static:** clang-tidy · cppcheck · **Format:** clang-format
- **Runtime:** ASan / UBSan / TSan in test builds · **Compile:** `-Wall -Wextra -Werror`

## Critical (blocking) checks
- [ ] Memory: no leaks, no double-free, no use-after-free — prefer RAII + smart pointers (`unique_ptr`/`shared_ptr`), no raw `new`/`delete` in business logic
- [ ] Ownership clear — no ambiguous raw-pointer ownership; `unique_ptr` for sole, `shared_ptr` only when shared
- [ ] No undefined behavior — uninitialized reads, signed overflow, OOB index, invalid downcasts
- [ ] Rule of 0/3/5 honored — if one of dtor/copy/move defined, all needed ones defined (or `= default`/`= delete`)
- [ ] No dangling references/iterators (esp. returning refs to locals, invalidation after container mutation)
- [ ] Bounds-checked access on external input; no `strcpy`/`sprintf` (use safe variants)
- [ ] Thread safety — shared state guarded; no data races (TSan clean)

## Advisory (warning) checks
- `const`-correctness throughout
- Pass by `const&` for non-trivial types; move semantics where it helps
- `enum class` over plain enum
- `std::` algorithms over hand loops
- `nullptr` not `NULL`/`0`
- Prefer `std::span`/`string_view` for non-owning views

## Output
Per finding: `severity · file:line · rule · what · suggested fix`. Critical → Stage 14c sub-check 1 ✗.

## References
- Router: `kafi-code-review` · Stage 14c: `construction/conformance-audit.md`
