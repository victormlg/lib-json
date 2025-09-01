// C and parser declarations

%code requires {
    #include <json.h>
}


%{
#include <json.h>
#include <stdio.h>
#include <stdlib.h>

void yyerror(JsonElement **root, const char *s);
int yylex(); 

struct pair {
    char *key;
    JsonElement *value;
};

struct pair *newPair(char *key, JsonElement *value)
{
    struct pair *p = (struct pair *) malloc(sizeof(struct pair));
    p->key = key;
    p->value = value;
    return p;
}
extern JsonElement *root;
%}

%union {
    char *string;
    struct pair *pair;
    JsonElement *element;
}

/* Bison declarations. */
%define parse.error verbose

%token <string> INT REAL STR
%token JSON_NULL JSON_TRUE JSON_FALSE

%type <element> value element object array members elements
%type <pair> member
%parse-param { JsonElement **root }

%% /* Grammar rules and actions follow. */

json:
%empty
| value { *root = $1; printf("end\n");};
;

object:
'{' members '}' { $$ = $2; }
;

array:
'[' elements ']' { $$ = $2; }
;

elements:
%empty { $$ = JsonObjectCreate(10); }
| element { $$ = JsonArrayCreate(10); JsonArrayAppendElement($$, $1); }
| elements ',' element { JsonArrayAppendElement($1, $3); $$ = $1; }
;

members:
%empty { $$ = JsonObjectCreate(10); }
| member { $$ = JsonObjectCreate(10); JsonObjectAppendElement($$, $1->key, $1->value); free($1); }
| members ',' member { JsonObjectAppendElement($1, $3->key, $3->value); $$ = $1; free($3); }
;

member:
STR ':' element { $$ = newPair($1, $3); }
;

element:
value
;

value:
object { $$ = $1; }
| array { $$ = $1; }
| JSON_NULL { $$ = JsonNullCreate(); }
| JSON_TRUE { $$ = JsonBoolCreate(true); }
| JSON_FALSE { $$ = JsonBoolCreate(false); }
| STR { $$ = JsonStringCreate($1); }
| REAL { $$ = JsonPrimitiveCreate(JSON_PRIMITIVE_TYPE_REAL, $1); }
| INT { $$ = JsonPrimitiveCreate(JSON_PRIMITIVE_TYPE_INTEGER, $1); }
;

%%

// C subroutines

void yyerror(JsonElement **root, const char *s) {
    fprintf(stderr, "Error: %s\n", s);
}

int yywrap() {
    return 1;
}
