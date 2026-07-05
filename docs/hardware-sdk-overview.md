# Hardware SDK Overview

The AhaKey hardware SDK lets developers customize firmware behavior while keeping the official firmware core behind a binary library.

## What SDK Exposes

- Four main keys
- Toggle switch
- LED strip / RGB effects
- OLED text display
- HID key output
- AI state callback
- User custom commands

## What SDK Does Not Expose

- Full official firmware source
- PCB layout
- Gerber
- BOM
- Production test data
- Supply-chain data

## Current SDK Layout

```text
sdk/
├── core/
├── buttons/
├── toggle/
├── lights/
├── display/
├── communication/
├── battery/
└── build/
```

## Build

```powershell
powershell -ExecutionPolicy Bypass -File .\sdk\build\check-env.ps1
powershell -ExecutionPolicy Bypass -File .\sdk\build\build.ps1
```

## Status

The first SDK release is experimental but buildable on Windows. macOS / Linux are not yet officially verified.
