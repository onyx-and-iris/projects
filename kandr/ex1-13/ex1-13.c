/********************************************************************************
    The C Programming Language, by
    Kernighan and Ritchie
    ISBN: 978-0131103627

    Q.Write a program to print a histogram of the lengths of words in its
    input.
********************************************************************************/

#include <stdio.h>

#define MAX_WORD 10
#define IN_WORD 1
#define OUT_WORD 0

int main(void)
{
    int c, i, j, count, state;
    int lengthofWord[MAX_WORD];

    c = i = j = count = 0;
    state = OUT_WORD;

    for(i=0; i<MAX_WORD; ++i)
        lengthofWord[i] = 0;

    while((c = getchar()) != EOF) {
        if((c >= 'a' && c <= 'z') || (c >= 'A' && c <= 'Z')) {
            if(state == OUT_WORD) {
                count = 0;
                state = IN_WORD;
            }
            ++count;
        }
        else if(state == IN_WORD) {
                state = OUT_WORD;
                ++lengthofWord[count - 1];
            }
    }
    /* HORIZONTAL */
    for(i=0; i<MAX_WORD; i++) {
        printf("%2d \t", i+1);

        for(j=0; j<lengthofWord[i]; j++)
            putchar('=');

        putchar('\n');
    }

    return 0;
}
