#include "libparsejson.h"
#include <stdio.h>


int main()
{
    JsonElement *root = NULL;
    int ret = ParseJson("input.json", &root);

    if (ret != 0)
    {
        return ret;
    }
    
    FILE *f = fopen("output.json", "w");
    Writer *w = FileWriter(f);

    JsonWrite(w, root, 0);

    FileWriterDetach(w);
    fclose(f);

    JsonDestroy(root);
    
}