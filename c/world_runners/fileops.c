#include "runners.h"

void writeToFile( athlete *x, FILE *db ) {   
    if ( db != NULL ) { 
        if( fwrite( x, sizeof(*x), 1, db ) == 1)
            fprintf(stdout, "Written struct array to file\n");
        
    } else {
        fprintf(stderr, "Can't open file!\n");
    }
}

void readFromFile( athlete *x, FILE *db) {  
    if ( db != NULL ) {
        if( fread( x, sizeof(*x), 1, db ) == 1)
            fprintf(stdout, "Reading struct array from file\n");
        
    } else {
        fprintf(stderr, "Can't open file!\n");
    }
}