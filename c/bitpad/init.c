#include "bitpad.h"

int get_kind() {
    int is_kind;
    char get_kind;

    fprintf(stdout, "Which version of vb?\n0= basic, 1 = banana, 2 = potato\n"
    "press 'q' to quit.\n");
    while( (get_kind = getchar() ) != '\n' ) {
        if ( get_kind == 'q' )
            exit(EXIT_FAILURE);

        // char to int
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

int init( KIND kind_t, basic *strips_0, banana *strips_1, potato *strips_2 ) {

    switch (kind_t) {
        case BASIC:
            strips_0->in_mute.ch1 =
            strips_0->in_mute.ch2 =
            strips_0->in_mute.ch3 = TRUE;
            strips_0->in_gain.ch1 =
            strips_0->in_gain.ch2 =
            strips_0->in_gain.ch3 = 0;

            strips_0->out_mute.ch1 =
            strips_0->out_mute.ch2 =
            strips_0->out_mute.ch3 = TRUE;
            strips_0->out_gain.ch1 =
            strips_0->out_gain.ch2 =
            strips_0->out_gain.ch3 = 0;
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
            strips_1->in_gain.ch5 = 0;

            strips_1->out_mute.ch1 = 
            strips_1->out_mute.ch2 = 
            strips_1->out_mute.ch3 = 
            strips_1->out_mute.ch4 = 
            strips_1->out_mute.ch5 = TRUE;
            strips_1->out_gain.ch1 = 
            strips_1->out_gain.ch2 = 
            strips_1->out_gain.ch3 = 
            strips_1->out_gain.ch4 = 
            strips_1->out_gain.ch5 = 0;
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
            strips_2->in_gain.ch8 = 0;

            strips_2->out_mute.ch1 = 
            strips_2->out_mute.ch2 = 
            strips_2->out_mute.ch3 = 
            strips_2->out_mute.ch4 = 
            strips_2->out_mute.ch5 = 
            strips_2->out_mute.ch6 = 
            strips_2->out_mute.ch7 = 
            strips_2->out_mute.ch8 = TRUE;
            strips_2->out_gain.ch1 = 
            strips_2->out_gain.ch2 = 
            strips_2->out_gain.ch3 = 
            strips_2->out_gain.ch4 = 
            strips_2->out_gain.ch5 = 
            strips_2->out_gain.ch6 = 
            strips_2->out_gain.ch7 = 
            strips_2->out_gain.ch8 = 0;
            break;
    }

    return 0;
}

void getStates( KIND kind_t, basic *strips_0, banana *strips_1, potato *strips_2 ) {
    switch (kind_t) {
        case BASIC:
            printf("HW and VIRTUAL IN\n===================\n"); 
            printf("Mute states from ch1 - ch 3: [%i] [%i] [%i]\n",
            strips_0->in_mute.ch1, strips_0->in_mute.ch2, strips_0->in_mute.ch3 );

            printf("Gain levels from ch1 - ch 3: [%.1f] [%.1f] [%.1f]\n",
            strips_0->in_gain.ch1, strips_0->in_gain.ch2, strips_0->in_gain.ch3 );

            printf("HW and VIRTUAL OUT\n===================\n"); 
            printf("Mute states from ch1 - ch 3: [%i] [%i] [%i]\n",
            strips_0->out_mute.ch1, strips_0->out_mute.ch2, strips_0->out_mute.ch3 );

            printf("Gain levels from ch1 - ch 3: [%.1f] [%.1f] [%.1f]\n",
            strips_0->out_gain.ch1, strips_0->out_gain.ch2, strips_0->out_gain.ch3 );
            break;
        case BANANA:
            printf("HW and VIRTUAL IN\n===================\n"); 
            printf("Mute states from ch1 - ch 5: [%i] [%i] [%i] [%i] [%i]\n",
            strips_1->in_mute.ch1, strips_1->in_mute.ch2, strips_1->in_mute.ch3,
            strips_1->in_mute.ch4, strips_1->in_mute.ch5);

            printf("Gain levels from ch1 - ch 5: [%.1f] [%.1f] [%.1f] [%.1f] [%.1f]\n",
            strips_1->in_gain.ch1, strips_1->in_gain.ch2, strips_1->in_gain.ch3, 
            strips_1->in_gain.ch4, strips_1->in_gain.ch5);

            printf("HW and VIRTUAL OUT\n===================\n"); 
            printf("Mute states from ch1 - ch 5: [%i] [%i] [%i] [%i] [%i]\n",
            strips_1->out_mute.ch1, strips_1->out_mute.ch2, strips_1->out_mute.ch3,
            strips_1->out_mute.ch4, strips_1->out_mute.ch5);

            printf("Gain levels from ch1 - ch 5: [%.1f] [%.1f] [%.1f] [%.1f] [%.1f]\n",
            strips_1->out_gain.ch1, strips_1->out_gain.ch2, strips_1->out_gain.ch3, 
            strips_1->out_gain.ch4, strips_1->out_gain.ch5);
            break;
        case POTATO: 
            printf("HW and VIRTUAL IN\n===================\n"); 
            printf("Mute states from ch1 - ch 8: [%i] [%i] [%i] [%i] [%i] [%i] "
            "[%i] [%i]\n",
            strips_2->in_mute.ch1, strips_2->in_mute.ch2, strips_2->in_mute.ch3,
            strips_2->in_mute.ch4, strips_2->in_mute.ch5, strips_2->in_mute.ch6,
            strips_2->in_mute.ch7, strips_2->in_mute.ch8);
 
            printf("Gain levels from ch1 - ch 5: [%.1f] [%.1f] [%.1f] [%.1f] [%.1f] " 
            "[%.1f] [%.1f] [%.1f]\n",
            strips_2->in_gain.ch1, strips_2->in_gain.ch2, strips_2->in_gain.ch3, 
            strips_2->in_gain.ch4, strips_2->in_gain.ch5, strips_2->in_gain.ch6,
            strips_2->in_gain.ch7, strips_2->in_gain.ch8);

            printf("HW and VIRTUAL OUT\n===================\n"); 
            printf("Mute states from ch1 - ch 8: [%i] [%i] [%i] [%i] [%i] [%i] "
            "[%i] [%i]\n",
            strips_2->out_mute.ch1, strips_2->out_mute.ch2, strips_2->out_mute.ch3,
            strips_2->out_mute.ch4, strips_2->out_mute.ch5, strips_2->out_mute.ch6,
            strips_2->out_mute.ch7, strips_2->out_mute.ch8);
 
            printf("Gain levels from ch1 - ch 5: [%.1f] [%.1f] [%.1f] [%.1f] [%.1f] " 
            "[%.1f] [%.1f] [%.1f]\n",
            strips_2->out_gain.ch1, strips_2->out_gain.ch2, strips_2->out_gain.ch3, 
            strips_2->out_gain.ch4, strips_2->out_gain.ch5, strips_2->out_gain.ch6,
            strips_2->out_gain.ch7, strips_2->out_gain.ch8);
            break;
    }
}