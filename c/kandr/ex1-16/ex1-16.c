/********************************************************************************
    The C Programming Language, by
    Kernighan and Ritchie
    ISBN: 978-0131103627

    Q.Revise the main routine of the longest line program so it will 
    correctly print the length of arbitrarily long input lines, and as much
    as possible of the text.
********************************************************************************/

#include <stdio.h>

#define MAXLINE 20  /* reduced for testing */

int getline(char *, int maxline);
void copy(char *, char *);

int main(void)
{
    int len;    /* current line length*/
    int max;    /* maximum length seen so far */
    int c, j;
    char line[MAXLINE];     /* current input line */
    char longest[MAXLINE];  /* longest line saved here */

    max = j = 0;

    while ((len = getline(line, MAXLINE)) > 0) {
        if (line[len-1] != '\n')  /* test if we reached end of line */
            while ((c = getchar()) != EOF && c != '\n') 
                ++len;  /* count the actual length of the line */

        if (len > max) {
            max = len;
            copy(longest, line);
        }
        ++j;
     }

    if (max > 0)    /* there was a line */
        printf("\nLongest line:\nnumber %d\nCharacters up to maxline:\n%s\nLength of line:\n%d\n", j, longest, max); /* counts full characters but prints only to MAXLINE */

    return 0;
}

/* getline: read a line into s, return length */
int getline(char s[], int lim)
{
    int c, i;

    for (i = 0; i < lim-1 && (c=getchar()) != EOF && c != '\n'; ++i)
        s[i] = c;
    if (c == '\n') {
        s[i] = c;
        ++i;
    }
    s[i] = '\0';

    return i;
}

/* copy: copy 'from' into 'to'; assume to is big enough */
void copy(char to[], char from[])
{
    int i = 0;

    while ((to[i] = from[i]) != '\0')
        ++i;
}
