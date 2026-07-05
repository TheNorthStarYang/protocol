# Custom HEX Demo

## What it does

Shows how a developer can build a custom HEX from SDK example code.

## SDK modules

- `sdk/core/`
- `sdk/build/`

## Build

```powershell
powershell -ExecutionPolicy Bypass -File .\sdk\build\build.ps1 -Example custom-hex-demo
```

## Flash

Use WCH official flashing tools to flash the generated HEX.

## Important

Custom HEX files are developer firmware. They are not official AhaKey firmware.
