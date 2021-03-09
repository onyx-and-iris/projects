/********************************************************************************
    The C Programming Language, by
    Kernighan and Ritchie
    ISBN: 978-0131103627

    Q.Write a program to copy its input to its output, replacing each
    string of one or more blanks by a single blank.
********************************************************************************/

#include <stdio.h>

int main(void)
{
    int c, isBlank = 0;

    while ((c = getchar()) != EOF)
        if (c == ' ') {      /* check for blank character. */
            if (!isBlank) {	    /*NOTE: this IF clause is the same as if(isBlank ==0)*/
                putchar(c);
                isBlank = 1;  	/* to notify 1 blank registered for next character check. */
            }                   
        }
        else {       /* runs this if NOT a blank character. */
            putchar(c);
            isBlank = 0;
        }

    return 0;
}
