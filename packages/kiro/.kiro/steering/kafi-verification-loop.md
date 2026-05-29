---
inclusion: manual
description: "Run the full local verification chain (build, typecheck, lint, tests, security scan) in one pass and report a single PASS/FAIL summary. Loads when the user wants to verify a unit before handing off to Stage 14c conformance audit, or asks to "run checks", "verify build", "run the loop"."
---

# Skill: kafi-verification-loop

## Why this skill exists

Stage 14c (Conformance Audit) is a blocking gate. Sending it code that doesn't even build wastes an audit cycle. This skill runs the full local verification chain first so Dev hands Stage 14c something that already compiles, typechecks, lints, and passes its own generated tests.

**This is local pre-flight, not the audit.** It does not replace Stage 14c (which checks spec conformance) — it ensures the mechanical basics pass before the conformance review.

## The chain (in order — stop on first hard failure, or run-all + collect)

1. **Build** — compile / bundle. Command from `technical-environment.md` (e.g. `npm run build`, `cargo build`, `go build ./...`, `mvn package`).
2. **Typecheck** — `tsc --noEmit` · `mypy` · `go vet` · etc. (skip for dynamically-typed without type hints).
3. **Lint** — `eslint` · `ruff` · `golangci-lint` · `clippy` · `detekt` · etc.
4. **Tests** — run the unit test code generated at Stage 14b, in the framework declared in `test-plan.md`.
5. **Security scan** — basic: `npm audit` · `bandit` · `cargo audit` · `gosec` · dependency CVE check.

## Steps

1. Detect stack + commands from `technical-environment.md` + project manifests (package.json, Cargo.toml, go.mod, pom.xml, pyproject.toml).
2. Run each step. Capture output.
3. Produce a single summary:
   ```
   kafi-verification-loop · UNIT-NN
     Build       ✓ / ✗
     Typecheck   ✓ / ✗  (N errors)
     Lint        ✓ / ⚠  (N warnings)
     Tests       ✓ / ✗  (P passed / F failed)  [framework: X]
     Security    ✓ / ⚠  (N advisories)
   Overall: PASS / FAIL
   ```
4. On FAIL, list the specific failures (file:line) so Dev fixes before Stage 14c.

## Do

- Use the project's actual commands (from technical-environment.md / manifests) — don't assume
- Run tests in the framework `test-plan.md` declared
- Report warnings separately from hard failures

## Don't

- Don't treat this as the conformance audit (Stage 14c still required — it checks spec conformance, this checks mechanics)
- Don't auto-fix lint by rewriting logic — report and let Dev decide
- Don't skip security scan even on "small" changes

## References

- Stage: `.kiro/steering/construction/code-generation.md` (14a) · `unit-test-generation.md` (14b) · `conformance-audit.md` (14c)
- Input: `technical-environment.md` (commands) · `test-plan.md` (framework)
