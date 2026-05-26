# Contributing to KAFI AI-DLC

Thank you for considering a contribution. This is the methodology layer for KAFI engineering — changes here propagate to every project that uses AI-DLC, so we move thoughtfully.

## Who can contribute

- **KAFI engineers and Transformation Office members** — open PRs directly
- **External contributors** — open an issue first to discuss scope before sending a PR
- **Partner organizations** — fork, adapt, send pull requests upstream if changes are generally useful

## What counts as a contribution

Welcome:

- Rule clarifications and corrections in `packages/*/aidlc-rule-details/` or `packages/*/.kiro/steering/`
- New role guides or stage rules with a clear use case
- Template improvements (templates apply to both editions)
- Documentation fixes in `docs/*.html`
- Translations of `docs/`
- Bug fixes in `tools/build-releases.sh` or workflow files

Out of scope:

- Project-specific rules (those belong in your project's `00-knowledge/`, not here)
- Product code or KOS-MO architecture (separate KAFI repos)
- AI model configurations (bring your own models)

## The parity rule

**Every change touches both editions in the same PR.** If you update a rule for Claude Code, you update the equivalent file in Kiro (and vice versa). If a change applies to only one platform, that's a parity bug — open an issue describing why before submitting code.

Concretely, a typical PR touches both:

```
packages/claude-code/aidlc-rule-details/<folder>/<file>.md
packages/kiro/.kiro/steering/<folder>/<file>.md
```

The Kiro version needs YAML front-matter declaring `inclusion: always|manual`. The Claude Code version has no front-matter.

## How to propose a change

1. **Open an issue first** for non-trivial changes (new rules, new roles, structural changes). Tag it `proposal:` and describe the use case in 3-5 sentences.
2. **Fork or branch from `develop`** — never from `main`.
3. **Make changes in both editions** — see parity rule above.
4. **Update docs** — if the change affects the workflow, update `docs/KAFI-AIDLC-Handbook.html` AND `docs/KAFI-AIDLC-Handbook.html`.
5. **Add a CHANGELOG entry** under `## [Unreleased]` describing what changed.
6. **Open a pull request** targeting `develop`. Use the PR template; fill out every section.
7. **Wait for review** — CODEOWNERS approval is required for changes in `packages/` or `docs/`. Reviewers check parity, soundness, and KAFI design system compliance.
8. **Iterate** based on feedback. Squash commits before merging.

## Local testing

Before opening a PR:

```bash
# Build both release zips locally to verify packaging
./tools/build-releases.sh v0.3-dev

# Manually verify packages/claude-code/ structure
find packages/claude-code -type f | wc -l    # ~53 files expected
find packages/kiro -type f | wc -l           # ~57 files expected

# Open the rebuilt docs in a browser to verify rendering
open docs/KAFI-AIDLC-Handbook.html
```

## Style conventions

- **Markdown:** standard syntax, no extensions. Headings, lists, code blocks, tables.
- **Front-matter (Kiro only):** YAML with `inclusion: always|manual` and `description: "..."`. No other keys.
- **File naming:** lowercase-with-hyphens for rule files; PascalCase for HTML doc filenames.
- **Voice:** declarative, present tense. "The agent loads X" not "X will be loaded".
- **No fabricated authority:** rules reference KAFI's own KB sections, not external "best practices" unless cited.

## Versioning

This project follows [Semantic Versioning](https://semver.org). Roughly:

- **MAJOR** — breaking change to workflow structure (e.g., removing a stage, renaming a role)
- **MINOR** — new rules, new roles, new templates, additive changes
- **PATCH** — typo fixes, doc clarifications, small bug fixes in tools

One version covers both editions (no `v0.3-claude` vs `v0.3-kiro` split).

## Release process (for maintainers)

1. Merge approved PRs into `develop`
2. When ready to release, open PR from `develop` to `main` with title `Release vX.Y`
3. After merge, tag from main: `git tag vX.Y && git push --tags`
4. GitHub Actions builds zips and creates the Release automatically
5. Announce in #engineering channel

## Code of conduct

Be specific. Be brief. Disagree with arguments, not people. The point of the workflow is to make discipline easy, not to add friction — if a rule is creating more cognitive load than it's removing, that's a signal to revisit, not to push through.

## Questions

- Workflow questions: ping #ai-dlc in Slack or open a discussion
- Bug reports: open an issue with the `bug` label
- Feature proposals: open an issue with the `proposal` label

Kafi Securities Transformation Office
