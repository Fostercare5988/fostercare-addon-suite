<#
.SYNOPSIS
    Installs or updates the Fostercare Addon Suite into the World of Warcraft Interface\AddOns folder.
#>
param(
    [string]$TargetDir = "..\Interface\AddOns"
)

$Addons = @(
    "ItemRack",
    "Bagnon",
    "TrinketMenu",
    "AutoLazy",
    "AutoBG",
    "MikScrollingBattleText",
    "TWThreat"
)

$ResolvedTarget = Resolve-Path -Path $TargetDir -ErrorAction SilentlyContinue
if (-not $ResolvedTarget) {
    Write-Host "Creating target directory: $TargetDir" -ForegroundColor Yellow
    $ResolvedTarget = (New-Item -ItemType Directory -Path $TargetDir -Force).FullName
} else {
    $ResolvedTarget = $ResolvedTarget.Path
}

Write-Host "Installing Fostercare Addon Suite into: $ResolvedTarget" -ForegroundColor Cyan

foreach ($addon in $Addons) {
    $source = Join-Path $PSScriptRoot $addon
    $dest = Join-Path $ResolvedTarget $addon
    if (Test-Path $source) {
        Write-Host "  -> Deploying $addon..." -ForegroundColor Green
        Copy-Item -Path $source -Destination $dest -Recurse -Force -Exclude ".git"
    } else {
        Write-Warning "  [!] Submodule $addon not found. Run 'git submodule update --init --recursive' first."
    }
}

Write-Host "`nAll addons deployed successfully!" -ForegroundColor Green
