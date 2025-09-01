#include <json.h>
#include "jsonparse.tab.h"
#include <stdio.h>

int ParseJson(const char *filename, JsonElement **root)
{
    extern FILE *yyin;
    yyin = fopen("input.json", "r");
    if (yyin == NULL) return -1;
    int ret = yyparse(root);

    fclose(yyin);

    return ret;
}

int main()
{
    JsonElement *root = NULL;
    int ret = ParseJson("input.json", &root);

    if (ret == 0)
    {
        
        FILE *f = fopen("output.json", "w");
        Writer *w = FileWriter(f);

        JsonWrite(w, root, 0);

        FileWriterDetach(w);
        fclose(f);
    }
}