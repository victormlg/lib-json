#include <stdio.h>
#include "jsonparse.tab.h"
// #include "jsonlib.h"

int main()
{
    // extern JsonObject *root;
    extern FILE *yyin;
    yyin = fopen("input.json", "r");
    if (yyin == NULL) return -1;
    return yyparse();
}