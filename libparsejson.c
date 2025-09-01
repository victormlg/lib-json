#include "libparsejson.h"

int ParseJson(const char *filename, JsonElement **root)
{
    extern FILE *yyin;
    yyin = fopen("input.json", "r");
    if (yyin == NULL) return -1;
    int ret = yyparse(root);

    fclose(yyin);

    return ret;
}

int ParseJsonFromString(const char *json_str, JsonElement **root)
{
    YY_BUFFER_STATE buf = yy_scan_string(json_str);
    int ret = yyparse(root);
    yy_delete_buffer(buf); 

    return ret;
}