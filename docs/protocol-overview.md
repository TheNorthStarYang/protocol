# Protocol Overview

AhaKey devices expose two major communication surfaces:

1. Standard BLE / HID behavior for keyboard input.
2. AhaKey custom BLE service for device configuration, state sync, image/OLED workflows, light control, and desktop integration.

For third-party clients, the custom BLE service is the main public protocol entry.

## Custom Service

Based on current firmware reference, subject to confirmation:

```text
Service: 0x7340
Char1:   0x7341  Host -> Device bulk payload path
Char3:   0x7343  Host -> Device command path
Char4:   0x7344  Device -> Host notify / response path
```

Recommended flow:

1. Scan and connect to AhaKey.
2. Discover service `0x7340`.
3. Subscribe to notify on `0x7344`.
4. Send command frames to `0x7343`.
5. Use `0x7341` only for documented bulk data flows.

## Frame Boundary

Current command frame boundary:

```text
AA BB ... CC DD
```

There is no public checksum or length field documented for the general command model. Clients should not assume undocumented framing semantics.

## Stability Levels

- Stable: documented and intended for third-party clients.
- Experimental: available but still evolving.
- Internal: implementation detail, not a public contract.

## Related Docs

- `docs/ble-services.md`
- `docs/commands.md`
- `docs/status-sync.md`
- `docs/desktop-compatibility.md`
