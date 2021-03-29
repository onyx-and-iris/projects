#include "runners.h"

/*
    1) Int, Float reading correctly from file, strings not. todo check validity of
    strings written to file. Perhaps write each record independantly.
*/
runner *read_from_file() {
    int count = 0;
    int len = 0;
    int j = 0;
    char *line = malloc(BUFF * sizeof(char));
    runner *i = malloc(sizeof(*i));
    FILE *records = fopen("records.dat", "r");

    if(records != NULL) {
        //1)
        while (fread(i, sizeof(*i), 1, records)) {
            printf("Record file found, reading from file...\n");

            //fprintf(stdout, "name: %s\n", i->name);
            //fprintf(stdout, "age: %i\n", i->age);
            //fprintf(stdout, "country: %s\n", i->country);
            //fprintf(stdout, "event: %s\n", i->event);
            //fprintf(stdout, "pb: %.2f\n", i->pb);

            count++;
        }
    } else
        fprintf(stderr, "Error opening file\n");

    if(count) {
        fprintf(stdout, "%i records read from file\n", count);
        return NULL;
    } else {
        fprintf(stdout, "No records read from file\n");
        return NULL;        
    }
}

int write_to_file( runner * x ) {
    int count = 0;
    runner *i = x;
    runner *next = NULL;
    FILE *records = fopen("records.dat", "w");

    if(records != NULL) {
        do {
            next = i->next;
            if(fwrite(i, sizeof(*i), 1, records) == 1) {
                fprintf(stdout, "Written record for %s to file\n", i->name);

                ++count;                
            }
            i = next;

        } while( next != NULL );

        fclose(records);
    } else {
        fprintf(stderr, "Error opening file!\n");
    }

    return count;
}
