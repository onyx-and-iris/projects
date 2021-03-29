#define H_RUNNERS_H

#include <stdio.h>
#include <stdlib.h>

#define BUFF 32

typedef struct runner {
    char *name;
    int age;
    char *country;
    char *event;
    float pb;
    struct runner *next;
} runner;

int write_to_file( runner * );
runner *read_from_file();

runner *init();
void trim_newline( char * );
runner *create_record( char * );
int get_record( runner * );
void cleanup( runner * );
