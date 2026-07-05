#include "ahakey_sdk.h"

void ahakey_user_init(void)
{
    ahakey_led_clear();
    ahakey_led_set_pixel(0, 80, 0, 0);
    ahakey_led_set_pixel(1, 0, 80, 0);
    ahakey_led_set_pixel(2, 0, 0, 80);
    ahakey_led_show();
}

void ahakey_user_loop(void)
{
}

