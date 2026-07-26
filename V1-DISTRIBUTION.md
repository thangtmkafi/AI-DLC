# AI-DLC v1 Distribution

## What this repository publishes

AI-DLC v1 is published here as one universal Release for Codex, Claude Code, and Kiro. There is no
edition to choose and no per-host download. Alongside it are the stable bootstrap locator, the
public documentation, the release notes and evidence, licence notices, and the announcement source.

## Release trust model

A Release becomes a recommendation only when every one of these holds:

1. the exact candidate bytes reproduce and validate;
2. the GitHub Release API reports `immutable: true`;
3. every asset digest matches the downloaded bytes and the locator metadata; and
4. locator promotion is approved and applied as a separate transaction after publication.

If any step fails before locator promotion, the previously recommended release stays active. A
Release is immutable, so an approved digest keeps meaning the same bytes for as long as it exists.

## Agent-native installation and upgrade

AI-DLC v1 publishes no mutating `install.sh` or `install.ps1`. A supported AI coding agent reads the
stable locator, verifies the immutable Release, inspects the project **without modifying it**, and
produces a canonical operation plan. The agent may write project files only after an authorised
person approves the exact plan digest.

Move, delete, migration, repair, upgrade, and adapter changes are explicit rows in that plan. None
is inferred, and none is hidden inside an installer. Your project's root `README.md` is never an
install target.

No administrator privilege and no new runtime are required when a supported agent host is already
available and you can write to the project folder.

## Legacy boundary

The existing v0.x source, tools, installers, and edition ZIPs remain here as historical content.
They are **not** v1 authority and do not gain v1 semantics by staying in this repository. The legacy
tag workflow accepts only `v0.*`.
