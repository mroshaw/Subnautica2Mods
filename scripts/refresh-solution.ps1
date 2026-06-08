$scriptDir = Split-Path -Parent $MyInvocation.MyCommand.Path
$modsDir = Join-Path (Split-Path -Parent $scriptDir) "mods"
Set-Location $modsDir
cmake -S . -B Output
