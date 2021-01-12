/********************************************************************************
    The C Programming Language, by
    Kernighan and Ritchie
    ISBN: 978-0131103627

    Q.Write a program that prints its input one word per line.
********************************************************************************/

#include <stdio.h>

int main (void)
{
    int nc, checked = 0;

    while((nc = getchar()) != EOF)
        if(nc == ' ' || nc == '\t') {
            if(!checked) {
                putchar('\n');
                checked = 1;
            }
        }
        else {
            putchar(nc);
            checked = 0;
        }
        
    return 0;
}
