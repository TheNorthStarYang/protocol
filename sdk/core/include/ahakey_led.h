#ifndef AHAKEY_LED_H
#define AHAKEY_LED_H

#include <stdint.h>

#ifdef __cplusplus
extern "C" {
#endif

#define AHAKEY_LED_MAX_COUNT 8

typedef struct {
    uint8_t r;
    uint8_t g;
    uint8_t b;
} ahakey_rgb_t;

uint8_t ahakey_led_count(void);
void ahakey_led_set_pixel(uint8_t index, uint8_t r, uint8_t g, uint8_t b);
void ahakey_led_get_pixel(uint8_t index, ahakey_rgb_t *out);
void ahakey_led_fill(uint8_t r, uint8_t g, uint8_t b);
void ahakey_led_clear(void);
void ahakey_led_show(void);
void ahakey_led_set_brightness(uint8_t brightness);
uint8_t ahakey_led_get_brightness(void);

#ifdef __cplusplus
}
#endif

#endif

