#include "ahakey_sdk.h"

void ahakey_user_init(void)
{
    ahakey_oled_set_region(0, (ahakey_oled_region_t){0, 0, 80, 20});
    ahakey_oled_set_region(1, (ahakey_oled_region_t){80, 0, 80, 20});
    ahakey_oled_clear();
    ahakey_oled_draw_text_in_region(0, "Mode");
    ahakey_oled_draw_text_in_region(1, "Ready");
    ahakey_oled_flush();
}

void ahakey_user_loop(void)
{
}

