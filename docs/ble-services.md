# BLE Services

This document describes the public BLE surfaces relevant to AhaKey Developer Kit.

## Public Integration Focus

Based on current firmware reference, subject to confirmation:

| Service / Characteristic | Direction | Role | Status |
|---|---|---|---|
| Service `0x7340` | - | AhaKey custom service | Stable |
| Char1 `0x7341` | Host -> Device | Bulk payload path | Experimental |
| Char3 `0x7343` | Host -> Device | Command write path | Stable |
| Char4 `0x7344` | Device -> Host | Notify / response path | Stable |

## Char1 `0x7341`

Bulk payload path.

Known use cases:

- image / OLED related payload transfer
- larger data movement

Do not use Char1 as the general command path.

## Char3 `0x7343`

Main command write path.

Typical use:

- state query
- save configuration
- key configuration
- light state sync
- AI state sync
- OLED/GIF metadata commands

## Char4 `0x7344`

Notify / response path.

Host clients should subscribe to Char4 before sending commands.

## Standard BLE/HID Services

AhaKey also uses standard BLE/HID-related services such as HID, Battery, Device Information, GAP/GATT, and Scan Parameters. These are important for complete device behavior but are not the primary custom protocol surface.

TODO: confirm exact standard service UUID list from firmware for public documentation.
