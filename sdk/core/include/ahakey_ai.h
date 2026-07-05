#ifndef AHAKEY_AI_H
#define AHAKEY_AI_H

#ifdef __cplusplus
extern "C" {
#endif

typedef enum {
    AHAKEY_AI_IDLE = 0,
    AHAKEY_AI_RUNNING,
    AHAKEY_AI_WAITING_APPROVAL,
    AHAKEY_AI_DONE,
    AHAKEY_AI_STOPPED
} ahakey_ai_state_t;

void ahakey_on_ai_state(ahakey_ai_state_t state);

#ifdef __cplusplus
}
#endif

#endif

