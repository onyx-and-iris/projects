/********************************************************************************
    The C Programming Language, by
    Kernighan and Ritchie
    ISBN: 978-0131103627

    Q.Write a program entab that replaces strings of blanks by the minimum
    number of tabs and blanks to achieve the same spacing. Use the same tab
	stops as for detab.
********************************************************************************/

#include <stdio.h>

#define TABINTERVAL 4 /* interval of each TAB occurance */ 
#define MAXLINE 1000 /* max length of line */
#define INBLANK 1 /* in a blank string */
#define OUTBLANK 0 /* out of a blank string */

int getline(char *, int maxline);
int convertBlankString(char *, int, int);

int numBlanks = 0;

int main(void)
{
    int len; /* length of current line */
    char line[MAXLINE]; /* array for storing current line */

    printf("========================================\n");
    printf("Working with a tab interval of %d spaces\n", TABINTERVAL);
    printf("========================================\n");

    while ((len = getline(line, MAXLINE)) > 0) /* there was a line */
        printf("New modified line:%s\n", line);

    printf("***************************************\n");

    return 0;
}

int getline(char s[], int lim)
{
    int c, d = 0; /* c = character read from stdin, d = buffer to store c in event convert func called */
    int i,j = 1; /* counters */
    int state = OUTBLANK;
    extern int numBlanks;

    for (i = 0; i < lim-1 && (c = getchar()) != EOF && c != '\n'; ++i) {
        s[i] = c;
#ifdef DEBUG                
        printf("Adding letter:%c to the string\n", c);
#endif /* DEBUG */      
        if (s[i] == ' ' && s[i-1] == ' ') {
            state = INBLANK;
            ++j;
        }
        else if(state == INBLANK) {
            d = s[i];
            state = OUTBLANK;
            numBlanks = j;
            j = 0;
        }
        else
            state = OUTBLANK;
#ifdef DEBUG        
        printf("After the check; i = %d\n", i);
        printf("state = %d\n", state);
        printf("==================================\n");
#endif /* DEBUG */
        if(state == OUTBLANK && numBlanks > 0) { /* there was actually a blank string */
            printf("There were %d blanks\n", numBlanks);
            i = convertBlankString(s, i, d);
        }
    }
                            
    if (c == '\n') {
        s[i] = c;
        ++i;
    }
    s[i] = '\0';
    
    return i;
}

int convertBlankString(char string[], int index, int charbuffer)
{
    int tabsNeeded = 0;
    int blanksNeeded = 0;
    int j;
    extern int numBlanks;

    tabsNeeded = numBlanks/TABINTERVAL; /* integer arithmetic will truncate remainder */
    blanksNeeded = numBlanks%TABINTERVAL; /* calculate remainder */
    index = index-numBlanks; /* step back the number of blanks that were given */
    numBlanks = 0; /* reset for the next blank string */

    printf("We will need %d TABS and %d BLANKS\n", tabsNeeded, blanksNeeded);
#ifdef DEBUG
    printf("The value of i = %2d\n", index);
#endif /* DEBUG */
    for(j = 0; j < tabsNeeded; ++j) {
        string[index] = '\t';
        ++index;
#ifdef DEBUG
        printf("Added a TAB and added one to i\n");
        printf("The value of i = %2d\n", index);
#endif /* DEBUG */
    }
    for(j = 0; j< blanksNeeded; ++j) {
        string[index] = ' ';
        ++index;
#ifdef DEBUG
        printf("Added a BLANK and added one to i\n");
        printf("The value of i = %2d\n", index);
#endif /* DEBUG */
    }
    
    string[index] = charbuffer;
#ifdef DEBUG    
    printf("==================================\n");   
    printf("Adding letter:%c to the string\n", charbuffer);
    printf("The value of i = %2d\n", index);
#endif /* DEBUG */
    return index;
}
