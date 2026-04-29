# Sync agents/*.md into ~/.claude/agents/
# Run from the repo root: ./sync.ps1

$ErrorActionPreference = 'Stop'

$srcDir  = Join-Path $PSScriptRoot 'agents'
$destDir = Join-Path $HOME '.claude\agents'

if (-not (Test-Path $srcDir)) {
    Write-Error "source directory not found: $srcDir"
    exit 1
}

if (-not (Test-Path $destDir)) {
    New-Item -ItemType Directory -Path $destDir -Force | Out-Null
}

$files = Get-ChildItem -Path $srcDir -Filter '*.md' -File
foreach ($f in $files) {
    Copy-Item -Path $f.FullName -Destination $destDir -Force
    Write-Output "synced: $($f.Name)"
}

Write-Output ""
Write-Output "done — $($files.Count) agent(s) deployed to $destDir"
