param(
    [string] $Toolchain = "",
    [string] $WchSdk = ""
)

$ErrorActionPreference = "Stop"

$RepoRoot = Split-Path -Parent (Split-Path -Parent $PSScriptRoot)

function Read-LocalConfig {
    $configPath = Join-Path $RepoRoot "sdk\build\sdk.local.ps1"
    if (Test-Path $configPath) {
        . $configPath
    }
}

function Pick-Value {
    param([string] $ArgValue, [string] $EnvName, [string] $ScriptName)
    if ($ArgValue) { return $ArgValue }
    $envValue = [Environment]::GetEnvironmentVariable($EnvName)
    if ($envValue) { return $envValue }
    $scriptValue = Get-Variable -Name $ScriptName -Scope Script -ErrorAction SilentlyContinue
    if ($scriptValue) { return $scriptValue.Value }
    return ""
}

Read-LocalConfig
$Toolchain = Pick-Value $Toolchain "AHAKEY_TOOLCHAIN" "AHAKEY_TOOLCHAIN"
$WchSdk = Pick-Value $WchSdk "AHAKEY_WCH_SDK" "AHAKEY_WCH_SDK"

if (-not $Toolchain) {
    $candidates = @(
        "C:\MRS_Toolchain\MRS_Toolchain_Win_V1.92\RISC-V Embedded GCC\bin",
        "C:\MounRiver\MRS_Toolchain\RISC-V Embedded GCC\bin",
        "D:\MRS_Toolchain\MRS_Toolchain_Win_V1.92\RISC-V Embedded GCC\bin"
    )
    foreach ($candidate in $candidates) {
        if (Test-Path (Join-Path $candidate "riscv-none-embed-gcc.exe")) {
            $Toolchain = $candidate
            break
        }
    }
}

if (-not $WchSdk) {
    $candidates = @(
        "C:\WCH_SDK\ch583-main\EVT\EXAM",
        "D:\WCH_SDK\ch583-main\EVT\EXAM"
    )
    foreach ($candidate in $candidates) {
        if (Test-Path (Join-Path $candidate "BLE\LIB\LIBCH58xBLE.a")) {
            $WchSdk = $candidate
            break
        }
    }
}

$checks = @(
    @{ Name = "SDK umbrella header"; Path = Join-Path $RepoRoot "sdk\core\include\ahakey_sdk.h" },
    @{ Name = "Default example"; Path = Join-Path $RepoRoot "examples\agent-status-display\user_app.c" },
    @{ Name = "Core library"; Path = Join-Path $RepoRoot "sdk\core\lib\libahakey_core.a" },
    @{ Name = "Startup object"; Path = Join-Path $RepoRoot "sdk\core\lib\startup_CH583.o" },
    @{ Name = "Linker script"; Path = Join-Path $RepoRoot "sdk\core\linker\Link.ld" },
    @{ Name = "Compiler"; Path = if ($Toolchain) { Join-Path $Toolchain "riscv-none-embed-gcc.exe" } else { "" } },
    @{ Name = "Objcopy"; Path = if ($Toolchain) { Join-Path $Toolchain "riscv-none-embed-objcopy.exe" } else { "" } },
    @{ Name = "Size"; Path = if ($Toolchain) { Join-Path $Toolchain "riscv-none-embed-size.exe" } else { "" } },
    @{ Name = "WCH BLE lib"; Path = if ($WchSdk) { Join-Path $WchSdk "BLE\LIB\LIBCH58xBLE.a" } else { "" } },
    @{ Name = "WCH ISP lib"; Path = if ($WchSdk) { Join-Path $WchSdk "SRC\StdPeriphDriver\libISP583.a" } else { "" } }
)

$failed = 0
Write-Host "AhaKey X1 Hardware SDK environment check"
Write-Host "SDK root: $RepoRoot"
Write-Host "Toolchain: $Toolchain"
Write-Host "WCH SDK: $WchSdk"
Write-Host ""

foreach ($check in $checks) {
    if ($check.Path -and (Test-Path $check.Path)) {
        Write-Host "[OK] $($check.Name): $($check.Path)"
    } else {
        Write-Host "[MISS] $($check.Name): $($check.Path)" -ForegroundColor Red
        $failed++
    }
}

Write-Host ""
if ($failed -eq 0) {
    Write-Host "Environment check passed."
    Write-Host "Next: powershell -ExecutionPolicy Bypass -File .\sdk\build\build.ps1"
    exit 0
}

Write-Host "Environment check failed." -ForegroundColor Red
Write-Host "Configure paths using one of these methods:"
Write-Host "1. Pass -Toolchain and -WchSdk to tools\build.ps1 or tools\check-env.ps1."
Write-Host "2. Set AHAKEY_TOOLCHAIN and AHAKEY_WCH_SDK environment variables."
Write-Host "3. Copy sdk\build\sdk.local.example.ps1 to sdk\build\sdk.local.ps1 and edit it."
exit 1
