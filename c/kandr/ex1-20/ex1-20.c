/********************************************************************************
    The C Programming Language, by
    Kernighan and Ritchie
    ISBN: 978-0131103627

    Q.Write a program detab that replaces tabs in the input with the proper
    number of blanks to space to the next tab stop. Assume a fixed set of
    tab stops, say every n columns.
********************************************************************************/

#include <stdio.h>

#define TABINTERVAL 4 /* interval of each TAB occurance */ 
#define MAXLINE 1000 /* max length of line */

int getline(char *, int maxline);
int tab2space(char *, int);

int main(void)
{
    int len, i; /* length of current line */
    char line[MAXLINE]; /* array for storing current line */

    while ((len = getline(line, MAXLINE)) > 0) {
        printf("                  ");
        for(i=0;i<5;i++)
            printf("^   ");
        printf("\n");
        printf("New modified line:%s", line);
    }

    return 0;
}

int getline(char s[], int lim)
{
    int c, i; /* c = character read from stdin, i = counter */
        
    for (i = 0; i < lim-1 && (c = getchar()) != EOF && c != '\n'; ++i) {
        s[i] = c;
        i = tab2space(s, i);
#ifdef DEBUG
        printf("After the check; i = %d\n", i);
#endif /* DEBUG */
    }
                            
    if (c == '\n') {
        s[i] = c;
        ++i;
    }
    s[i] = '\0';
                                                   
    return i;
}

/* copy: copy 'from' into 'to'; assume to is big enough */
int tab2space(char s[], int i)
{
    int j; /* counter */
    int modulus = 0; /* divide i by tabinterval to find out how much past last interval we went */
    int spaceToMove = 0; /* then move forward by tabinterval minus the remainder */
       
    if (s[i] == '\t') {
        modulus = (i+1)%TABINTERVAL; /* because i starts at 0 */
        spaceToMove = (TABINTERVAL - modulus);

#ifdef DEBUG
        printf("Tab found; i = %d (variable number: %d)\n", i, i+1);
        printf("The modulus of i to tabinterval is: %2d\n", modulus);
        printf("Therefore we must move %d spaces forward\n", spaceToMove);
        printf("First replace the TAB with BLANK\n");
#endif /* DEBUG */

        s[i] = ' ';
        for(j = 0; j < spaceToMove; ++j) {
            ++i;
            s[i] = ' ';

#ifdef DEBUG
            printf("Just added one to i and filled with BLANK; i = %d (variable number: %d)\n", i, i+1);
#endif /* DEBUG */
        }
    }

    return i; /* keeping track of current line subscript */
}
