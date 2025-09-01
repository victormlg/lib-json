#include <json.h>

int main()
{
    JsonElement *e = JsonBoolCreate(true);
    if (e != NULL)
    {
        printf("Hello world!\n");
    }
}