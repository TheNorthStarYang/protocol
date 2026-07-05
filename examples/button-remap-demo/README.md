# Button Remap Demo

## What it does

Demonstrates four-button event handling and HID key output.

## SDK modules

- `sdk/buttons/`
- `sdk/core/include/ahakey_key.h`
- `sdk/core/include/ahakey_hid.h`

## Build

```powershell
powershell -ExecutionPolicy Bypass -File .\sdk\build\build.ps1 -Example button-remap-demo
```

## Flash

Use the generated HEX under `build/button-remap-demo/` with the WCH official flashing workflow.

## Expected effect

The four main keys run the remapped actions defined in `user_app.c`.

## Desktop compatibility

Compatible with official communication as long as official command ranges are not reused.
