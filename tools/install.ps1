<#
.SYNOPSIS
  KAFI AI-DLC installer for Windows (PowerShell).

.DESCRIPTION
  Auto-detects install vs upgrade mode from current folder contents.
  - Install: workspace has no AI-DLC. Moves existing files to 00-knowledge/references/ then extracts AI-DLC.
  - Upgrade: detects current version from CLAUDE.md/AGENTS.md, fetches latest, replaces package files, preserves user content.

.PARAMETER Mode
  Force mode: install | upgrade | auto. Default: auto-detect.

.PARAMETER Edition
  Edition to install: claude-code | kiro. Default: prompts the user.

.PARAMETER Version
  Pinned version (e.g., v0.4) or "latest". Default: latest.

.PARAMETER Yes
  Skip the confirmation prompt.

.PARAMETER DryRun
  Print actions without executing.

.PARAMETER NoMove
  Install mode: do NOT move existing files to 00-knowledge/references/.

.PARAMETER ConvertTo
  Convert current edition -> target edition (always latest).
  Backs up current edition files to .aidlc-backup-<ts>-from-<edition>/,
  installs target edition, preserves 00-knowledge/, aidlc-docs/, src/, adrs/, ai-dlc/.
  Valid values: claude-code, kiro.

.EXAMPLE
  .\install.ps1
  Auto-detect mode + prompt for edition.

.EXAMPLE
  .\install.ps1 -Edition claude-code -Yes
  Non-interactive install of Claude Code edition.

.EXAMPLE
  .\install.ps1 -Mode upgrade -Version v0.4
  Force upgrade to v0.4.

.EXAMPLE
  .\install.ps1 -ConvertTo kiro -Yes
  Convert Claude Code edition -> Kiro edition (latest).

.EXAMPLE
  .\install.ps1 -ConvertTo claude-code -Yes
  Convert Kiro edition -> Claude Code edition (latest).
#>

[CmdletBinding()]
param(
  [ValidateSet('auto','install','upgrade','convert')]
  [string]$Mode = 'auto',

  [ValidateSet('','claude-code','kiro')]
  [string]$Edition = '',

  [string]$Version = 'latest',

  [ValidateSet('','claude-code','kiro')]
  [string]$ConvertTo = '',

  [switch]$Yes,
  [switch]$DryRun,
  [switch]$NoMove,
  [switch]$Help
)

$ErrorActionPreference = 'Stop'
$GhRepo = 'thangtmkafi/AI-DLC'
$ApiBase = "https://api.github.com/repos/$GhRepo/releases"

# ---- helpers ----
function Say  { param($Msg) Write-Host "[+] $Msg" -ForegroundColor Green }
function Warn { param($Msg) Write-Host "[!] $Msg" -ForegroundColor Yellow }
function Err  { param($Msg) Write-Host "[X] $Msg" -ForegroundColor Red }
function Step { param($Msg) Write-Host "==> $Msg" -ForegroundColor Cyan }

function Show-Usage {
  Get-Help $PSCommandPath -Full
}

if ($Help) { Show-Usage; exit 0 }

# ---- safety: refuse on sensitive paths ----
$Cwd = (Get-Location).Path
$Sensitive = @(
  $HOME,
  (Join-Path $HOME 'Desktop'),
  (Join-Path $HOME 'Documents'),
  'C:\',
  'C:\Users'
)
if ($Sensitive -contains $Cwd) {
  Err "Refusing to install into '$Cwd' (too sensitive)."
  Err "cd into a project directory first, then re-run."
  exit 65
}

# ---- dependency checks (PowerShell 5+ has all needed built-ins) ----
if ($PSVersionTable.PSVersion.Major -lt 5) {
  Err "PowerShell 5.0 or higher required (you have $($PSVersionTable.PSVersion))"
  exit 69
}

# ---- mode detection ----
function Get-ExistingEdition {
  $hasClaude = Test-Path -LiteralPath (Join-Path $Cwd 'CLAUDE.md')
  $hasKiro   = Test-Path -LiteralPath (Join-Path $Cwd 'AGENTS.md')
  if ($hasClaude -and $hasKiro) { return 'mixed' }
  if ($hasClaude)               { return 'claude-code' }
  if ($hasKiro)                 { return 'kiro' }
  return 'none'
}

$Existing = Get-ExistingEdition

# -ConvertTo overrides mode detection
if (-not [string]::IsNullOrEmpty($ConvertTo)) {
  if ($Existing -eq 'none') {
    Err '-ConvertTo requires an existing AI-DLC installation.'
    Err 'Found no CLAUDE.md or AGENTS.md in cwd. Run a fresh install instead.'
    exit 70
  }
  if ($Existing -eq 'mixed') {
    Err 'Both CLAUDE.md AND AGENTS.md present - mixed state.'
    Err 'Decide which edition to keep, remove the other, then re-run -ConvertTo.'
    exit 70
  }
  if ($Existing -eq $ConvertTo) {
    Say "Already on $ConvertTo edition - nothing to convert."
    exit 0
  }
  $Mode = 'convert'
  $Edition = $ConvertTo
  # Convert defaults to latest; respect -Version override if user passed one
  # (useful when GitHub API is unreachable or for pinning to a specific target)
} elseif ($Mode -eq 'auto') {
  switch ($Existing) {
    'none'  { $Mode = 'install' }
    'mixed' {
      Err 'Both CLAUDE.md AND AGENTS.md present in this folder.'
      Err 'Decide which edition to keep, remove the other, then re-run with -Mode upgrade.'
      exit 70
    }
    default {
      $Mode = 'upgrade'
      if ([string]::IsNullOrEmpty($Edition)) { $Edition = $Existing }
    }
  }
}

Step "Mode: $Mode"
if ($Mode -eq 'convert') {
  Step "Converting: $Existing -> $ConvertTo"
}

# ---- edition selection ----
function Read-Edition {
  Write-Host ""
  Write-Host "Choose AI-DLC edition:"
  Write-Host "  [1] Claude Code edition (CLAUDE.md + .claude\)"
  Write-Host "  [2] Kiro IDE edition    (AGENTS.md + .kiro\)"
  $choice = Read-Host "Enter 1 or 2"
  switch ($choice) {
    '1' { return 'claude-code' }
    '2' { return 'kiro' }
    default { Err 'Invalid choice'; exit 64 }
  }
}

if ([string]::IsNullOrEmpty($Edition)) {
  if ($Yes) {
    Err '-Edition required when -Yes is set'
    exit 64
  }
  $Edition = Read-Edition
}

# ---- version resolution ----
function Resolve-LatestVersion {
  $apiUrl = "$ApiBase/latest"
  try {
    $resp = Invoke-RestMethod -Uri $apiUrl -ErrorAction Stop
    return $resp.tag_name
  } catch {
    Err "Failed to query GitHub Releases. Check network or pass -Version vX.Y explicitly."
    exit 71
  }
}

if ($Version -eq 'latest') {
  Step "Resolving latest version from GitHub..."
  $Version = Resolve-LatestVersion
  if ([string]::IsNullOrEmpty($Version)) {
    Err 'Could not parse latest version from GitHub response'
    exit 72
  }
}

if ($Version -notmatch '^v\d+\.\d+$') {
  Err "Invalid version format: $Version (expected vX.Y)"
  exit 64
}

# ---- current version (upgrade mode only) ----
function Parse-CurrentVersion {
  param([string]$File)
  if (-not (Test-Path -LiteralPath $File)) { return '' }
  $content = Get-Content -LiteralPath $File -TotalCount 5 -ErrorAction SilentlyContinue
  if ($null -eq $content) { return '' }
  $joined = $content -join "`n"
  if ($joined -match 'v\d+\.\d+') {
    return $Matches[0]
  }
  return ''
}

$CurrentVersion = ''
if ($Mode -eq 'upgrade') {
  $rootFile = if ($Edition -eq 'claude-code') { 'CLAUDE.md' } else { 'AGENTS.md' }
  $CurrentVersion = Parse-CurrentVersion -File (Join-Path $Cwd $rootFile)
  Step "Detected current version: $(if ($CurrentVersion) { $CurrentVersion } else { 'unknown' })"
  Step "Target version: $Version"

  if ($CurrentVersion -eq $Version) {
    Say "Already on $Version - nothing to do."
    exit 0
  }
} elseif ($Mode -eq 'convert') {
  $rootFile = if ($Existing -eq 'claude-code') { 'CLAUDE.md' } else { 'AGENTS.md' }
  $CurrentVersion = Parse-CurrentVersion -File (Join-Path $Cwd $rootFile)
  Step "Source: $Existing $(if ($CurrentVersion) { $CurrentVersion } else { '(unknown version)' })"
  Step "Target: $ConvertTo $Version"
}

# ---- asset URL ----
$AssetName = "kafi-aidlc-$Version-$Edition.zip"
$AssetUrl  = "https://github.com/$GhRepo/releases/download/$Version/$AssetName"

# ---- helpers: package paths + exclusion check ----
function Get-PackagePaths {
  if ($Edition -eq 'claude-code') {
    return @('CLAUDE.md', 'README.md', 'aidlc-rule-details', '.claude')
  } else {
    return @('AGENTS.md', 'README.md', '.kiro')
  }
}

# In convert mode, returns paths of the FROM edition (to be removed/backed up)
function Get-FromPackagePaths {
  if ($Existing -eq 'claude-code') {
    return @('CLAUDE.md', 'README.md', 'aidlc-rule-details', '.claude')
  } else {
    return @('AGENTS.md', 'README.md', '.kiro')
  }
}

$Exclusions = @(
  '.git', '.gitignore', '.gitattributes',
  '.DS_Store', 'Thumbs.db', 'desktop.ini',
  'node_modules', 'dist', 'build', 'target', '.next', '.cache',
  '.vscode', '.idea', '.cursor',
  '.env', '.envrc', '.env.local',
  'package-lock.json', 'yarn.lock', 'Cargo.lock'
)

function Get-MovableItems {
  Get-ChildItem -LiteralPath $Cwd -Force | Where-Object {
    $name = $_.Name
    if ($Exclusions -contains $name) { return $false }
    if ($name -like '*.lock') { return $false }
    if ($name -like '.aidlc-backup-*') { return $false }
    return $true
  }
}

# ---- plan summary ----
function Show-Plan {
  Write-Host ""
  Write-Host "=== Plan ===" -ForegroundColor White
  Write-Host "  Mode:     $Mode"
  Write-Host "  Edition:  $Edition"
  $verLine = "  Version:  $Version"
  if ($CurrentVersion) { $verLine += " (upgrading from $CurrentVersion)" }
  Write-Host $verLine
  Write-Host "  Target:   $Cwd"
  Write-Host "  Asset:    $AssetName"

  if ($Mode -eq 'install' -and -not $NoMove) {
    $movable = Get-MovableItems
    if ($movable.Count -gt 0) {
      Write-Host "  Move:     $($movable.Count) existing item(s) -> 00-knowledge\references\"
    }
  }
  if ($Mode -eq 'upgrade') {
    $ts = Get-Date -Format 'yyyyMMdd-HHmmss'
    Write-Host "  Backup:   .aidlc-backup-$ts\"
    Write-Host "  Replace:  $((Get-PackagePaths) -join ' ')"
    Write-Host "  Preserve: 00-knowledge\ aidlc-docs\ src\ adrs\ ai-dlc\ .git\"
  }
  if ($Mode -eq 'convert') {
    $ts = Get-Date -Format 'yyyyMMdd-HHmmss'
    Write-Host "  Backup:   .aidlc-backup-$ts-from-$Existing\"
    Write-Host "  Remove:   $((Get-FromPackagePaths) -join ' ')"
    Write-Host "  Install:  $((Get-PackagePaths) -join ' ')"
    Write-Host "  Preserve: 00-knowledge\ aidlc-docs\ src\ adrs\ ai-dlc\ .git\"
    Write-Host ''
    Warn "Edition-specific customizations to roles/skills/rules will be"
    Warn "preserved in the backup but NOT auto-ported to $ConvertTo."
    Warn "Manual review of backup may be required if you customized files."
  }
  if ($DryRun) {
    Write-Host ""
    Warn 'DRY-RUN: no changes will be made.'
  }
  Write-Host ""
}

function Confirm-Plan {
  if ($Yes -or $DryRun) { return }
  $reply = Read-Host 'Proceed? [Y/n]'
  if ([string]::IsNullOrEmpty($reply)) { $reply = 'Y' }
  if ($reply -notmatch '^[Yy]$') {
    Err 'Aborted by user.'
    exit 1
  }
}

# ---- action: move existing files to 00-knowledge/references/ ----
function Move-ToReferences {
  if ($NoMove) { return }
  $movable = Get-MovableItems
  if ($movable.Count -eq 0) {
    Step 'No existing files to move (workspace was empty).'
    return
  }
  Step "Moving $($movable.Count) item(s) -> 00-knowledge\references\"
  if ($DryRun) {
    foreach ($it in $movable) {
      Write-Host "  [dry-run] mv $($it.Name) 00-knowledge\references\"
    }
    return
  }
  $dest = Join-Path $Cwd '00-knowledge\references'
  New-Item -ItemType Directory -Path $dest -Force | Out-Null
  foreach ($it in $movable) {
    Move-Item -LiteralPath $it.FullName -Destination $dest -Force
  }
  Say "Moved $($movable.Count) item(s)."
}

# ---- action: backup existing package files ----
function Backup-ForUpgrade {
  $ts = Get-Date -Format 'yyyyMMdd-HHmmss'
  $backupDir = Join-Path $Cwd ".aidlc-backup-$ts"
  Step "Creating backup at $(Split-Path -Leaf $backupDir)\"

  if ($DryRun) {
    foreach ($p in Get-PackagePaths) {
      Write-Host "  [dry-run] mv $p $(Split-Path -Leaf $backupDir)\"
    }
    return
  }

  New-Item -ItemType Directory -Path $backupDir -Force | Out-Null
  foreach ($p in Get-PackagePaths) {
    $src = Join-Path $Cwd $p
    if (Test-Path -LiteralPath $src) {
      Move-Item -LiteralPath $src -Destination $backupDir -Force -ErrorAction SilentlyContinue
    }
  }
  Say "Backup created at $(Split-Path -Leaf $backupDir)\"
}

# ---- action: backup FROM edition + remove its paths (convert mode) ----
function Backup-ForConvert {
  $ts = Get-Date -Format 'yyyyMMdd-HHmmss'
  $backupDir = Join-Path $Cwd ".aidlc-backup-$ts-from-$Existing"
  Step "Backing up $Existing edition files to $(Split-Path -Leaf $backupDir)\"

  if ($DryRun) {
    foreach ($p in Get-FromPackagePaths) {
      Write-Host "  [dry-run] mv $p $(Split-Path -Leaf $backupDir)\"
    }
    return
  }

  New-Item -ItemType Directory -Path $backupDir -Force | Out-Null
  foreach ($p in Get-FromPackagePaths) {
    $src = Join-Path $Cwd $p
    if (Test-Path -LiteralPath $src) {
      Move-Item -LiteralPath $src -Destination $backupDir -Force -ErrorAction SilentlyContinue
    }
  }
  Say "Backup of $Existing edition created at $(Split-Path -Leaf $backupDir)\"
}

# ---- action: download + extract zip ----
function Get-AndExtract {
  $tmpZip = Join-Path ([System.IO.Path]::GetTempPath()) "kafi-aidlc-$([guid]::NewGuid().Guid).zip"
  Step "Downloading $AssetUrl"

  if ($DryRun) {
    Write-Host "  [dry-run] Invoke-WebRequest $AssetUrl -> $tmpZip"
    Write-Host "  [dry-run] Expand-Archive $tmpZip -DestinationPath $Cwd"
    return
  }

  try {
    Invoke-WebRequest -Uri $AssetUrl -OutFile $tmpZip -ErrorAction Stop
  } catch {
    Err "Download failed: $AssetUrl"
    Err "Check that the release exists at https://github.com/$GhRepo/releases"
    if (Test-Path -LiteralPath $tmpZip) { Remove-Item -LiteralPath $tmpZip -Force }
    exit 73
  }

  $size = (Get-Item -LiteralPath $tmpZip).Length
  if ($size -lt 50000) {
    Err "Downloaded file is suspiciously small ($size bytes). Aborting."
    Remove-Item -LiteralPath $tmpZip -Force
    exit 74
  }

  Step "Extracting into $Cwd..."
  try {
    Expand-Archive -LiteralPath $tmpZip -DestinationPath $Cwd -Force
  } catch {
    Err "Unzip failed: $_"
    Remove-Item -LiteralPath $tmpZip -Force
    exit 75
  }

  Remove-Item -LiteralPath $tmpZip -Force
  Say "Extracted AI-DLC $Version ($Edition)."
}

# ---- next steps ----
function Show-NextStepsInstall {
  $ideName = if ($Edition -eq 'claude-code') { 'Claude Code' } else { 'Kiro IDE' }
@"

=== Next steps ===

1. Create ai-dlc\project.md with project metadata.
   See template in README.md "How to use" step 4.

2. Start your first AI session.
   Open this folder in $ideName.
   In chat, type:
     Run #kafi-aidlc-onboarding

   The onboarding skill will scan 00-knowledge\, detect your current
   AI-DLC stage, and start a session with the right role + prompt.

3. /init is not needed. The workflow spec is already in CLAUDE.md/AGENTS.md
   and auto-loaded on every session.

"@ | Write-Host
}

function Show-NextStepsUpgrade {
@"

=== Upgrade complete ===

Old files backed up to: .aidlc-backup-* (in this folder)

=== Next steps ===

1. Review changes:   git diff
2. Read changelog:   https://github.com/$GhRepo/blob/main/CHANGELOG.md
3. Stage + commit:   git add . ; git commit -m "Upgrade AI-DLC to $Version"

If anything breaks, restore from the backup directory.

"@ | Write-Host
}

function Show-NextStepsConvert {
  $ideName = if ($ConvertTo -eq 'claude-code') { 'Claude Code' } else { 'Kiro IDE' }
  $entry   = if ($ConvertTo -eq 'claude-code') { 'Run #kafi-aidlc-onboarding' } else { '#kafi-aidlc-onboarding' }
@"

=== Edition conversion complete ===

  $Existing -> $ConvertTo $Version

Previous $Existing edition files backed up to:
  .aidlc-backup-*-from-$Existing\

User content preserved (00-knowledge\, aidlc-docs\, src\, adrs\, ai-dlc\).
These directories are edition-agnostic - the workflow rules in $ConvertTo
reference the same paths.

=== Next steps ===

1. Open the project in $ideName.

2. Start your first $ConvertTo session:
     $entry

   The onboarding skill detects your current AI-DLC stage from
   the preserved aidlc-docs\ and resumes accordingly.

3. If you customized any rule/skill/role files in the previous edition,
   they are in the backup folder but NOT auto-ported. Diff against the new
   files in $ConvertTo's structure and manually port if needed:
     - Claude -> Kiro:  .claude\skills\kafi\roles\X.md  ->  .kiro\steering\roles\X.md  (add YAML frontmatter)
     - Kiro -> Claude:  .kiro\steering\roles\X.md       ->  .claude\skills\kafi\roles\X.md  (strip YAML frontmatter)

4. Stage + commit:   git add . ; git commit -m "Convert AI-DLC: $Existing -> $ConvertTo"

"@ | Write-Host
}

# ============================================================
# MAIN EXECUTION
# ============================================================

Show-Plan
Confirm-Plan

switch ($Mode) {
  'install' {
    Move-ToReferences
    Get-AndExtract
    Show-NextStepsInstall
  }
  'upgrade' {
    Backup-ForUpgrade
    Get-AndExtract
    Show-NextStepsUpgrade
  }
  'convert' {
    Backup-ForConvert
    Get-AndExtract
    Show-NextStepsConvert
  }
  default {
    Err "Unsupported mode: $Mode"
    exit 64
  }
}

Say 'Done.'
