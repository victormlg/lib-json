
%{
    #include <stdlib.h>
    #include <stdio.h>
    #include <string.h>
    #include "jsonparse.tab.h"
%}


%%

^-?\d+(\.\d+)?([Ee]-?\d+)?$ { yylval.num = atof(yytext); return NUM; }
[ \t\n]+ {}
[\{\}\[\],:] { return yytext[0] ;} 
null { return JSON_NULL; }
true { return JSON_TRUE; }
false { return JSON_FALSE; }
\"[^\n\"]+\" { yylval.string = strdup(yytext); return STR; }

%%
