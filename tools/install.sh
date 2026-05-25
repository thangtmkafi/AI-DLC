#!/usr/bin/env bash
# KAFI AI-DLC installer · cross-platform bash (macOS, Linux)
#
# Usage:
#   curl -fsSL https://raw.githubusercontent.com/Kafivn/KORA/main/tools/install.sh | bash
#   curl -fsSL https://raw.githubusercontent.com/Kafivn/KORA/main/tools/install.sh | bash -s -- --edition=claude-code
#
# Auto-detects mode (install vs upgrade) based on cwd contents.

set -euo pipefail

# ---- defaults ----
MODE="auto"
EDITION=""
VERSION="latest"
ASSUME_YES=false
DRY_RUN=false
NO_MOVE=false
GH_REPO="Kafivn/KORA"
API_BASE="https://api.github.com/repos/${GH_REPO}/releases"

# ---- color helpers ----
if [[ -t 1 ]]; then
  C_GREEN='\033[0;32m'; C_YELLOW='\033[0;33m'; C_RED='\033[0;31m'
  C_BOLD='\033[1m'; C_DIM='\033[2m'; C_OFF='\033[0m'
else
  C_GREEN=''; C_YELLOW=''; C_RED=''; C_BOLD=''; C_DIM=''; C_OFF=''
fi

say()  { printf "%b\n" "${C_GREEN}✓${C_OFF} $*"; }
warn() { printf "%b\n" "${C_YELLOW}⚠${C_OFF} $*" >&2; }
err()  { printf "%b\n" "${C_RED}✗${C_OFF} $*" >&2; }
step() { printf "%b\n" "${C_BOLD}→${C_OFF} $*"; }

usage() {
  cat <<'EOF'
KAFI AI-DLC installer (Mac/Linux)

USAGE:
  install.sh [--mode=auto|install|upgrade] [--edition=claude-code|kiro]
             [--version=latest|v0.4] [--yes] [--dry-run] [--no-move] [--help]

FLAGS:
  --mode=<m>      Force mode (default: auto-detect from cwd)
  --edition=<e>   Skip edition prompt (claude-code or kiro)
  --version=<v>   Pin version (default: latest from GitHub)
  --yes           Skip confirmation prompt
  --dry-run       Print actions without executing
  --no-move       Install mode: do NOT move existing files to 00-knowledge/references/
  --help          Print this message

EXAMPLES:
  # Auto-detect mode + edition (will prompt)
  bash install.sh

  # Explicit install + edition
  bash install.sh --edition=claude-code --yes

  # Pin to v0.3 instead of latest
  bash install.sh --version=v0.3 --edition=kiro
EOF
}

# ---- argv parsing ----
for arg in "$@"; do
  case "$arg" in
    --mode=*)     MODE="${arg#*=}" ;;
    --edition=*)  EDITION="${arg#*=}" ;;
    --version=*)  VERSION="${arg#*=}" ;;
    --yes|-y)     ASSUME_YES=true ;;
    --dry-run)    DRY_RUN=true ;;
    --no-move)    NO_MOVE=true ;;
    --help|-h)    usage; exit 0 ;;
    *)            err "Unknown flag: $arg"; usage; exit 64 ;;
  esac
done

# ---- safety: refuse on sensitive paths ----
CWD="$(pwd)"
case "$CWD" in
  "$HOME"|"$HOME/Desktop"|"$HOME/Documents"|"/")
    err "Refusing to install into '$CWD' (too sensitive)."
    err "cd into a project directory first, then re-run."
    exit 65
    ;;
esac

# ---- dependency checks ----
for cmd in curl unzip; do
  if ! command -v "$cmd" >/dev/null 2>&1; then
    err "Missing dependency: $cmd"
    err "Install with: brew install $cmd  (macOS)  |  apt install $cmd  (Linux)"
    exit 69
  fi
done

# ---- mode detection ----
detect_existing_edition() {
  local has_claude=false has_kiro=false
  [[ -f CLAUDE.md ]] && has_claude=true
  [[ -f AGENTS.md ]] && has_kiro=true

  if $has_claude && $has_kiro; then
    echo "mixed"
  elif $has_claude; then
    echo "claude-code"
  elif $has_kiro; then
    echo "kiro"
  else
    echo "none"
  fi
}

EXISTING=$(detect_existing_edition)

if [[ "$MODE" == "auto" ]]; then
  if [[ "$EXISTING" == "none" ]]; then
    MODE="install"
  elif [[ "$EXISTING" == "mixed" ]]; then
    err "Both CLAUDE.md AND AGENTS.md present — mixed state."
    err "Decide which edition to keep, remove the other, then re-run with --mode=upgrade."
    exit 70
  else
    MODE="upgrade"
    # Auto-set edition from existing files
    if [[ -z "$EDITION" ]]; then EDITION="$EXISTING"; fi
  fi
fi

step "Mode: ${C_BOLD}${MODE}${C_OFF}"

# ---- edition selection ----
prompt_edition() {
  echo ""
  echo "Choose AI-DLC edition:"
  echo "  [1] Claude Code edition (CLAUDE.md + .claude/)"
  echo "  [2] Kiro IDE edition    (AGENTS.md + .kiro/)"
  local choice
  read -rp "Enter 1 or 2: " choice
  case "$choice" in
    1) EDITION="claude-code" ;;
    2) EDITION="kiro" ;;
    *) err "Invalid choice"; exit 64 ;;
  esac
}

if [[ -z "$EDITION" ]]; then
  if $ASSUME_YES; then
    err "--edition required when --yes is set"
    exit 64
  fi
  prompt_edition
fi

case "$EDITION" in
  claude-code|kiro) ;;
  *) err "Invalid edition: $EDITION (expected claude-code or kiro)"; exit 64 ;;
esac

# ---- version resolution ----
resolve_latest_version() {
  local api_url="${API_BASE}/latest"
  local resp
  resp=$(curl -fsSL "$api_url" 2>/dev/null || true)
  if [[ -z "$resp" ]]; then
    err "Failed to query GitHub Releases. Check network or pass --version=vX.Y explicitly."
    exit 71
  fi
  # Parse "tag_name": "v0.4"
  printf "%s\n" "$resp" | grep -oE '"tag_name":\s*"v[0-9]+\.[0-9]+"' | head -1 | grep -oE 'v[0-9]+\.[0-9]+'
}

if [[ "$VERSION" == "latest" ]]; then
  step "Resolving latest version from GitHub…"
  VERSION=$(resolve_latest_version)
  if [[ -z "$VERSION" ]]; then
    err "Could not parse latest version from GitHub response"
    exit 72
  fi
fi

# Validate version format
if ! [[ "$VERSION" =~ ^v[0-9]+\.[0-9]+$ ]]; then
  err "Invalid version format: $VERSION (expected vX.Y)"
  exit 64
fi

# ---- current version (upgrade mode only) ----
parse_current_version() {
  local file="$1"
  [[ ! -f "$file" ]] && { echo ""; return; }
  # Look at first 5 lines for v0.X pattern
  head -5 "$file" 2>/dev/null | grep -oE 'v[0-9]+\.[0-9]+' | head -1
}

CURRENT_VERSION=""
if [[ "$MODE" == "upgrade" ]]; then
  if [[ "$EDITION" == "claude-code" ]]; then
    CURRENT_VERSION=$(parse_current_version CLAUDE.md)
  else
    CURRENT_VERSION=$(parse_current_version AGENTS.md)
  fi
  step "Detected current version: ${CURRENT_VERSION:-unknown}"
  step "Target version: ${VERSION}"

  if [[ "$CURRENT_VERSION" == "$VERSION" ]]; then
    say "Already on ${VERSION} — nothing to do."
    exit 0
  fi
fi

# ---- asset URL ----
ASSET_NAME="kafi-aidlc-${VERSION}-${EDITION}.zip"
ASSET_URL="https://github.com/${GH_REPO}/releases/download/${VERSION}/${ASSET_NAME}"

# ---- plan summary + confirmation ----
print_plan() {
  echo ""
  echo "${C_BOLD}=== Plan ===${C_OFF}"
  echo "  Mode:     ${MODE}"
  echo "  Edition:  ${EDITION}"
  echo "  Version:  ${VERSION}${CURRENT_VERSION:+ (upgrading from ${CURRENT_VERSION})}"
  echo "  Target:   ${CWD}"
  echo "  Asset:    ${ASSET_NAME}"

  if [[ "$MODE" == "install" ]] && ! $NO_MOVE; then
    local count
    count=$(find . -mindepth 1 -maxdepth 1 \
      ! -name '.git' ! -name '.gitignore' ! -name '.gitattributes' \
      ! -name '.DS_Store' ! -name 'Thumbs.db' ! -name 'desktop.ini' \
      ! -name 'node_modules' ! -name 'dist' ! -name 'build' ! -name 'target' \
      ! -name '.next' ! -name '.cache' \
      ! -name '.vscode' ! -name '.idea' ! -name '.cursor' \
      ! -name '.env' ! -name '.envrc' ! -name '.env.local' \
      ! -name '*.lock' ! -name 'package-lock.json' ! -name 'yarn.lock' ! -name 'Cargo.lock' \
      ! -name '.aidlc-backup-*' \
      2>/dev/null | wc -l | tr -d ' ')
    if [[ "$count" -gt 0 ]]; then
      echo "  Move:     ${count} existing item(s) → 00-knowledge/references/"
    fi
  fi

  if [[ "$MODE" == "upgrade" ]]; then
    local ts; ts=$(date +%Y%m%d-%H%M%S)
    echo "  Backup:   .aidlc-backup-${ts}/"
    echo "  Replace:  $(package_paths | tr '\n' ' ')"
    echo "  Preserve: 00-knowledge/ aidlc-docs/ src/ adrs/ ai-dlc/ .git/"
  fi

  if $DRY_RUN; then
    echo ""; warn "DRY-RUN: no changes will be made."
  fi
  echo ""
}

package_paths() {
  if [[ "$EDITION" == "claude-code" ]]; then
    printf "CLAUDE.md\nREADME.md\naidlc-rule-details/\n.claude/\n"
  else
    printf "AGENTS.md\nREADME.md\n.kiro/\n"
  fi
}

confirm() {
  if $ASSUME_YES || $DRY_RUN; then return 0; fi
  local reply
  read -rp "Proceed? [Y/n] " reply
  case "${reply:-Y}" in
    Y|y|"") return 0 ;;
    *) err "Aborted by user."; exit 1 ;;
  esac
}

# ---- action: move existing files to 00-knowledge/references/ ----
move_to_references() {
  if $NO_MOVE; then return 0; fi

  local items=()
  while IFS= read -r -d '' f; do
    items+=("$f")
  done < <(find . -mindepth 1 -maxdepth 1 \
    ! -name '.git' ! -name '.gitignore' ! -name '.gitattributes' \
    ! -name '.DS_Store' ! -name 'Thumbs.db' ! -name 'desktop.ini' \
    ! -name 'node_modules' ! -name 'dist' ! -name 'build' ! -name 'target' \
    ! -name '.next' ! -name '.cache' \
    ! -name '.vscode' ! -name '.idea' ! -name '.cursor' \
    ! -name '.env' ! -name '.envrc' ! -name '.env.local' \
    ! -name '*.lock' ! -name 'package-lock.json' ! -name 'yarn.lock' ! -name 'Cargo.lock' \
    ! -name '.aidlc-backup-*' \
    -print0 2>/dev/null)

  if [[ ${#items[@]} -eq 0 ]]; then
    step "No existing files to move (workspace was empty)."
    return 0
  fi

  step "Moving ${#items[@]} item(s) → 00-knowledge/references/"
  if $DRY_RUN; then
    for it in "${items[@]}"; do echo "  [dry-run] mv $it 00-knowledge/references/"; done
    return 0
  fi

  mkdir -p 00-knowledge/references
  for it in "${items[@]}"; do
    mv "$it" 00-knowledge/references/
  done
  say "Moved ${#items[@]} item(s)."
}

# ---- action: backup existing package files (upgrade mode) ----
backup_for_upgrade() {
  local ts; ts=$(date +%Y%m%d-%H%M%S)
  local backup_dir=".aidlc-backup-${ts}"
  step "Creating backup at ${backup_dir}/"

  if $DRY_RUN; then
    for p in $(package_paths); do echo "  [dry-run] mv $p $backup_dir/"; done
    return 0
  fi

  mkdir -p "$backup_dir"
  while IFS= read -r p; do
    if [[ -e "$p" ]]; then
      mv "$p" "$backup_dir/" 2>/dev/null || true
    fi
  done < <(package_paths)
  say "Backup created at ${backup_dir}/"
}

# ---- action: download + extract zip ----
download_and_extract() {
  local tmp_zip; tmp_zip=$(mktemp -t kafi-aidlc-XXXXXX.zip)
  step "Downloading ${ASSET_URL}"

  if $DRY_RUN; then
    echo "  [dry-run] curl -fsSL ${ASSET_URL} → ${tmp_zip}"
    echo "  [dry-run] unzip ${tmp_zip} into ${CWD}"
    return 0
  fi

  if ! curl -fsSL -o "$tmp_zip" "$ASSET_URL"; then
    err "Download failed: ${ASSET_URL}"
    err "Check that the release exists at https://github.com/${GH_REPO}/releases"
    exit 73
  fi

  # Sanity check zip
  local zsize; zsize=$(wc -c <"$tmp_zip" | tr -d ' ')
  if [[ "$zsize" -lt 50000 ]]; then
    err "Downloaded file is suspiciously small (${zsize} bytes). Aborting."
    rm -f "$tmp_zip"
    exit 74
  fi

  step "Extracting into ${CWD}…"
  if ! unzip -q -o "$tmp_zip" -d "$CWD"; then
    err "Unzip failed."
    rm -f "$tmp_zip"
    exit 75
  fi

  rm -f "$tmp_zip"
  say "Extracted AI-DLC ${VERSION} (${EDITION})."
}

# ---- action: print next steps ----
print_next_steps_install() {
  cat <<EOF

${C_BOLD}=== Next steps ===${C_OFF}

1. ${C_BOLD}Create ai-dlc/project.md${C_OFF} — project metadata.

   See template in README.md §"How to use" step 4.

2. ${C_BOLD}Start your first AI session${C_OFF}.

   Open this folder in $( [[ "$EDITION" == "claude-code" ]] && echo "Claude Code" || echo "Kiro IDE" ).
   In chat:
     ${C_DIM}Run #kafi-aidlc-onboarding${C_OFF}

   The onboarding skill will scan ${CWD}/00-knowledge/, detect your current
   AI-DLC stage, and start a session with the right role + prompt.

3. ${C_DIM}/init is not needed.${C_OFF} The workflow spec is already in CLAUDE.md/AGENTS.md
   and auto-loaded on every session.

EOF
}

print_next_steps_upgrade() {
  cat <<EOF

${C_BOLD}=== Upgrade complete ===${C_OFF}

Old files backed up to: .aidlc-backup-* (in this folder)

${C_BOLD}=== Next steps ===${C_OFF}

1. Review changes:   git diff
2. Read changelog:   https://github.com/${GH_REPO}/blob/main/CHANGELOG.md
3. Stage + commit:   git add . && git commit -m "Upgrade AI-DLC to ${VERSION}"

If anything breaks, restore from the backup directory.

EOF
}

# ============================================================
# MAIN EXECUTION
# ============================================================

print_plan
confirm

if [[ "$MODE" == "install" ]]; then
  move_to_references
  download_and_extract
  print_next_steps_install

elif [[ "$MODE" == "upgrade" ]]; then
  backup_for_upgrade
  download_and_extract
  print_next_steps_upgrade

else
  err "Unsupported mode: $MODE"
  exit 64
fi

say "Done."
