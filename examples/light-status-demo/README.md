# Light Status Demo

## What it does

Demonstrates LED status feedback.

## SDK modules

- `sdk/lights/`
- `sdk/core/include/ahakey_led.h`

## Build

```powershell
powershell -ExecutionPolicy Bypass -File .\sdk\build\build.ps1 -Example light-status-demo
```

## Expected effect

LED strip changes color based on demo logic.

## Status

Buildable sample. Some official firmware priority states may override LEDs.
