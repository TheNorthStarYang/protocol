#ifndef AHAKEY_KEY_H
#define AHAKEY_KEY_H

#include <stdint.h>

#ifdef __cplusplus
extern "C" {
#endif

#define AHAKEY_KEY_COUNT 4

typedef enum {
    AHAKEY_KEY_DOWN = 0,
    AHAKEY_KEY_UP,
    AHAKEY_KEY_SHORT,
    AHAKEY_KEY_LONG,
    AHAKEY_KEY_DOUBLE,
    AHAKEY_KEY_HOLD
} ahakey_key_event_t;

void ahakey_on_key_event(uint8_t key_id, ahakey_key_event_t event);

#ifdef __cplusplus
}
#endif

#endif

