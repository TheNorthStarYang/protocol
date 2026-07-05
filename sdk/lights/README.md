# Lights SDK

Use the lights SDK to control the RGB / LED strip.

Related headers:

```text
sdk/core/include/ahakey_led.h
sdk/core/include/ahakey_ai.h
```

Typical APIs:

```c
ahakey_led_set_brightness(35);
ahakey_led_fill(0, 80, 20);
ahakey_led_show();
```

Light behavior may still be affected by official firmware priority states such as power-off prompt, Bluetooth reset, or HID-not-connected indication.
