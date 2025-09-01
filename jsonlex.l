
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
-?[0-9]+ { yylval.string = strdup(yytext); return INT; }
-?[0-9]+(\.[0-9]+)?([Ee]-?[0-9]+)? { yylval.string = strdup(yytext); return REAL; }
\"[^\n\"]*\" {yytext[yyleng-1] = 0; yylval.string = strdup(yytext+1); return STR; }

%%
