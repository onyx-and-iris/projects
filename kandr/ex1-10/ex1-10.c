/********************************************************************************
    The C Programming Language, by
    Kernighan and Ritchie
    ISBN: 978-0131103627

    Q.Write a program to copy its input to its ouput, replacing each tab by
    \t, each backspace by \b and each backslash by \\.
********************************************************************************/

#include <stdio.h>

int main(void)
{
    int c;

    while((c = getchar()) != EOF) {
        if(c == '\t')
            printf("\\t");
        else if(c == '\b')
            printf("\\b");
        else if(c == '\\')
            printf("\\\\");
        else
            printf("%c",c);
    }

    return 0;
}
