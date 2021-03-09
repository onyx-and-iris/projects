/********************************************************************************
    The C Programming Language, by
    Kernighan and Ritchie
    ISBN: 978-0131103627

    Q.Modify the temperature conversion program to print a heading above
    the table.
********************************************************************************/

#include <stdio.h>

int main(void)
{
    float fahr, celsius;
    int limitLower, limitHigher, increment;

    limitLower = 0;
    limitHigher = 300;
    increment = 20;

    fahr = limitLower;

    printf("Fahrenheit to Celsius converter from %d degrees to %d degrees\n", limitLower, limitHigher);
    printf("=============================================================\n\n");

    while(fahr <= limitHigher) {
        celsius = 5.0/9.0*(fahr - 32.0);

        printf("%3.0f %6.1f\n", fahr, celsius);

        fahr += increment;
    }

    return 0;
}
