---
name: kafi-code-review
description: Router for language-specific code review. Detects the language of changed files and dispatches to the matching kafi-code-review-<lang> sub-skill. Loads at Stage 14c sub-check 1 (Code audit) or when the user asks to "review this code", "code review", "check code quality". Delegates; does not review directly.
inclusion: manual
---

# Skill: kafi-code-review (router)

## Why this skill exists

Code review quality depends on language-specific tooling + idioms. One generic reviewer misses Go's error-wrapping conventions, Rust's borrow nuances, Python's type-hint gaps. This router detects language per file and dispatches to the matching `kafi-code-review-<lang>` sub-skill so each file gets reviewed with its language's tools + hot-spots.

Used at **Stage 14c sub-check 1 (Code audit)** — the conformance audit delegates per-file code-quality review to the language reviewers, then folds findings into the audit report.

## Language detection → sub-skill

| Extensions | Sub-skill |
|---|---|
| `.ts` `.tsx` `.mts` `.cts` | `kafi-code-review-typescript` |
| `.py` `.pyi` | `kafi-code-review-python` |
| `.go` | `kafi-code-review-go` |
| `.java` | `kafi-code-review-java` |
| `.kt` `.kts` | `kafi-code-review-kotlin` |
| `.cpp` `.cc` `.cxx` `.hpp` `.h` | `kafi-code-review-cpp` |
| `.rs` | `kafi-code-review-rust` |
| `.cs` | `kafi-code-review-csharp` |
| `.sql` · migrations · schema files | `kafi-code-review-database` |
| `.sh` `.bash` `.ps1` | `kafi-code-review-shell` |

JS (`.js`/`.jsx`) → use the typescript reviewer (subset). For a language with no dedicated reviewer yet, fall back to generic review + note the gap (candidate for `kafi-memory` to flag as a needed new reviewer).

## Steps

1. Enumerate changed/target files (the unit's `src/`).
2. Group by language via the table above.
3. For each group, invoke the matching sub-skill; collect findings (severity · file:line · rule · fix).
4. Aggregate into one report; classify Critical (blocking) vs Advisory.
5. Feed Critical findings into Stage 14c sub-check 1 (Code audit) as ✗ candidates.

## Do

- Dispatch per file group — never review TypeScript with Python rules
- Aggregate findings with consistent severity labels across languages
- Note any language with no reviewer (gap → kafi-memory)

## Don't

- Don't review directly here — this is a router
- Don't downgrade a language reviewer's Critical to Advisory at the router level

## References

- Stage 14c sub-check 1 (Code audit): `aidlc-rule-details/construction/conformance-audit.md`
- Sub-skills: `kafi-code-review-{typescript,python,go,java,kotlin,cpp,rust,csharp,database,shell}`
- Inspired by ECC per-language `*-reviewer` agents
