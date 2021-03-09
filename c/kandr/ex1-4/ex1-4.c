/********************************************************************************
    The C Programming Language, by
    Kernighan and Ritchie
    ISBN: 978-0131103627

    Q.Write a program to print the corresponding Celsius to Fahreheit
    table.
********************************************************************************/

/* We know already that C = 5/9*(F-32), then simple arithmetic tells us that
F = (9C/5) + 32.
*/

#include <stdio.h>

int main(void)
{
    float celsius, fahr;
    int limitLower, limitUpper, increment;

    limitLower = 0;
    limitUpper = 300;
    increment = 20;

    celsius = limitLower;

    while(celsius <= limitUpper) {
        fahr = (9.0/5.0)*celsius + 32.0;

        printf("%3.0f %6.1f\n", celsius, fahr);

        celsius += increment;
    }

    return 0;
}
