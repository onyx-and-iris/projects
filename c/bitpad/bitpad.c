#include "bitpad.h"

#include <stdio.h>
#include <getopt.h>
#include <string.h>
#include <stdlib.h>

int _initialized = -1;

int main ( int argc, char *argv[] ) {
    int opt;
    KIND kind_t;
    // set intialized type
    kind_t = get_kind();

    if (kind_t == BASIC)
        strips_0 = malloc(sizeof(*strips_0));
    else if (kind_t == BANANA)
        strips_1 = malloc(sizeof(*strips_1));
    else if (kind_t == POTATO)
        strips_2 = malloc(sizeof(*strips_2));

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

int init( KIND kind_t, basic *strips_0, banana *strips_1, potato *strips_2 ) {

    switch (kind_t) {
        case BASIC:
            strips_0->in_mute.ch1 =
            strips_0->in_mute.ch2 =
            strips_0->in_mute.ch3 = TRUE;
            strips_0->in_gain.ch1 =
            strips_0->in_gain.ch2 =
            strips_0->in_gain.ch3 = TRUE;
            break;
        case BANANA:
            strips_1->in_mute.ch1 = 
            strips_1->in_mute.ch2 = 
            strips_1->in_mute.ch3 = 
            strips_1->in_mute.ch4 = 
            strips_1->in_mute.ch5 = TRUE;
            strips_1->in_gain.ch1 = 
            strips_1->in_gain.ch2 = 
            strips_1->in_gain.ch3 = 
            strips_1->in_gain.ch4 = 
            strips_1->in_gain.ch5 = TRUE;
            break;
        case POTATO:
            strips_2->in_mute.ch1 = 
            strips_2->in_mute.ch2 = 
            strips_2->in_mute.ch3 = 
            strips_2->in_mute.ch4 = 
            strips_2->in_mute.ch5 = 
            strips_2->in_mute.ch6 = 
            strips_2->in_mute.ch7 = 
            strips_2->in_mute.ch8 = TRUE;
            strips_2->in_gain.ch1 = 
            strips_2->in_gain.ch2 = 
            strips_2->in_gain.ch3 = 
            strips_2->in_gain.ch4 = 
            strips_2->in_gain.ch5 = 
            strips_2->in_gain.ch6 = 
            strips_2->in_gain.ch7 = 
            strips_2->in_gain.ch8 = TRUE;
            break;
    }

    return 0;
}

int get_kind() {
    int is_kind;
    char get_kind;

    fprintf(stdout, "Which version of vb?\n0= basic, 1 = banana, 2 = potato\n"
    "press 'q' to quit.\n");
    while( (get_kind = getchar()) != '\n' ) {
        if ( get_kind == 'q' )
            exit(EXIT_FAILURE);

        // chat to int
        is_kind = get_kind - '0';
    }

    switch (is_kind) {
        case BASIC:
            printf("Voicemeeter type: basic\n");
            break;
        case BANANA:
            printf("Voicemeeter type: banana\n");
            break;
        case POTATO:
            printf("Voicemeeter type: potato\n");
            break;

        default: fprintf( stderr, "unknown voicemeeter version\n");
    }

    return is_kind;
}

void getStates( KIND kind_t, basic *strips_0, banana *strips_1, potato *strips_2 ) {
    printf("KIND IS OF TYPE %i\n", kind_t);
    switch (kind_t) {
        case BASIC: 
            printf("Mute states from ch1 - ch 3: [%i] [%i] [%i]:\n",
            strips_0->in_mute.ch1, strips_0->in_mute.ch2, strips_0->in_mute.ch3 );
            break;
        case BANANA:
            printf("Mute states from ch1 - ch 5: [%i] [%i] [%i] [%i] [%i]:\n",
            strips_1->in_mute.ch1, strips_1->in_mute.ch2, strips_1->in_mute.ch3,
            strips_1->in_mute.ch4, strips_1->in_mute.ch5);
            break;
        case POTATO: 
            printf("Mute states from ch1 - ch 8: [%i] [%i] [%i] [%i] [%i] [%i] [%i] [%i]:\n",
            strips_2->in_mute.ch1, strips_2->in_mute.ch2, strips_2->in_mute.ch3,
            strips_2->in_mute.ch4, strips_2->in_mute.ch5, strips_2->in_mute.ch6,
            strips_2->in_mute.ch7, strips_2->in_mute.ch8);
            break;
    }
}