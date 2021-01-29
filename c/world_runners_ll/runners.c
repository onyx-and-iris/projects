#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#define BUFF 32

typedef struct runner {
    char *name;
    int age;
    char *country;
    char *event;
    float pb;
    struct runner *next;
} runner;

runner *init();
void trimNewline( char * );
runner *createRecord( char * );
int getRecord( runner * );
void cleanup( runner * );

int writeToFile( runner * );
runner *readFromFile();

int main ( void ) {
    runner *_initialized = NULL;
    int numRecords = 0;

    _initialized = readFromFile();

    // if not readfromfile then initialize via user input
    if(!_initialized)
        _initialized = init();

    // run the entire linked list
    numRecords = getRecord( _initialized );

    printf("%d number of records in linked list\n", numRecords);

    if(writeToFile( _initialized ) == numRecords)
        fprintf(stdout, "%i records written succesfully\n", numRecords);

    // free memory
    cleanup( _initialized );

    return 0;
}

void trimNewline( char * str ) {
    int len = strlen(str);

    if( str[len-1] == '\n' ) str[len-1] = '\0';
}

runner *readFromFile() {
    runner *i = NULL;

    return i;
}

int writeToFile( runner * x ) {
    int count = 0;
    runner *i = NULL;
    FILE *records = fopen("records.dat", "wb");

    if(records != NULL) {
        for(i = x; x->next != NULL; i = i->next)
            if(fwrite(i, sizeof(*i), 1, records) == 1) {
                fprintf(stdout, "Written record for %s to file\n", i->name);

                ++count;                
            }

        fclose(records);
    } else {
        fprintf(stderr, "Error opening records.dat!\n");
    }

    return count;
}

runner *init() {
    char name[BUFF];
    runner *start = NULL;
    runner *next = NULL;
    runner *i = NULL;

    fprintf(stdout, "Please enter name of athlete:\n");
    for( ; fgets(name, BUFF, stdin) != NULL; i = next ) {
        trimNewline(name);
        next = createRecord( name );

        // on first run only start = first struct pointer returned
        if (start == NULL)
            start = next;
/*            
        subsequent runs i is previous record (stored at end
        of each loop).
        i->next is assigned struct pointer just returned from
        create record
*/
        if (i != NULL)
            i->next = next;
     
        fprintf(stdout, "Please enter name of athlete:\n");
    }

    return start;
}

runner *createRecord( char *name ) {
    int age;
    float pb;
    char country[BUFF];
    char event[BUFF];

    fprintf(stdout, "Creating record for %s:\n", name);
    // assign memory on heap for this record
    runner *x = malloc(sizeof(*x));

    // call to malloc, save to heap
    x->name = strdup(name);
 
    fprintf(stdout, "Age:\n");
    if( fscanf(stdin, "%i", &age) == 1 );
        x->age = age;
    // clear newline from stdin    
    fflush(stdin);

    fprintf(stdout, "Country:\n");
    fgets(country, BUFF, stdin);
    trimNewline(country);
    // call to malloc, save to heap
    x->country = strdup(country);

    fprintf(stdout, "Event:\n");
    fgets(event, BUFF, stdin);
    trimNewline(event);
    // call to malloc, save to heap
    x->event = strdup(event);

    fprintf(stdout, "PB:\n");
    if( fscanf(stdin, "%f", &pb) == 1)
        x->pb = pb;
    // clear newline from stdin 
    fflush(stdin);

    x->next = NULL;

    return x;
}

int getRecord( runner *x ) {
/*  
    start at passed pointer, until no further pointers
    each time set next to stored pointer to next struct
*/
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

    } while(next != NULL);

    return count;
}

void cleanup( runner *x ) {
    runner *i = NULL;
    runner *next = NULL;

    for(i = x; x->next != NULL; i = i->next) {
        next = i;

        free(i->name);
        free(i->country);
        free(i->event);

        free(i);
    }
}