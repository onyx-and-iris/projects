#include "runners.h"

void trimNewline( char * str ) {
    int len = strlen(str);

    if( str[len-1] == '\n' ) str[len-1] = '\0';
}

void purge ( athlete *x ) {
    int i = 0;
    // reintialize struct (for testing purposes)
    memset(x->name, 0, BUFF);
    x->age = 0;
    memset(x->country, 0, BUFF);
    memset(x->event, 0, BUFF);
    x->pb = 0;
    fprintf( stdout, "purging record from struct\n"
    "===============\n"
    "name: %s\nage:%i\ncountry:%s\nevent:%s\npb:%.2f\n"
    "===============\n", 
    x->name, x->age, x->country, x->event, x->pb);
}

void getStats ( athlete *x ) {
    fprintf(stdout, "=================\n"
    "Fetching data for athlete %s:\n"
    "=================\n"
    "age:%i\ncountry:%s\nevent:%s\npb:%.2f\n", 
    x->name, x->age, x->country, x->event, x->pb);
}

void addRecord( athlete *x ) {
    char line[BUFF];
    char *l = line;
    size_t l_size = BUFF;
    int age;
    float pb;

    fprintf(stdout, "Please enter athlete name:\n");
    // getline from stdin
    getline(&l, &l_size, stdin);
    // copy from buffer to struct element
    strcpy(x->name, l);
    // remove trailing newline
    trimNewline(x->name);
    fflush(stdin);

    fprintf(stdout, "Please enter athlete age:\n");
    // read int
    if(fscanf(stdin, "%i", &age))
        x->age = age;
    fflush(stdin);  

    fprintf(stdout, "Please enter athlete country:\n");
    // getline from stdin
    getline(&l, &l_size, stdin);
    // copy from buffer to struct element
    strcpy(x->country, l);
    // remove trailing newline
    trimNewline(x->country);
    fflush(stdin);

    fprintf(stdout, "Please enter athlete event:\n");
    // getline from stdin
    getline(&l, &l_size, stdin);
    // copy from buffer to struct element
    strcpy(x->event, l);
    // remove trailing newline
    trimNewline(x->event);
    fflush(stdin);

    fprintf(stdout, "Please enter athlete pb:\n");
    // read float
    if(fscanf(stdin, "%f", &pb))
        x->pb = pb;
    fflush(stdin);   
}