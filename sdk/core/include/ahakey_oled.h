#ifndef AHAKEY_OLED_H
#define AHAKEY_OLED_H

#include <stdint.h>

#ifdef __cplusplus
extern "C" {
#endif

#define AHAKEY_OLED_WIDTH 160
#define AHAKEY_OLED_HEIGHT 80

typedef struct {
    uint8_t x;
    uint8_t y;
    uint8_t width;
    uint8_t height;
} ahakey_oled_region_t;

void ahakey_oled_clear(void);
void ahakey_oled_flush(void);
void ahakey_oled_draw_text(uint8_t x, uint8_t y, const char *text);
void ahakey_oled_draw_bitmap_rgb565(uint8_t x, uint8_t y, uint8_t width, uint8_t height, const uint8_t *rgb565);
void ahakey_oled_fill_rect(uint8_t x, uint8_t y, uint8_t width, uint8_t height, uint16_t color565);
void ahakey_oled_set_region(uint8_t region_id, ahakey_oled_region_t region);
void ahakey_oled_clear_region(uint8_t region_id);
void ahakey_oled_draw_text_in_region(uint8_t region_id, const char *text);

#ifdef __cplusplus
}
#endif

#endif

