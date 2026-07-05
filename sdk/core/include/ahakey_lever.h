#ifndef AHAKEY_LEVER_H
#define AHAKEY_LEVER_H

#ifdef __cplusplus
extern "C" {
#endif

typedef enum {
    AHAKEY_LEVER_UNKNOWN = 0,
    AHAKEY_LEVER_UP,
    AHAKEY_LEVER_DOWN
} ahakey_lever_state_t;

ahakey_lever_state_t ahakey_get_lever_state(void);
void ahakey_on_lever_change(ahakey_lever_state_t state);

#ifdef __cplusplus
}
#endif

#endif

