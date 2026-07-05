# AhaKey Hardware SDK

This SDK exposes developer-facing firmware interfaces for AhaKey X1 hardware customization.

## Important Boundary

The SDK exposes developer APIs. It is **not** the full official firmware source.

It is intended for:

- customization
- learning
- experiments
- custom local HEX builds
- hardware workflow demos

User-built HEX files are not official AhaKey firmware.

## Modules

```text
core/           public headers, binary core library, startup object, linker script
buttons/        four-button API notes
toggle/         toggle switch API notes
lights/         RGB / LED API notes
display/        OLED API notes
communication/  BLE/custom command notes
battery/        battery and power policy notes
build/          Windows build scripts
```

## Build

First release officially supports Windows:

```powershell
powershell -ExecutionPolicy Bypass -File .\sdk\build\check-env.ps1
powershell -ExecutionPolicy Bypass -File .\sdk\build\build.ps1
```

Build a specific example:

```powershell
powershell -ExecutionPolicy Bypass -File .\sdk\build\build.ps1 -Example screen-hello-demo
```

## Compatibility

The SDK is designed to keep official desktop communication compatibility where possible. User custom commands should stay within `0xA0 - 0xEF`.
