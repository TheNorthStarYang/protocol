#ifndef AHAKEY_PROTOCOL_H
#define AHAKEY_PROTOCOL_H

#include <stdbool.h>
#include <stdint.h>

#ifdef __cplusplus
extern "C" {
#endif

#define AHAKEY_OFFICIAL_COMMAND_MIN 0x00
#define AHAKEY_OFFICIAL_COMMAND_MAX 0x9F
#define AHAKEY_CUSTOM_COMMAND_MIN   0xA0
#define AHAKEY_CUSTOM_COMMAND_MAX   0xEF
#define AHAKEY_SYSTEM_COMMAND_MIN   0xF0
#define AHAKEY_SYSTEM_COMMAND_MAX   0xFF

typedef void (*ahakey_command_handler_t)(const uint8_t *data, uint16_t len);

bool ahakey_register_command(uint8_t cmd, ahakey_command_handler_t handler);
void ahakey_send_response(uint8_t cmd, const uint8_t *data, uint16_t len);

#ifdef __cplusplus
}
#endif

#endif
