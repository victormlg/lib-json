
%{
    #include <stdlib.h>
    #include <stdio.h>
    #include <string.h>
    #include "jsonparse.tab.h"
%}


%%
[ \t\n]+ {}
[\{\}\[\],:\"] { return yytext[0] ;} 
null { return JSON_NULL; }
true { return JSON_TRUE; }
false { return JSON_FALSE; }
\"[^\n\"]*\" {
    yytext[yyleng-1] = 0;
    yylval.string = strdup(yytext+1);
    printf("str\n");
    return STR;
    }
-?\d+ { yylval.string = strdup(yytext); printf("int\n"); return INT; }
-?\d+(\.\d+)([Ee]-?\d+)? { yylval.string = strdup(yytext); printf("real\n"); return REAL; }

%%
