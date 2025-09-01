#include "libparsejson.h"
#include <stdio.h>


int main()
{
    JsonElement *root = NULL;
    int ret = ParseJsonFromString("{ \"hello\" : 1 }", &root);

    if (ret == 0)
    {
        
        FILE *f = fopen("output.json", "w");
        Writer *w = FileWriter(f);

        JsonWrite(w, root, 0);

        FileWriterDetach(w);
        fclose(f);

        JsonDestroy(root);
    }
}