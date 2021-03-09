/********************************************************************************
    The C Programming Language, by
    Kernighan and Ritchie
    ISBN: 978-0131103627

    Q.Verify that the expression getchar() != EOF is 0 or 1.
********************************************************************************/

#include <stdio.h>

int main(void)
{
    int v, checked = 0;

    while(v = (getchar() != EOF)) 
        printf("The value of EOF while character input= %d\n", v);

    printf("The value of EOF when EOF signal sent:%d\n", v); 

    return 0;
}
