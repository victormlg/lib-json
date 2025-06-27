#include <stdio.h>
#include "jsonparse.tab.h"
#include "jsonlib.h"

int main()
{
    extern json_t *root;
    extern FILE *yyin;
    yyin = fopen("input.txt", "r");
    if (yyin == NULL) return -1;
    return yyparse();
}