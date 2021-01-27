#define RUNNERS_H

#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#define N 2
#define BUFF 32

#define OPTSTR "ng"

typedef struct {
//    char *name;
//    char *country;
    char name[BUFF];
    int age;
    char country[BUFF];
    char event[BUFF];
    float pb;
} athlete;

// data functions
void purge ( athlete * );
void getStats ( athlete * );
void addRecord( athlete * );
// file operation functions
void writeToFile( athlete *, FILE * );
void readFromFile( athlete *, FILE * );