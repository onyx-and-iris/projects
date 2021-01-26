#include <stdio.h>

typedef struct { 
    char *name; 
    char *country;
    int age; 
    char *event; 
    float pb; 
} athlete;

void getStats( athlete *x );
int writeRecord( athlete *x, FILE *records );
int readRecord( athlete *x, FILE *records );