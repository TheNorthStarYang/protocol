#include "ahakey_sdk.h"

void ahakey_on_key_event(uint8_t key_id, ahakey_key_event_t event)
{
    if (key_id != 1) {
        return;
    }

    if (event == AHAKEY_KEY_SHORT) {
        ahakey_hid_send_key(AHAKEY_MOD_LEFT_CTRL, 0x06);
    } else if (event == AHAKEY_KEY_LONG) {
        ahakey_hid_send_key(AHAKEY_MOD_LEFT_CTRL, 0x16);
    } else if (event == AHAKEY_KEY_DOUBLE) {
        ahakey_led_fill(80, 80, 0);
        ahakey_led_show();
    }
}

