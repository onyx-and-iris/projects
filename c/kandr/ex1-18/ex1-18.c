/********************************************************************************
    The C Programming Language, by
    Kernighan and Ritchie
    ISBN: 978-0131103627

    Q.Write a program to remove trailing blanks and tabs from each line of
    input, and to delete entirely blank lines.
********************************************************************************/

/* note. needs rewriting, not a good solution to problem! */
#include <stdio.h>

#define MAXLINE 1000  /* reduced for testing */
#define ISBLANK 1
#define NOTBLANK 0
#define ISNEWLINE 2

int getline(char *, int *, int maxline);
void copy(char *, char *, int i);
int printUntil(int *, int len);

int main(void)
{
    int len;    /* current line length*/
    int c,newLen;
    char line[MAXLINE];     /* current input line */
    char toPrint[MAXLINE];
    int isChar[MAXLINE];

    while ((len = getline(line, isChar, MAXLINE)) > 0) {
        if (line[len-1]!='\n')  /* test if we reached end of line */
            while ((c=getchar()) != EOF && c != '\n') 
                ++len;  /* count the actual length of the line */

        newLen = printUntil(isChar, len);
        copy(toPrint, line, newLen);

        if (len > 0)    /* there was a line (and it's not just blanks) */
            printf("\nPrinting back:\n%s\nOriginal length of line:\n%d\n",toPrint, len+1);
	    printf("New length of line:\n%d\n", newLen+1); 
            /* Prints without trailing tabs and spaces  */
    }

    return 0;
}

/* getline: read a line into s, return length */
int getline(char s[], int b[], int lim)
{
    int c, i;
    int isBlankLine = 1;

    for (i=0; i<lim-1 && (c=getchar())!=EOF && c!='\n'; ++i) {
            s[i] = c;
        if(s[i] == ' ' || s[i] == '\t') 
            b[i] = ISBLANK; /* is a blank or tab */
        else {
            isBlankLine = 0; /* test for at least one character */
        }
    }
    
    if (c == '\n') {
        s[i] = c;
        b[i] = ISNEWLINE; /* is a newline */
        ++i;
    }
    s[i] = '\0';

    if(!isBlankLine)
        return i;
    else
        return 0;
}

/* copy: copy 'from' into 'to'; assume to is big enough */
void copy(char to[], char from[], int u)
{
    int i;

    for (i = 0; i < u; ++i) 
        to[i] = from[i];

    to[u] = '\0';
}

/* calculate values for copy function, todo:fix adding blanks back */
int printUntil(int b[], int l)
{
    int i,j = 0;
#ifdef DEBUG
    printf("===============================================\n");    
#endif /* DEBUG */
    for (i = (l-1);b[i] == ISBLANK || b[i] == ISNEWLINE; --i){
	if(b[i] == ISNEWLINE) {
#ifdef DEBUG
            printf("There was a newline character\n"); 
#endif /* DEBUG */
	} else
	       ++j;
    }
#ifdef DEBUG
    printf("Number of blanks or tabs at end of string: %d ", j);
#endif /* DEBUG */
    return i + 1; 
}
