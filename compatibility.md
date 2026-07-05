# Compatibility

| SDK Version | Hardware | Desktop Client | BLE Protocol | Firmware Base | Status | Notes |
|---|---|---|---|---|---|---|
| 0.1.x | AhaKey X1 current hardware | Official AhaKey Studio compatibility target. Windows path tested first. | Custom service `0x7340`; command characteristic `0x7343`; notify characteristic `0x7344`; bulk characteristic `0x7341` is experimental. | Current dev firmware reference with SDK bridge hooks. | Experimental public SDK. | Windows build flow is verified locally. macOS and Linux build flows are reference-only for now. |

## Notes

- SDK firmware keeps official AhaKey Studio communication compatibility as a design goal.
- User custom commands should use the reserved range `0xA0` to `0xEF`.
- User-built HEX files are custom developer firmware, not official AhaKey firmware.
- Compatibility is based on the current firmware reference and may be updated across future firmware revisions.
