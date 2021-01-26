#include <getopt.h>
#include <stdlib.h>
#include <string.h>
#include "functions.h"

#define OPTSTR "ngu:"

#define N 1
#define BUFF 32

int updStat( athlete *x, int upd );
void addRecord( athlete *x );
int readAllRecords ( athlete *x, FILE *records ); 

int main( int argc, char *argv[] ) { 
    int opt;
    int i = 0;
    int upd = 0;
    // *runner over athlete for better form. no need to cast.
    athlete *runner = malloc(N * sizeof(*runner)); 
    // initialize file pointer
    FILE *records = NULL;

    // Initialise struct elements
    for(i = 0; i < N; i++) {
        runner[i].name = (char *)malloc(BUFF * sizeof(char)); 
        runner[i].country = (char *)malloc(BUFF * sizeof(char));
        runner[i].age = 0;
        runner[i].event = (char *)malloc(BUFF * sizeof(char));
        runner[i].pb = 0;
    }

    while ((opt = getopt(argc, argv, OPTSTR)) != EOF) {
        switch(opt) {
            // new record
            case 'n':
                for(i = 0; i < N; i++) {
                    fprintf(stdout, "Setting details for athlete %i\n", i);
                    addRecord( &runner[i] );
                    fprintf(stdout, "Getting details for athlete %i\n", i);

                    // write to and then read from file
                    writeRecord ( &runner[i], records );
                    readRecord ( &runner[i], records );
                }

                break;
            // get stats
            case 'g': 
                fprintf(stdout, "Get stats:\n");
                readAllRecords( &runner[i], records );
                
                break;
            // update age
            case 'u':
                upd = atoi(optarg);
                fprintf(stdout, "Age updated to:%i\n", updStat( &runner[i] , upd ));

                break;

            default:
                fprintf(stdout, "ERROR options available: %s", OPTSTR);
        }
    }
    
    // free up memory
    for(i = 0; i < N; i++) {
        free((char *)runner[i].name);
        free((char *)runner[i].country);
        free((char *)runner[i].event);
    }    

    free(runner);

    return 0;
} 

int updStat( athlete *x, int upd ) { 
    fprintf(stdout, "Age before: %i\n", x->age);
    x->age = x->age + upd;
    return x->age;
}  

void addRecord( athlete *x ) {
    int age;
    float pb;
    char line[BUFF];
    size_t l_size = BUFF;

    fprintf(stdout, "Please enter athlete name:\n");
    getline(&x->name, &l_size, stdin);
    fflush(stdin);

    fprintf(stdout, "Please enter athlete country:\n");
    getline(&x->country, &l_size, stdin);
    fflush(stdin);

    fprintf(stdout, "Please enter athlete age:\n");
    if(fscanf(stdin, "%i", &age) == 1)
        x->age = age;
    fflush(stdin);

    fprintf(stdout, "Please enter athlete event:\n");
    getline(&x->event, &l_size, stdin);
    fflush(stdin);

    fprintf(stdout, "Please enter athlete pb:\n");
    if(fscanf(stdin, "%f", &pb) == 1)
        x->pb = pb;
    fflush(stdin);

    free(line);
}

int readAllRecords ( athlete *x, FILE *records ) {
    records = fopen("records", "rb");    
    rewind(records);

    while (1) {
        fread(x, sizeof(x), 1, records);

        fprintf(stdout, "Name of athlete: %s\nCountry: %s\n"
    "Age of athlete: %i\n\nMain event: %s\n" 
    "PB:%.2f\n", x->name, x->country, x->age, x->event,  x->pb);

        if (feof(records))
            break;

        fclose(records);
    }

    return 0;
}