# Stage 15: Build

**Owner:** Developer · **Always runs** · **Approval required**

(Renamed from "Build and Test" — test artifacts deferred to v0.4+.)

## Purpose

Document how to build the project end-to-end. Single stage after all units complete.

## Steps

1. List all units built.
2. For each unit, document:
   - Build prerequisites (runtime, deps, env vars)
   - Build commands
   - Output artifacts (binaries, packages, containers)
3. Document inter-unit build order (from `unit-of-work-dependency.md`).
4. Common build failures + fixes.

## Outputs

To `aidlc-docs/construction/build/`:

| File | Content |
|---|---|
| `build-instructions.md` | How to build, prerequisites, commands |
| `build-summary.md` | What was built, where artifacts live, versions |

## Build instructions format

```markdown
# Build Instructions

## Prerequisites
- Node 20.x (or specify Python, Java, Go)
- pnpm 9.x
- Docker (optional, for containerized builds)

## Build all units (in dependency order)

### UNIT-01-name
```bash
cd src/unit-01-name
pnpm install
pnpm build
```
Output: `dist/unit-01.tar.gz`

### UNIT-02-name
```bash
cd src/unit-02-name
pnpm install
pnpm build
```
Output: `dist/unit-02.tar.gz`

## Build all at once
```bash
pnpm install
pnpm -r build  # builds all packages
```

## Troubleshooting
| Error | Fix |
|---|---|
| `Cannot find module 'X'` | Run `pnpm install` |
| `EACCES` | Check write permission on `dist/` |
| ... | ... |
```

## Approval gate

```
Build complete.
- Units built: [N]
- Artifacts produced: [list]
- Build time: [duration]

→ Request Changes (build instructions)
→ Continue to Operations
```
