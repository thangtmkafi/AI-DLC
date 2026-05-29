---
inclusion: manual
description: "Shell script reviewer (Bash + PowerShell). Invoked by the kafi-code-review router (or directly) to review .sh/.bash/.ps1 files for quoting, error handling, and subprocess hygiene at Stage 14c. Checks shellcheck, PSScriptAnalyzer."
---

# Skill: kafi-code-review-shell

## Tooling baseline
- **Bash:** `shellcheck` · `shfmt`
- **PowerShell:** `PSScriptAnalyzer`

## Critical (blocking) checks · Bash
- [ ] `set -euo pipefail` at top (errexit, nounset, pipefail) — fail fast
- [ ] All variable expansions quoted (`"$var"`, `"${arr[@]}"`) — word-splitting/glob bugs
- [ ] No unquoted command substitution in word context
- [ ] `[[ ]]` over `[ ]`; arithmetic in `(( ))`
- [ ] No parsing `ls`; use globs/`find -print0` + `read -d ''`
- [ ] External input validated; no `eval` on untrusted data
- [ ] Secrets not echoed/logged; not passed as argv (visible in ps); use env/stdin
- [ ] `trap` cleanup for temp files

## Critical (blocking) checks · PowerShell
- [ ] `$ErrorActionPreference = 'Stop'` (or `-ErrorAction Stop`) for fail-fast
- [ ] `[CmdletBinding()]` + typed params + validation attributes
- [ ] No plaintext secrets; use `SecureString`/secret store
- [ ] Proper `try/catch` around external calls; no swallowed errors
- [ ] Avoid `Invoke-Expression` on untrusted input

## Advisory (warning) checks
- Functions for repeated blocks; small + single-purpose
- Meaningful exit codes
- Idempotent where it's a setup/install script
- Comments for non-obvious flags
- Cross-platform caution (GNU vs BSD utils) noted

## Output
Per finding: `severity · file:line · rule · what · suggested fix`. Critical → Stage 14c sub-check 1 ✗.

## References
- Router: `kafi-code-review` · Stage 14c: `construction/conformance-audit.md`
- Relevant for `tools/install.sh` + `install.ps1` style scripts too.
