#include "ahakey_sdk.h"

static void set_ai_theme_rgb(const uint8_t *data, uint16_t len)
{
    if (len < 3) {
        return;
    }
    ahakey_led_fill(data[0], data[1], data[2]);
    ahakey_led_show();
}

void ahakey_user_init(void)
{
    ahakey_register_command(0xA0, set_ai_theme_rgb);
}
