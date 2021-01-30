#include "runners.h"

runner *readFromFile() {
    int count = -1;
    runner *start = NULL;
    runner *temp = NULL;
    runner *last = NULL;
    FILE *records = fopen("records.dat", "r");

    temp = malloc(sizeof(*temp));
    temp->name = malloc(sizeof(BUFF));
    temp->country = malloc(sizeof(BUFF));
    temp->event = malloc(sizeof(BUFF));

    if(records != NULL) {
        do {
            printf("COUNT = %i\n", count);
            if( temp != NULL ) {
                last->name = strdup(temp->name);
                last->country = strdup(temp->country);
                last->event = strdup(temp->event);
                last->next = temp;
            }
            printf("COUNT = %i\n", count);
            last = malloc(sizeof(*temp));
            last->name = malloc(sizeof(BUFF));
            last->country = malloc(sizeof(BUFF));
            last->event = malloc(sizeof(BUFF));

            if( start == NULL )
                start = temp;

            last = temp;
            printf("COUNT = %i\n", count);
            ++count;

        } while( fread(temp, sizeof(*temp), 1, records) == 1 );

        fclose(records);
    }

    free(temp->name);
    free(temp->country);
    free(temp->event);
    free(temp);

    printf("COUNT = %i\n", count);
    if(count)
        return start;
    else 
        return NULL;
}

int writeToFile( runner * x ) {
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
