#define H_RUNNERS_H

#include <stdio.h>

#define BUFF 32

typedef struct runner {
    char *name;
    int age;
    char *country;
    char *event;
    float pb;
    struct runner *next;
} runner;

int writeToFile( runner * );
runner *readFromFile();

runner *init();
void trimNewline( char * );
runner *createRecord( char * );
int getRecord( runner * );
void cleanup( runner * );