# Desktop Compatibility

The SDK is designed to preserve official AhaKey desktop compatibility where possible.

## Compatibility Goals

User firmware built with this SDK should keep:

- BLE custom service compatibility
- state query compatibility
- official command range compatibility
- AhaKey Studio basic connection compatibility
- HID behavior unless intentionally customized

## Do Not Break

SDK user code should avoid:

- reusing official command IDs in `0x00 - 0x9F`
- blocking state query responses
- disabling BLE custom service behavior
- breaking save configuration flow
- treating user custom HEX as official firmware

## Recommended Custom Command Range

Use:

```text
0xA0 - 0xEF
```

Do not use:

```text
0x00 - 0x9F
0xF0 - 0xFF
```

## Official Desktop Client

Official desktop clients may depend on:

- `0x00` state query
- key configuration commands
- light configuration commands
- OLED/image metadata commands
- AI state sync commands
- switch state reporting

Based on current firmware reference, subject to confirmation.
