#include <stdio.h>
#include <getopt.h>
#include <stdlib.h>
#include <string.h>

#define OPTSTR "ngu"

#define N 1
#define BUFF 32
 
typedef struct { 
    char *name; 
    char *country;
    int age; 
    char *event; 
    int pb; 
} athlete;

void getStats( athlete *x );
int updStat( athlete *x, int upd );
void addRecord( athlete *x );

int main( int argc, char *argv[] ) { 
    int opt;
    int i, j, k, l, m = 0;
    int upd = 0;
    athlete *runner;

    runner = (athlete *)malloc(N * sizeof(athlete));

    // Initialise structs
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
                for(j = 0; j < N; j++) {
                    fprintf(stdout, "Setting details for athlete %i\n", j);
                    addRecord( &runner[j] );
                    fprintf(stdout, "Getting details for athlete %i\n", j);
                    getStats( &runner[j] );
                }

                break;
            // get stats
            case 'g': 
                fprintf(stdout, "Get stats:\n");
                for(k = 0; k < N; k++) 
                    getStats( &runner[k] );

                break;
            // update age
            case 'u':
                upd = atoi(optarg);
                for(l = 0; l < N; l++) 
                    fprintf(stdout, "Age updated to:%i\n", updStat( &runner[l] , upd ));

                break;

            default:
                fprintf(stdout, "ERROR options available: %s", OPTSTR);
        }
    }
    
    // free up memory
    free(runner);

    for(i = 0; i < N; i++) {
        free((char *)runner[i].name);
        free((char *)runner[i].country);
        free((char *)runner[i].event);
    }    

    return 0;
} 

void getStats( athlete *x ) { 
    fprintf(stdout, "Name of athlete: %s\nCountry:%s\n", x->name, x->country);
    fprintf(stdout, "Age of athlete: %i\nMain event: %s\n", x->age, x->event);
    fprintf(stdout, "PB:%i\n", x->pb);
}  

int updStat( athlete *x, int upd ) { 
    fprintf(stdout, "Age before: %i\n", x->age);
    x->age = x->age + upd;
    return x->age;
}  

void addRecord( athlete *x ) {
    int age;
    int pb;
    char line[BUFF];
    char *l = line;
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
    if(fscanf(stdin, "%i", &pb) == 1)
        x->pb = pb;
    fflush(stdin);

    free(l);
}