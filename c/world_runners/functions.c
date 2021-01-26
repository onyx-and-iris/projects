#include "functions.h"

void getStats( athlete *x ) { 
    fprintf(stdout, "Name of athlete: %s\nCountry:%s\n", x->name, x->country);
    fprintf(stdout, "Age of athlete: %i\n\nMain event: %s\n", x->age, x->event);
    fprintf(stdout, "PB:%.2f\n", x->pb);
}

int writeRecord( athlete *x, FILE *records ) {
    records = fopen("records", "wb");

    if(records != NULL) {
        fwrite(x, sizeof(x), 1, records);
        fclose(records);
    }

    return 0;
}

int readRecord( athlete *x, FILE *records ) {
    records = fopen("records", "rb");
    if(records != NULL) {
        fread(x, sizeof(x), 1, records);
        fclose(records);
    }

    getStats( x );

    return 0;
}