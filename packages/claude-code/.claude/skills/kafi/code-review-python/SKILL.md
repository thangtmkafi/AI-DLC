---
name: kafi-code-review-python
description: Python code reviewer. Invoked by the kafi-code-review router (or directly) to review .py files for type hints, lint, security, and idiomatic pitfalls at Stage 14c. Checks ruff, mypy strict, bandit, async correctness, dependency hygiene.
inclusion: manual
---

# Skill: kafi-code-review-python

## Tooling baseline
- **Lint+format:** `ruff` (lint + format) · **Types:** `mypy --strict` (or pyright)
- **Security:** `bandit` · **Deps:** `pip-audit`

## Critical (blocking) checks
- [ ] Type hints on all public functions/methods; `mypy --strict` clean
- [ ] No bare `except:` — catch specific exceptions; no swallowed errors
- [ ] No mutable default args (`def f(x=[])`)
- [ ] `async def` functions actually awaited; no blocking I/O in async path
- [ ] No SQL string interpolation (use params) — injection
- [ ] No `eval`/`exec`/`pickle` on untrusted input (bandit)
- [ ] Secrets: env/secret-store only, never literals
- [ ] Resource cleanup: `with` for files/connections

## Advisory (warning) checks
- Prefer dataclasses / pydantic over dict-passing
- Prefer comprehensions over map/filter where readable
- f-strings over `%`/`.format`
- Pathlib over `os.path` string juggling
- Pin/most-constrain deps; no unused imports (ruff)
- Docstrings on public API

## Framework hot-spots
- **Django:** no N+1 (use select_related/prefetch) · QuerySets not evaluated in templates · migrations reversible
- **FastAPI:** pydantic models for request/response · dependency-injection for DB sessions · no sync DB in async route

## Output
Per finding: `severity · file:line · rule · what · suggested fix`. Critical → Stage 14c sub-check 1 ✗.

## References
- Router: `kafi-code-review` · Stage 14c: `construction/conformance-audit.md`
