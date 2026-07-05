# Examples

Examples demonstrate public SDK usage.

| Example | Status | Purpose |
|---|---|---|
| `button-remap-demo/` | Buildable | Remap four main keys and send HID output |
| `toggle-switch-demo/` | Buildable sample | React to toggle switch and custom workflow logic |
| `light-status-demo/` | Buildable sample | Demonstrate LED status feedback |
| `screen-hello-demo/` | Buildable | Draw text on OLED |
| `agent-status-display/` | Buildable default | Display AI agent state with OLED and LEDs |
| `custom-hex-demo/` | Buildable sample | Show how to build a custom HEX |

Build default:

```powershell
powershell -ExecutionPolicy Bypass -File .\sdk\build\build.ps1
```

Build a specific example:

```powershell
powershell -ExecutionPolicy Bypass -File .\sdk\build\build.ps1 -Example screen-hello-demo
```
