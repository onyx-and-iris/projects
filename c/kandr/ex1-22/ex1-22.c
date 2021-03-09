/********************************************************************************
    The C Programming Language, by
    Kernighan and Ritchie
    ISBN: 978-0131103627

    Q.Write a program to "fold" long input lines into two or more shorter
    lines after the last non-blank character that occurs before the n-th
    column of input. Make sure your program does something intelligent with
    very long lines, and if there are no blanks or tabs before the specified
    column.
********************************************************************************/

#include <stdio.h>

#ifndef DEBUG
#define WRAPMARGIN 80   /* old standard for coding. Still used a lot. */
#else
#define WRAPMARGIN 10   /* reduced for testing */
#endif /* DEBUG */

#define MAXLINE 1000    /* maximum length of input line */

int getline(char *, int);
int splitString(char *, int);

int main(void)
{
    int len; /* length of current line */
    char line[MAXLINE]; /* array for storing current line */

    while ((len = getline(line, MAXLINE)) > 0) /* there was a line */
        printf("New modified line:\n%s\n", line);

    return 0;
}

int getline(char s[], int lim)
{
    int c;      /* character read from stdin */
    int i, k;      /* counters */
    int hasBlank = 0;    /* check at least one blank character */

    k = 0;

    for (i = 0; i < lim-1 && (c = getchar()) != EOF && c != '\n'; ++i) {
        s[i] = c;

        ++k;
#ifdef DEBUG
        printf("Value of k=%d\n", k);
#endif /* DEBUG */
        
        if (s[i] == ' ')
            hasBlank = 1;

        if (k == WRAPMARGIN && hasBlank) {
#ifdef DEBUG
            printf("hasBlank = %d\n", hasBlank);
            printf("Passing i = %2d to splitString\n", i);
#endif /* DEBUG */
            k = 0;
            k += splitString(s, i);
#ifdef DEBUG
            printf("Value of k=%d\n", k);
#endif /* DEBUG */
        }
        else if(k == WRAPMARGIN) {
            k = 0;
            ++i;
            s[i] = '\n';
        }
    }

    if (c == '\n') {
        s[i] = c;
        ++i;
    }
    s[i] = '\0';

    return i;
}

int splitString(char string[], int index) 
{
    int i;  /* local counter */
    
    for(i = index; i >= 0; --i)
        if (string[i] == ' ') {
            string[i] = '\n';
            break;  /* stop after first blank reached */
        }

#ifdef DEBUG
    printf("%d character carried forward\n", (index - i) + 1);
#endif /* DEBUG */

    return (index - i) + 1;   /* carry the extra characters to next line */
}
