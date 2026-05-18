#!/usr/bin/env bash
# build-releases.sh — zip packages/<platform>/ into releases/v<X.Y>/<name>.zip
# Run from repo root: ./tools/build-releases.sh v0.3

set -euo pipefail

VERSION="${1:-}"
if [[ -z "$VERSION" ]]; then
  echo "Usage: $0 <version>  (e.g. v0.3)"
  exit 1
fi

REPO_ROOT="$(cd "$(dirname "$0")/.." && pwd)"
cd "$REPO_ROOT"

if [[ ! -d "packages/claude-code" || ! -d "packages/kiro" ]]; then
  echo "Error: packages/claude-code/ and packages/kiro/ must exist" >&2
  exit 2
fi

OUT_DIR="releases/${VERSION}"
mkdir -p "$OUT_DIR"

echo "=== Building Claude Code edition ==="
CLAUDE_ZIP="$OUT_DIR/kafi-aidlc-${VERSION}-claude-code.zip"
rm -f "$CLAUDE_ZIP"
(cd packages/claude-code && zip -r "../../$CLAUDE_ZIP" . \
  -x "*.DS_Store" "*/.git/*" "*/node_modules/*" 2>&1 | tail -3)
echo "  → $CLAUDE_ZIP ($(du -h "$CLAUDE_ZIP" | cut -f1))"
echo ""

echo "=== Building Kiro edition ==="
KIRO_ZIP="$OUT_DIR/kafi-aidlc-${VERSION}-kiro.zip"
rm -f "$KIRO_ZIP"
(cd packages/kiro && zip -r "../../$KIRO_ZIP" . \
  -x "*.DS_Store" "*/.git/*" "*/node_modules/*" 2>&1 | tail -3)
echo "  → $KIRO_ZIP ($(du -h "$KIRO_ZIP" | cut -f1))"
echo ""

echo "=== Parity check ==="
CLAUDE_FILES=$(find packages/claude-code -type f \( -name '*.md' -o -name '*.json' \) | wc -l)
KIRO_FILES=$(find packages/kiro -type f \( -name '*.md' -o -name '*.json' \) | wc -l)
echo "  Claude Code: $CLAUDE_FILES md/json files"
echo "  Kiro:        $KIRO_FILES md/json files"
DIFF=$((KIRO_FILES - CLAUDE_FILES))
if (( DIFF < -3 || DIFF > 8 )); then
  echo "  ⚠ Drift detected: $DIFF files (expected ~+4 for Kiro spec template)"
else
  echo "  ✓ Parity within expected drift range"
fi
echo ""

echo "Done. Upload these to GitHub Release ${VERSION}:"
ls -la "$OUT_DIR"
