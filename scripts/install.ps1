param(
  [string]$TargetPath = '.',
  [ValidateSet('Install','Check','Upgrade')][string]$Mode = 'Install'
)
$ErrorActionPreference = 'Stop'
$root = (Resolve-Path (Join-Path $PSScriptRoot '..')).Path
if (-not (Test-Path -LiteralPath $TargetPath -PathType Container)) { throw "Target does not exist: $TargetPath" }
$target = (Resolve-Path -LiteralPath $TargetPath).Path
if ($root -eq $target) { throw 'Do not install into the toolkit source directory.' }
$dir = Join-Path $target '.claude'
$manifestPath = Join-Path $dir 'team-toolkit-manifest.json'
$previous = @{}
if (Test-Path -LiteralPath $manifestPath) {
  $raw = Get-Content -LiteralPath $manifestPath -Raw | ConvertFrom-Json
  if ($raw.files) { $raw.files.PSObject.Properties | ForEach-Object { $previous[$_.Name] = $_.Value } }
}
$newFiles = @{}
foreach ($k in $previous.Keys) { $newFiles[$k] = $previous[$k] }
$modified = $false
$stamp = Get-Date -Format 'yyyyMMdd-HHmmss'
foreach ($category in @('skills','agents')) {
  $srcRoot = Join-Path $root ".claude/$category"
  Get-ChildItem -LiteralPath $srcRoot -Recurse -File | ForEach-Object {
    $relative = $_.FullName.Substring((Join-Path $root '.claude').Length).TrimStart([char[]]@('\','/')).Replace('\','/')
    $dst = Join-Path $dir ($relative.Replace('/', [IO.Path]::DirectorySeparatorChar))
    $sha = (Get-FileHash -LiteralPath $_.FullName -Algorithm SHA256).Hash.ToLowerInvariant()
    if (-not (Test-Path -LiteralPath $dst)) {
      Write-Host "ADD: $relative"
      if ($Mode -ne 'Check') {
        New-Item -ItemType Directory -Force -Path (Split-Path -Parent $dst) | Out-Null
        Copy-Item -LiteralPath $_.FullName -Destination $dst
        $newFiles[$relative] = $sha
        $script:modified = $true
      }
    } else {
      $curr = (Get-FileHash -LiteralPath $dst -Algorithm SHA256).Hash.ToLowerInvariant()
      if ($curr -eq $sha) {
        Write-Host "CURRENT: $relative"
        if ($Mode -ne 'Check' -and -not $newFiles.ContainsKey($relative)) { $newFiles[$relative] = $sha; $script:modified = $true }
      } elseif ($Mode -eq 'Upgrade' -and $previous.ContainsKey($relative) -and $curr -eq $previous[$relative]) {
        Write-Host "UPGRADE: $relative"
        $backup = Join-Path $dir ("team-toolkit-backups/$stamp/$relative")
        New-Item -ItemType Directory -Force -Path (Split-Path -Parent $backup) | Out-Null
        Copy-Item -LiteralPath $dst -Destination $backup
        Copy-Item -LiteralPath $_.FullName -Destination $dst -Force
        $newFiles[$relative] = $sha
        $script:modified = $true
      } else { Write-Host "SKIP (existing/locally edited): $relative" }
    }
  }
}
$claude = Join-Path $target 'CLAUDE.md'
if ($Mode -ne 'Check') {
  if (-not (Test-Path -LiteralPath $claude)) {
    Copy-Item -LiteralPath (Join-Path $root 'CLAUDE.team.example.md') -Destination $claude
    Write-Host 'ADDED CLAUDE.md starter'
  } else {
    $content = Get-Content -LiteralPath $claude -Raw
    if (-not $content.Contains('<!-- claude-world-class-app-team -->')) {
      Add-Content -LiteralPath $claude -Value "`n<!-- claude-world-class-app-team -->`n"
      Get-Content -LiteralPath (Join-Path $root 'CLAUDE.team.example.md') -Raw | Add-Content -LiteralPath $claude
      Write-Host 'APPENDED operating contract to CLAUDE.md'
    }
  }
  if ($modified -or -not (Test-Path -LiteralPath $manifestPath)) {
    New-Item -ItemType Directory -Force -Path $dir | Out-Null
    $ordered = [ordered]@{}
    foreach ($k in ($newFiles.Keys | Sort-Object)) { $ordered[$k] = $newFiles[$k] }
    @{schema_version=1;files=$ordered} | ConvertTo-Json -Depth 5 | Set-Content -LiteralPath $manifestPath -Encoding utf8
  }
}
Write-Host "Finished: $Mode. Inspect git status/diff and restart Claude Code."
