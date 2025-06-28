#include <stdbool.h>
#include <stdint.h>

#ifndef JSON_LIB_H
#define JSON_LIB_H

typedef enum
{
    JSON_TYPE_ARRAY,
    JSON_TYPE_OBJECT,
    JSON_TYPE_STRING,
    JSON_TYPE_BOOLEAN,
    JSON_TYPE_NUMBER,
    JSON_TYPE_NULL
} JsonType;


struct json_value
{
    JsonType type;
    union
    {
        struct json_object *object_value;
        char *string_value;
        bool bool_value;
        double num_value;
    };
};

struct json_object
{
    const char *key;
    struct json_value value;
    struct json_object *next;
};

typedef struct json_value JsonValue;
typedef struct json_object JsonObject;


JsonObject *newJsonObject(const char *key, JsonValue value);
void JsonObjectAdd(JsonObject *parent, const char *key, JsonValue value);
void JsonArrayAdd(JsonObject *parent, JsonValue value);
JsonObject *newJsonArray(JsonValue value);
// JsonValue *JsonObjectGet(JsonObject *parent, const char *key);
void printJsonObject(JsonObject *obj);

#endif