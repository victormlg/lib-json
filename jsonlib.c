#include "jsonlib.h"
#include <stdlib.h>
#include <string.h>
#include <stdio.h>

JsonObject *newJsonObject(const char *key, JsonValue value)
{
    JsonObject *object = (JsonObject *) malloc(sizeof(JsonObject));
    object->key = key;
    object->value = value;
    return object;
}

void JsonObjectAdd(JsonObject *parent, const char *key, JsonValue value)
{
    JsonObject *new = newJsonObject(key, value);
    new->key = key;
    new->value = value;

    JsonObject *tmp = parent;
    while (tmp->next != NULL && strcmp(tmp->key, key) != 0)
    {
        tmp = tmp->next;
    }
    tmp->next = new;

}

void JsonArrayAdd(JsonObject *parent, JsonValue value)
{
    JsonObjectAdd(parent, NULL, value);
}

JsonObject *newJsonArray(JsonValue value)
{
    return newJsonObject(NULL, value);
}

// JsonValue JsonObjectGet(JsonObject *parent, const char *key)
// {
//     JsonObject *tmp = parent;
//     while (tmp != NULL && strcmp(tmp->key, key) != 0)
//     {
//         tmp = tmp->next;
//     }
//     return tmp.value;
// }

void printJsonObject(JsonObject *obj)
{
    // if (obj->key != NULL)
    // {
    //     printf("(key: %s, ", obj->key);
    // }
    // else
    // {
    //     printf("(");
    // }

    // printf("value: ");

    // switch (obj->value.type)
    // {
    // case JSON_TYPE_ARRAY:
    //     printJsonObject(obj->value.object_value);
    //     break;
    // case JSON_TYPE_OBJECT:
    //     printJsonObject(obj->value.object_value);
    //     break;
    // case JSON_TYPE_BOOLEAN:
    //     printf("true)\n");
    //     break;
    // case JSON_TYPE_STRING:
    //     printf("%s)\n", obj->value.string_value);
    //     break;
    // case JSON_TYPE_NULL:
    //     printf("null)\n");
    //     break;
    // case JSON_TYPE_NUMBER:
    //     printf("%lf)\n", obj->value.num_value);
    //     break;
    
    // default:
    //     break;
    // }
    // printJsonObject(obj->next);
}