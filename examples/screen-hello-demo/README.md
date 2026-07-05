# Screen Hello Demo

## What it does

Displays simple text on the OLED screen.

## SDK modules

- `sdk/display/`
- `sdk/core/include/ahakey_oled.h`

## Build

```powershell
powershell -ExecutionPolicy Bypass -File .\sdk\build\build.ps1 -Example screen-hello-demo
```

## Expected effect

OLED displays demo text.

## Desktop compatibility

Compatible with official communication as long as the user app does not disable official command handling.
