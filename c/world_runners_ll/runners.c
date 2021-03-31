#include "runners.h"

#ifndef H_RUNNERS_H
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#endif

/*
    1) if not readfromfile then initialize via user input
    2) run the entire linked list
    3) free memory
*/
int main ( void ) {
    runner *_initialized = NULL;
    int num_records = 0;

    _initialized = read_from_file();

    //1)
    if( !_initialized )
        _initialized = init();
    //2)
    num_records = get_record( _initialized );

    printf("%d records in linked list\n", num_records);

    if( write_to_file( _initialized ) == num_records )
        fprintf(stdout, "%i records written succesfully\n",
                        num_records);
    //3)
    cleanup( _initialized );

    return 0;
}

void trim_newline( char * str ) {
    int len = strlen(str);

    if( str[len-1] == '\n' ) str[len-1] = '\0';
}

/*
    1) first run only, start = initial struct pointer returned
    2) subsequent runs, i = previous record (stored at end
       of each loop).
       i->next is assigned struct pointer just returned from
       create record
*/
runner *init() {
    char name[BUFF];
    runner *start = NULL;
    runner *next = NULL;
    runner *i = NULL;

    fprintf(stdout, "Please enter name of athlete:\n");
    for( ; fgets(name, BUFF, stdin) != NULL; i = next ) {
        next = create_record( name );
        //1)
        if (start == NULL)
            start = next;
        //2)
        if (i != NULL)
            i->next = next;
     
        fprintf(stdout, "Please enter name of athlete: (^Z->enter to exit)\n");
    }

    return start;
}

/*
    *) strdup: call to malloc, save to heap
    *) getchar() used to consume newline
*/
runner *create_record( char *name ) {
    int age;
    float pb;
    int len = 0;
    char country[BUFF];
    char event[BUFF];
    runner *x = malloc(sizeof(*x));

    x->name = strdup(name);
    trim_newline(x->name);
    fprintf(stdout, "Creating record for %s:\n", x->name);

    fprintf(stdout, "Age:\n");
    if( fscanf(stdin, "%i", &age) == 1 )
        x->age = age;
    getchar();

    fprintf(stdout, "Country:\n");
    fgets(country, BUFF, stdin);
    trim_newline(country);
    x->country = strdup(country);

    fprintf(stdout, "Event:\n");
    fgets(event, BUFF, stdin);
    trim_newline(event);
    x->event = strdup(event);

    fprintf(stdout, "PB:\n");
    if( fscanf(stdin, "%f", &pb) == 1 )
        x->pb = pb;
    getchar();

    x->next = NULL;

    return x;
}

/*
    1) start at passed pointer, until no further pointers
       each time set next to stored pointer to next struct
*/
int get_record( runner *x ) {
    //1)
    runner *i = x;
    runner *next = NULL;
    int count = 0;

    do {
        next = i->next;

        fprintf(stdout, "=================\n");
        fprintf(stdout, "GETTING RECORDS FOR %s\n", i->name);
        fprintf(stdout, "=================\n");
        fprintf(stdout, "age:%i\ncountry:%s\nevents:%s\n"
        "pb:%.2f\n", i->age, i->country, i->event, i->pb);

        ++count;

        i = next;

    } while( next != NULL );

    return count;
}

void cleanup( runner *x ) {
    runner *i = NULL;
    runner *next = NULL;

    for( i = x; x->next != NULL; i = i->next ) {
        next = i;

        free(i->name);
        free(i->country);
        free(i->event);

        free(i);
    }
}
