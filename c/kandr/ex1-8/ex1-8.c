/********************************************************************************
    The C Programming Language, by
    Kernighan and Ritchie
    ISBN: 978-0131103627

    Q.Write a program to count blanks, tabs and newlines.
********************************************************************************/

#include <stdio.h>

int main(void)
{
    int c, blank, tabs, newlines;

    blank = tabs = newlines = 0;

    while((c = getchar()) != EOF) {
        if(c == ' ')
            ++blank;
        if(c == '\t')
            ++tabs;
        if(c == '\n')
            ++newlines;
    }

    printf("Number of blank characters = %d\n", blank);
    printf("Number of tabs characters = %d\n", tabs);
    printf("Number of newlines characters = %d\n", newlines);

    return 0;
}
