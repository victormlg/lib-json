#ifndef LIBPARSEJSON_H
#define LIBPARSEJSON_H

#include <json.h>
#include "jsonparse.tab.h"

typedef void *YY_BUFFER_STATE;
extern YY_BUFFER_STATE yy_scan_string(const char *str);
extern void yy_delete_buffer(YY_BUFFER_STATE buffer);

int ParseJson(const char *filename, JsonElement **root);
int ParseJsonFromString(const char *json_str, JsonElement **root);

#endif