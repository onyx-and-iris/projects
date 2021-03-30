#include "runners.h"

/*
    1) Int, Float reading correctly from file, strings not. todo check validity of
    strings written to file. Perhaps write each record independantly.
*/

runner *get_single_record( FILE *records ) {
    int age = 0;
    float pb = 0;

    runner *i = malloc(sizeof(*i));

    i->name = malloc(sizeof(BUFF));
    i->country = malloc(sizeof(BUFF));
    i->event = malloc(sizeof(BUFF));

    if ( fread(i->name, BUFF, 1, records) == 1 ) {
        fprintf(stdout, "\nReading record for %s from file\n", i->name);
    
        if ( fread(&age, sizeof(age), 1, records) == 1 ) {
            i->age = age;
            fprintf(stdout, "Read %i from file\n", i->age);
        }
        if ( fread(i->country, BUFF, 1, records) == 1 ) {
            fprintf(stdout, "Read %s from file\n", i->country);
        }
        if ( fread(i->event, BUFF, 1, records) == 1 ) {
            fprintf(stdout, "Read %s from file\n", i->event);
        }
        if ( fread(&pb, sizeof(pb), 1, records) == 1 ) {
            i->pb = pb;
            fprintf(stdout, "Read %.2f from file\n", i->pb);
        }
        return i;        
    } else {
        return NULL;
    }
}

runner *read_from_file() {
    int count = 0;

    runner *start = NULL;
    runner *last = NULL;
    FILE *records = fopen("records.dat", "r");

    if(records != NULL) {
        //1)
        do {
            last = get_single_record( records );
/*
            if (start == NULL)
                start = next;
           
            if (last != NULL)
                last->next = i;
*/
            ++count;

        } while ( last != NULL );
        fclose(records);

    } else {
        fprintf(stderr, "Error opening file\n");
    }

    if(count) {
        fprintf(stdout, "%i records read from file\n", count);
        return start;
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

            if( fwrite(i->name, BUFF, 1, records) == 1 ) {
                fprintf(stdout, "\nWriting record for %s to file\n", i->name);

                if( fwrite(&i->age, sizeof(i->age), 1, records) == 1 ) {
                    fprintf(stdout, "Written %i to file\n", i->age);          
                }
                if( fwrite(i->country, BUFF, 1, records) == 1 ) {
                    fprintf(stdout, "Written %s to file\n", i->country);          
                }
                if( fwrite(i->event, BUFF, 1, records) == 1 ) {
                    fprintf(stdout, "Written %s to file\n", i->event);          
                }
                if( fwrite(&i->pb, sizeof(i->pb), 1, records) == 1 ) {
                    fprintf(stdout, "Written %.2f to file\n", i->pb);          
                }
            }
            ++count;   
            i = next;

        } while( next != NULL );

        fclose(records);
    } else {
        fprintf(stderr, "Error opening file!\n");
    }

    return count;
}
