#include "stdbool.h"
#include <stdint.h>

enum number {
    INTEGER,
    FLOAT,
    DOUBLE,
    LONG_DOUBLE
};

typedef struct 
{
    enum number type;
    union {
        int64_t i; 
        float f;
        double d; 
        long double ld;
    };
} number_t;

typedef enum {
    JSON_TRUE,
    JSON_FALSE,
    JSON_NULL
} primitive_t;

enum json_types {
    NUMBER,
    STRING,
    PRIMITIVE,
    OBJECT,
    ARRAY
};

union json_values
{
    number_t n;
    primitive_t p;
    char *s;
    json_t *next;
};

typedef struct {
    char *key;
    enum json_types type;
    union json_values value;
} json_t;


number_t to_number(char *s);

json_t create_json();