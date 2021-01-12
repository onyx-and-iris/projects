/********************************************************************************
    The C Programming Language, by
    Kernighan and Ritchie
    ISBN: 978-0131103627

    Q.Modify the temperature conversion program to print the table in
    reverse order.
********************************************************************************/

#include <stdio.h>

int main(void)
{
    float fahr;

    for(fahr = 300; fahr >=0; fahr -= 20)
        printf("%3.0f %6.1f\n", fahr, (5.0/9.0)*(fahr-32.0));

    return 0;
}

