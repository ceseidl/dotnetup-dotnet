# Runs "dotnet --version" inside each case folder and prints
# what the global.json asked for and what dotnet answered.
# On Windows the failure code is 0x8000809B (155 in bash).
$cases = Join-Path $PSScriptRoot '..\cases'

foreach ($dir in Get-ChildItem $cases -Directory) {
    $file = Join-Path $dir.FullName 'global.json'
    $sdk = (Get-Content $file -Raw | ConvertFrom-Json).sdk
    Write-Host "[$($dir.Name)] version=$($sdk.version)" `
        "rollForward=$($sdk.rollForward)"

    Push-Location $dir.FullName
    $out = & dotnet --version 2>&1 | Out-String
    $code = $LASTEXITCODE
    Pop-Location

    Write-Host "  exit=$code"
    $line = $out -split "`n" |
        ForEach-Object { $_.Trim() } |
        Where-Object { $_ -match '^\d|compatible' } |
        Select-Object -First 1
    Write-Host "  $line"
}
