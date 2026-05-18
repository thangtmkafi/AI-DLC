## Summary

<!-- 2-3 sentences. What does this PR do and why? -->

## Type of change

- [ ] Bug fix (no behavior change for users)
- [ ] Rule clarification (sharpens existing rule)
- [ ] New rule / new role / new template (additive)
- [ ] Structural change (touches workflow shape)
- [ ] Documentation only
- [ ] Tooling / CI

## Parity check

- [ ] Changes are mirrored in `packages/claude-code/`
- [ ] Changes are mirrored in `packages/kiro/` (with correct YAML front-matter)
- [ ] If templates changed, both editions' `templates/` updated
- [ ] If docs changed, both `docs/KAFI-AIDLC-*-Claude.html` and `docs/KAFI-AIDLC-*-Kiro.html` updated

## Local testing

- [ ] `./tools/build-releases.sh v0.X-dev` runs cleanly
- [ ] Manually opened changed docs in browser — no broken layout
- [ ] If new rule added: tested by running through workflow in a dummy project

## CHANGELOG

- [ ] Entry added under `## [Unreleased]` in `CHANGELOG.md`

## Reviewer notes

<!-- Optional — anything specific the reviewer should look at? -->
