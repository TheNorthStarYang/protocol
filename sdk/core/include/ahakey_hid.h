#ifndef AHAKEY_HID_H
#define AHAKEY_HID_H

#include <stdint.h>

#ifdef __cplusplus
extern "C" {
#endif

#define AHAKEY_MOD_LEFT_CTRL   0x01
#define AHAKEY_MOD_LEFT_SHIFT  0x02
#define AHAKEY_MOD_LEFT_ALT    0x04
#define AHAKEY_MOD_LEFT_GUI    0x08
#define AHAKEY_MOD_RIGHT_CTRL  0x10
#define AHAKEY_MOD_RIGHT_SHIFT 0x20
#define AHAKEY_MOD_RIGHT_ALT   0x40
#define AHAKEY_MOD_RIGHT_GUI   0x80

typedef enum {
    AHAKEY_MACRO_KEY_DOWN = 0,
    AHAKEY_MACRO_KEY_UP,
    AHAKEY_MACRO_DELAY,
    AHAKEY_MACRO_RELEASE_ALL
} ahakey_macro_step_type_t;

typedef struct {
    ahakey_macro_step_type_t type;
    uint8_t modifier;
    uint8_t keycode;
    uint16_t delay_ms;
} ahakey_macro_step_t;

/* keycode may be 0 when sending a modifier-only key such as Right Alt. */
void ahakey_hid_send_key(uint8_t modifier, uint8_t keycode);
void ahakey_hid_send_consumer_key(uint16_t usage);
void ahakey_hid_send_macro(const ahakey_macro_step_t *steps, uint8_t count);
void ahakey_hid_release_all(void);

#ifdef __cplusplus
}
#endif

#endif
