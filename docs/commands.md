# Commands

Commands are sent through the AhaKey custom command path:

```text
Service 0x7340
Write:  0x7343
Notify: 0x7344
Frame:  AA BB <payload> CC DD
```

Based on current firmware reference, subject to confirmation.

## Command Range Policy

| Range | Owner |
|---|---|
| `0x00 - 0x9F` | Official AhaKey firmware / AhaKey Studio commands |
| `0xA0 - 0xEF` | SDK user custom commands |
| `0xF0 - 0xFF` | System / debug / factory reserved |

Official firmware development should not allocate commands in `0xA0 - 0xEF`.

## Public / Semi-Public Commands

| Command | Purpose | Status | Notes |
|---|---|---|---|
| `0x00` | Device state query | Stable | Returns battery, firmware version, mode, light, switch state |
| `0x01` | Device name update | Experimental | Persistence behavior should be confirmed |
| `0x02` | Appearance update | Experimental | TODO: confirm public payload |
| `0x03` | Reset branch | Internal | Do not depend on it |
| `0x04` | Save configuration | Stable | Commit changed config |
| `0x73` | Key configuration container | Stable | Includes key binding and key description subtypes |
| `0x80` | Bulk/image write init | Experimental | Uses flash address/size; validate carefully |
| `0x82` | Image/OLED metadata update | Experimental | Updates picture metadata |
| `0x83` | Image/OLED metadata query | Stable | Query current picture metadata |
| `0x84` | AI state light configuration | Experimental | Mode + per-state light mode table |
| `0x85` | LED brightness configuration | Experimental | Brightness range currently `1..100` |
| `0x90` | AI / Claude state update | Stable | High-level workflow state sync |
| `0x91` | Direct WS2812 light effect | Experimental | Used by desktop-side preview / hook flows |
| `0x92` | Set keyboard work mode | Experimental | Lets host switch device mode |
| `0x93` | AI OLED GIF metadata update | Experimental | Mode + AI OLED state + start/count/interval |
| `0x94` | AI OLED GIF metadata query | Experimental | Query AI OLED GIF metadata |

## `0x00` State Query

Response frame:

| Byte | Meaning |
|---|---|
| `0` | `0xAA` |
| `1` | `0xBB` |
| `2` | `0x00` |
| `3` | Battery |
| `4` | Signal |
| `5` | Firmware major |
| `6` | Firmware minor |
| `7` | Mode |
| `8` | Light |
| `9` | Switch state |
| `10` | Reserved |
| `11` | Optional brightness in newer firmware references |
| tail | `0xCC 0xDD` |

TODO: confirm exact returned length across firmware versions.

## `0x73` Key Configuration Container

Known subtypes:

| Subtype | Purpose |
|---|---|
| `0x73` | Key binding / macro-like data |
| `0x74` | Legacy key mode path |
| `0x75` | Key description text |

Clients should treat this as a high-level configuration container and avoid relying on internal storage layout.

## `0x90` AI State Update

Known high-level states include:

- Notification
- PermissionRequest
- PostToolUse
- PreToolUse
- SessionStart
- Stop
- TaskCompleted
- UserPromptSubmit
- SessionEnd

The firmware may map these states into simplified SDK callbacks such as running, waiting for approval, done, stopped, and idle.

## Custom SDK Commands

SDK users should register commands only in:

```text
0xA0 - 0xEF
```

These commands are intended for user firmware and custom desktop clients.
