// C and parser declarations


%{
#include <stdio.h>
#include <jsonlib.h>
void yyerror (char const *s);
int yylex(); 
%}

/* Bison declarations. */
%define api.value.type {json_t}
%define parse.error verbose
%token NUM, STR, JSON_NULL, JSON_TRUE, JSON_FALSE

%% /* Grammar rules and actions follow. */

json:
%empty
value { root = $1; }

object:
'{' members '}'
;

array:
'[' elements ']'
;

elements:
%empty
| element
| element ',' elements

members:
%empty
| member
| member ',' members
;

member:
STR ':' element
;

element:
value
;

value:
object
| array
| JSON_NULL
| JSON_TRUE
| JSON_FALSE
| STR
| NUM
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