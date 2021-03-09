/********************************************************************************
    The C Programming Language, by
    Kernighan and Ritchie
    ISBN: 978-0131103627

    Q.Write a function reverse(s) that reverses the character string s. Use
    it to write a program that reverses its input a line at a time.
********************************************************************************/

#include <stdio.h>

#define MAXLINE 1000  

int getline(char *, int maxline);
void reverse(char *, char *, int len);

int main(void)
{
    int len;    /* current line length*/
    int c;	/* store each character from stdin */
    char line[MAXLINE];     /* current input line */
    char toPrint[MAXLINE];

    while ((len = getline(line, MAXLINE)) > 0) {
        if (line[len-1] != '\n')  /* test if we reached end of line */
            while ((c = getchar()) != EOF && c != '\n') 
                ++len;  /* count the actual length of the line */

    reverse(toPrint, line, len);

    if (len >= 0)    /* there was a line */
        printf("\nPRINTING BACK\nOriginal string:\n%s\nNew string:%s\n",line, toPrint); 
    }

    return 0;
}

/* getline: read a line into s, return length */
int getline(char s[], int lim)
{
    int c, i;

    for (i = 0; i < lim-1 && (c = getchar()) != EOF && c != '\n'; ++i) 
            s[i] = c;
    
    if (c == '\n') {
        s[i] = c;
        ++i;
    }
    s[i] = '\0';

    return i;
}

/* reverse function switching string from right to left -> left to right */
void reverse(char rtol[], char ltor[], int u)
{
    int i = 0;
    /* this assumes a newline character could create bug */
    while((rtol[(u-1)-i] = ltor[i]) != '\n') 
        ++i;

    rtol[u] = '\0';
}
