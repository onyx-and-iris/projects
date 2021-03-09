/********************************************************************************
    The C Programming Language, by
    Kernighan and Ritchie
    ISBN: 978-0131103627

    Q.Write a program to print all input lines that are longer than 80
    characters.
********************************************************************************/

#include <stdio.h>

#define MAXLINE 1000  
#define MINPRINT 80   /* only print lines this length or longer */

int getline(char *, int maxline);

int main(void)
{
    int len;    /* current line length*/
    int c;	/* store each character from stdin */
    char line[MAXLINE];     /* current input line */

    while ((len = getline(line, MAXLINE)) > 0) {
        if (line[len-1] != '\n')  /* test if we reached end of line */
            while ((c=getchar()) != EOF && c != '\n') 
                ++len;  /* count the actual length of the line */

        if (len >= MINPRINT)    /* there was a line at least 80 characters long */
            printf("Printing back:\n%s\nLength of line:\n%d\n",line, len); 
    }

    return 0;
}

/* getline: read a line into s, return length */
int getline(char s[], int lim)
{
    int c, i;

    for (i=0; i < lim-1 && (c=getchar()) != EOF && c != '\n'; ++i)
        s[i] = c;
    if (c == '\n') {
        s[i] = c;
        ++i;
    }
    s[i] = '\0';

    return i;
}
