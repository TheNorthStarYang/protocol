#include "ahakey_sdk.h"

void ahakey_on_ai_state(ahakey_ai_state_t state)
{
    if (state == AHAKEY_AI_RUNNING) {
        ahakey_led_fill(0, 0, 80);
        ahakey_oled_clear();
        ahakey_oled_draw_text(0, 0, "AI Running");
    } else if (state == AHAKEY_AI_WAITING_APPROVAL) {
        ahakey_led_fill(80, 40, 0);
        ahakey_oled_clear();
        ahakey_oled_draw_text(0, 0, "Approve?");
    } else {
        ahakey_led_clear();
        ahakey_oled_clear();
        ahakey_oled_draw_text(0, 0, "AI Idle");
    }
    ahakey_led_show();
    ahakey_oled_flush();
}
