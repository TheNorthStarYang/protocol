#ifndef AHAKEY_SDK_H
#define AHAKEY_SDK_H

#include <stdbool.h>
#include <stdint.h>

#include "ahakey_ai.h"
#include "ahakey_hid.h"
#include "ahakey_key.h"
#include "ahakey_led.h"
#include "ahakey_lever.h"
#include "ahakey_oled.h"
#include "ahakey_protocol.h"
#include "ahakey_storage.h"

#ifdef __cplusplus
extern "C" {
#endif

#define AHAKEY_SDK_VERSION_MAJOR 0
#define AHAKEY_SDK_VERSION_MINOR 1
#define AHAKEY_SDK_VERSION_PATCH 0

void ahakey_user_init(void);
void ahakey_user_loop(void);
uint32_t ahakey_millis(void);

#ifdef __cplusplus
}
#endif

#endif

