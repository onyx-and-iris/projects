#include "bitpad.h"

#include <getopt.h>
#include <string.h>

#ifndef H_BITPAD_H
#include <stdio.h>
#include <stdlib.h>
#endif

int _initialized = -1;

int main ( int argc, char *argv[] ) {
    int opt;
    KIND kind_t;
    // get vb version
    kind_t = get_kind();

    if (kind_t == BASIC)
        strips_0 = malloc(sizeof(*strips_0));
    else if (kind_t == BANANA)
        strips_1 = malloc(sizeof(*strips_1));
    else if (kind_t == POTATO)
        strips_2 = malloc(sizeof(*strips_2));
    // intialize struct
    _initialized = 1 - init( kind_t, strips_0, strips_1, strips_2 );

    while ((opt = getopt(argc, argv, OPTSTR)) != EOF) {
        switch(opt) {
            // set state
            case 'g':
                if(_initialized)
                    getStates( kind_t, strips_0, strips_1, strips_2 );
            break;
        }
    }

    if (kind_t == BASIC)
        free(strips_0);
    else if (kind_t == BANANA)
        free(strips_1);
    else if (kind_t == POTATO)
        free(strips_2);

    return 0;
}