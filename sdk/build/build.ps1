param(
    [string] $Example = "agent-status-display",
    [string] $Toolchain = "",
    [string] $WchSdk = ""
)

$ErrorActionPreference = "Stop"

$RepoRoot = Split-Path -Parent (Split-Path -Parent $PSScriptRoot)
$CoreRoot = Join-Path $RepoRoot "sdk\core"
$ExampleDir = Join-Path $RepoRoot "examples\$Example"
$OutDir = Join-Path $RepoRoot "build\$Example"

function Read-LocalConfig {
    $configPath = Join-Path $RepoRoot "sdk\build\sdk.local.ps1"
    if (Test-Path $configPath) {
        . $configPath
    }
}

function Resolve-ToolchainPath {
    param([string] $Value)
    if ($Value) { return $Value }
    if ($env:AHAKEY_TOOLCHAIN) { return $env:AHAKEY_TOOLCHAIN }
    if ($script:AHAKEY_TOOLCHAIN) { return $script:AHAKEY_TOOLCHAIN }

    $candidates = @(
        "C:\MRS_Toolchain\MRS_Toolchain_Win_V1.92\RISC-V Embedded GCC\bin",
        "C:\MounRiver\MRS_Toolchain\RISC-V Embedded GCC\bin",
        "D:\MRS_Toolchain\MRS_Toolchain_Win_V1.92\RISC-V Embedded GCC\bin"
    )
    foreach ($candidate in $candidates) {
        if (Test-Path (Join-Path $candidate "riscv-none-embed-gcc.exe")) {
            return $candidate
        }
    }
    return ""
}

function Resolve-WchSdkPath {
    param([string] $Value)
    if ($Value) { return $Value }
    if ($env:AHAKEY_WCH_SDK) { return $env:AHAKEY_WCH_SDK }
    if ($script:AHAKEY_WCH_SDK) { return $script:AHAKEY_WCH_SDK }

    $candidates = @(
        "C:\WCH_SDK\ch583-main\EVT\EXAM",
        "D:\WCH_SDK\ch583-main\EVT\EXAM"
    )
    foreach ($candidate in $candidates) {
        if (Test-Path (Join-Path $candidate "BLE\LIB\LIBCH58xBLE.a")) {
            return $candidate
        }
    }
    return ""
}

Read-LocalConfig
$Toolchain = Resolve-ToolchainPath $Toolchain
$WchSdk = Resolve-WchSdkPath $WchSdk

if (-not (Test-Path (Join-Path $ExampleDir "user_app.c"))) {
    throw "Example not found: $ExampleDir"
}
if (-not $Toolchain) {
    throw "Toolchain path not configured. Set AHAKEY_TOOLCHAIN, create sdk.local.ps1, or pass -Toolchain."
}
if (-not $WchSdk) {
    throw "WCH SDK path not configured. Set AHAKEY_WCH_SDK, create sdk\build\sdk.local.ps1, or pass -WchSdk."
}

$CC = Join-Path $Toolchain "riscv-none-embed-gcc.exe"
$OBJCOPY = Join-Path $Toolchain "riscv-none-embed-objcopy.exe"
$SIZE = Join-Path $Toolchain "riscv-none-embed-size.exe"
$CoreLib = Join-Path $CoreRoot "lib\libahakey_core.a"
$StartupObj = Join-Path $CoreRoot "lib\startup_CH583.o"
$Linker = Join-Path $CoreRoot "linker\Link.ld"

foreach ($required in @($CC, $OBJCOPY, $SIZE, $CoreLib, $StartupObj, $Linker)) {
    if (-not (Test-Path $required)) {
        throw "Missing required file: $required"
    }
}
if (-not (Test-Path (Join-Path $WchSdk "BLE\LIB\LIBCH58xBLE.a"))) {
    throw "Missing WCH BLE library under: $WchSdk"
}
if (-not (Test-Path (Join-Path $WchSdk "SRC\StdPeriphDriver\libISP583.a"))) {
    throw "Missing ISP583 library under: $WchSdk"
}

New-Item -ItemType Directory -Force -Path $OutDir | Out-Null

$ArchFlags = "-march=rv32imac", "-mabi=ilp32"
$Includes = "-I$CoreRoot\include"
$CFlags = $ArchFlags + @("-Os", "-fmessage-length=0", "-fsigned-char", "-ffunction-sections", "-fdata-sections", "-fno-common", "-std=gnu99", $Includes, "-c")

$UserObjects = @()
foreach ($src in (Get-ChildItem $ExampleDir -Filter "*.c" | Select-Object -ExpandProperty FullName)) {
    $obj = Join-Path $OutDir ([System.IO.Path]::GetFileNameWithoutExtension($src) + ".o")
    Write-Host "[CC] $src"
    & $CC $CFlags "$src" -o $obj
    if ($LASTEXITCODE -ne 0) { throw "Failed to compile: $src" }
    $UserObjects += $obj
}

$Elf = Join-Path $OutDir "AhaKey-X1-$Example.elf"
$Hex = Join-Path $OutDir "AhaKey-X1-$Example.hex"

$LdFlags = @(
    "-march=rv32imac", "-mabi=ilp32",
    "-T", $Linker,
    "-nostartfiles",
    "--specs=nano.specs", "--specs=nosys.specs",
    "-Wl,--gc-sections",
    "-L$WchSdk\BLE\LIB",
    "-L$WchSdk\SRC\StdPeriphDriver",
    "-lISP583", "-lCH58xBLE"
)

Write-Host "[LINK] $Elf"
& $CC @($StartupObj) $UserObjects "-Wl,--whole-archive" $CoreLib "-Wl,--no-whole-archive" $LdFlags -o $Elf
if ($LASTEXITCODE -ne 0) { throw "Failed to link firmware" }

Write-Host "[HEX] $Hex"
& $OBJCOPY -O ihex $Elf $Hex
if ($LASTEXITCODE -ne 0) { throw "Failed to generate HEX" }

Write-Host ""
Write-Host "Size:"
& $SIZE $Elf

Write-Host ""
Write-Host "Build complete:"
Write-Host "  $Hex"
