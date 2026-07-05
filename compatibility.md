# Compatibility

| SDK Version | Hardware | Desktop Client | BLE Protocol | Firmware Base | Status | Notes |
|---|---|---|---|---|---|---|
| 0.1.x | AhaKey X1 current hardware | Official AhaKey Studio, Windows tested path | Custom service `0x7340`; command `0x7343`; notify `0x7344`; bulk `0x7341` experimental | Current dev firmware reference with SDK bridge hooks | Experimental public SDK | Windows build flow verified locally; macOS/Linux not yet verified |

## Notes

- SDK firmware keeps official communication compatibility as a design goal.
- User custom commands should use `0xA0 - 0xEF`.
- User-built HEX files are custom developer firmware, not official AhaKey firmware.
- Based on current firmware reference, subject to confirmation across future firmware revisions.
