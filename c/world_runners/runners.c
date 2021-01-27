#include "runners.h"

#include <getopt.h>
#ifndef RUNNERS_H
#include <stdio.h>
#include <stdlib.h>
#endif

int main ( int argc, char *argv[] ) {
    int opt = 0;
    int i = 0;
    FILE *db = NULL;

    athlete runner[N];
/*  WRITING ENTIRE STRUCT WITH POINTER ELEMENTS TO FILE 
    REQUIRES DIFFERENT METHOD

    create struct array and allocate memory
    athlete *runner = malloc(N * sizeof(*runner));
    for( i = 0; i < N; i++ ) {
        // buff+1 for newline
        runner[i].name = malloc( (BUFF+1) * sizeof(char));
        runner[i].country = malloc( (BUFF+1) * sizeof(char));
    }
*/
    while ((opt = getopt(argc, argv, OPTSTR)) != EOF) {
        switch(opt) {
            // new record
            case 'n':
                db = fopen( "db.dat", "wb" );
                fprintf( stdout, "Let's set some records!\n" );
                for( i = 0; i < N; i++ ) {
                    // set records
                    addRecord( &runner[i] );
                    // print back records
                    getStats( &runner[i] );
                    // then write them to file
                    writeToFile( &runner[i], db );
                    // then reinitialize structs
                    purge( &runner[i] );
                }
                fclose( db );

            break;

            // get records
            case 'g':
                db = fopen( "db.dat", "rb" );
                fprintf( stdout, "\n\nLet's get some records!\n" );
                for( i = 0; i < N; i++ ) {
                    // read from file
                    readFromFile( &runner[i], db );
                    // then print back records
                    getStats( &runner[i] );
                }
                fclose( db );

            break;

            default:
                fprintf(stdout, "ERROR options available: %s", OPTSTR);
        }
    }

/*  // NOT REQUIRED NOW
    for( i = 0; i < N; i++ ) {
        free( runner[i].name );
        free( runner[i].country );
    }
    free( runner );
*/
    return 0;
}
