/********************************************************************************
    The C Programming Language, by
    Kernighan and Ritchie
    ISBN: 978-0131103627

    Q.Rewrite the temperature conversion program of to use a function for
    conversion.
********************************************************************************/

#include <stdio.h>

#define UPPER 300
#define STEP 20

float conversion(int);

int main(void)
{ 
   int fahr;
   
   for(fahr = 0; fahr <= UPPER; fahr += STEP)
       printf("%3d\t%5.1f\n", fahr, conversion(fahr));

   return 0;
}

float conversion(f)
{
    return (5.0/9.0)*(f-32.0);   /* note. arithmetic expression converts int f to float f. */
}
