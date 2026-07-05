# Status Sync

Status sync covers device-to-desktop and desktop-to-device state exchange.

## Device State Query

Use command `0x00` to query current public device state.

Returned public fields include:

- Battery
- Signal
- Firmware version
- Current mode
- Light state
- Toggle switch state
- Reserved / future fields

Based on current firmware reference, subject to confirmation.

## Toggle Switch State

Current public interpretation:

```text
0 = up
1 = down
2 = middle / unknown
```

The toggle is useful for workflow tools such as manual approval vs automatic approval.

## AI State Sync

Desktop clients can send command `0x90` to sync AI workflow state.

Examples:

- session started
- user submitted prompt
- AI running tool
- waiting for permission
- stopped
- task completed
- session ended

The SDK exposes simplified AI states for user firmware examples.

## LED and OLED State

Newer firmware references include:

- AI light mapping commands
- direct light preview commands
- AI OLED GIF metadata commands

These are currently documented as Experimental because payload formats and UI behavior may still evolve.
