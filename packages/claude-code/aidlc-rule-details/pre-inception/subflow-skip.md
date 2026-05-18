# Sub-flow A: skip

**Activates when** both `vision.md` and `technical-environment.md` exist at `aidlc-docs/inception/discovery/` and are non-empty.

## Execution

1. Verify both files exist:
   - `aidlc-docs/inception/discovery/vision.md`
   - `aidlc-docs/inception/discovery/technical-environment.md`
2. Verify each file is non-empty and matches its template structure (basic sanity check).
3. Log decision in `audit.md`:
   ```
   ## Pre-Inception: Sub-flow A (skip)
   Vision Document: ✓ verified at aidlc-docs/inception/discovery/vision.md
   Tech Env Document: ✓ verified at aidlc-docs/inception/discovery/technical-environment.md
   Proceeding to Inception.
   ```
4. Proceed to Inception (Stage 1: Workspace Detection runs next).

## No outputs

This sub-flow produces no artifacts. It's a no-op routing decision.

## Failure mode

If either file is missing or empty → reroute to Sub-flow B (fill-gaps) automatically and inform user.
