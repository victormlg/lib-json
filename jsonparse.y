// C and parser declarations

%code requires {
    #include "jsonlib.h"
}


%{
#include "jsonlib.h"
#include <stdio.h>
#include <stdlib.h>

void yyerror (char const *s);
int yylex(); 

struct pair {
    char *key;
    JsonValue value;
};

struct pair *newPair(char *key, JsonValue value)
{
    struct pair *p = (struct pair *) malloc(sizeof(struct pair));
    p->key = key;
    p->value = value;
    return p;
}
%}

%union {
    double num;
    char *string;
    JsonValue value;
    struct pair *pair;
    JsonObject *object;
}

/* Bison declarations. */
%define parse.error verbose

%token <num> NUM
%token <string> STR
%token JSON_NULL JSON_TRUE JSON_FALSE

%type <value> value element
%type <pair> member
%type <object> object array members elements

%% /* Grammar rules and actions follow. */

json:
%empty
| value { printf("json\n"); }
;

object:
'{' members '}' { $$ = $2; printf("object\n"); }
;

array:
'[' elements ']' { $$ = $2; printf("array\n"); }
;

elements:
%empty { $$ = newJsonArray((JsonValue){0}); printf("elements:1\n");}
| element { $$ = newJsonArray($1); printf("elements:2\n");}
| elements ',' element { JsonArrayAdd($1, $3); printf("elements:3\n");}
;

members:
%empty
    { $$ = newJsonObject(NULL, (JsonValue){0}); printf("members:1\n");}
| member
    {
        $$ = newJsonObject($1->key, $1->value); 
        free($1);
        printf("members:2\n");
    }
| members ',' member
    {
        JsonObjectAdd($1, $3->key, $3->value);
        free($1);
        printf("members:3\n");
    }
;

member:
STR ':' element { $$ = newPair($1, $3); printf("member:1\n");}
;

element:
value { printf("element\n");}
;

value:
object { $$ = (JsonValue){ .type = JSON_TYPE_OBJECT, .object_value = $1 }; printf("val-object\n"); }
| array { $$ = (JsonValue){ .type = JSON_TYPE_ARRAY, .object_value = $1 }; printf("val-array\n"); }
| JSON_NULL { $$ = (JsonValue){ .type = JSON_TYPE_NULL, .object_value = NULL }; printf("val-null\n"); }
| JSON_TRUE { $$ = (JsonValue){ .type = JSON_TYPE_BOOLEAN, .bool_value = true }; printf("val-true\n"); }
| JSON_FALSE { $$ = (JsonValue){ .type = JSON_TYPE_BOOLEAN, .bool_value = false }; printf("val-false\n"); }
| STR { $$ = (JsonValue){ .type = JSON_TYPE_STRING, .string_value = $1 }; printf("val-str\n"); }
| NUM { $$ = (JsonValue){ .type = JSON_TYPE_NUMBER, .num_value = $1 }; printf("val-num\n"); }
;

%%

// C subroutines

void yyerror (char const *s) /* Called by yyparse on error */
{
    printf("%s\n", s);
}

int yywrap() {
    return 1;
}
