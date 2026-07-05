#ifndef AHAKEY_STORAGE_H
#define AHAKEY_STORAGE_H

#include <stdbool.h>
#include <stdint.h>

#ifdef __cplusplus
extern "C" {
#endif

bool ahakey_storage_read_user(uint16_t key, void *buf, uint16_t len);
bool ahakey_storage_write_user(uint16_t key, const void *buf, uint16_t len);
bool ahakey_storage_delete_user(uint16_t key);

#ifdef __cplusplus
}
#endif

#endif

