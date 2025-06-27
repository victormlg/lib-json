
%{
    #include <stdlib.h>
    #include <stdio.h>
    #include "jsonparse.tab.h"
%}


%%

^-?\d+(\.\d+)?([Ee]-?\d+)?$ { yylval = to_number(yytext); return NUM; }
[ \t\n]+ {}
[\{\}\[\],:] { return yytext[0] ;} 
null { return JSON_NULL; }
true { return JSON_TRUE; }
false { return JSON_FALSE; }
\"[^\n\"]+\" { yylval = from_string(yytext); return STR; }
<<EOF>> { static int once = 0; return once++ ? 0 : '\n'; }

%%
