#define H_BITPAD_H

#include <stdio.h>
#include <stdlib.h>

#define OPTSTR "g"

#define FALSE 0
#define TRUE 1

typedef enum {
    BASIC, BANANA, POTATO
} KIND;

// map out structs for different kinds
typedef struct {
    unsigned int ch1:1;
    unsigned int ch2:1;
    unsigned int ch3:1;
} mute_0;

typedef struct {
    float ch1;
    float ch2;
    float ch3;
} gain_0;

typedef struct {
    unsigned int ch1:1;
    unsigned int ch2:1;
    unsigned int ch3:1;
    unsigned int ch4:1;
    unsigned int ch5:1;
} mute_1;

typedef struct {
    float ch1;
    float ch2;
    float ch3;
    float ch4;
    float ch5;
} gain_1;

typedef struct {
    unsigned int ch1:1;
    unsigned int ch2:1;
    unsigned int ch3:1;
    unsigned int ch4:1;
    unsigned int ch5:1;
    unsigned int ch6:1;
    unsigned int ch7:1;
    unsigned int ch8:1;
} mute_2;

typedef struct {
    float ch1;
    float ch2;
    float ch3;
    float ch4;
    float ch5;
    float ch6;
    float ch7;
    float ch8;
} gain_2;

typedef struct {
    mute_0 in_mute;
    gain_0 in_gain;

    mute_0 out_mute;
    gain_0 out_gain;
} basic;

typedef struct {
    mute_1 in_mute;
    gain_1 in_gain;

    mute_1 out_mute;
    gain_1 out_gain;
} banana;

typedef struct {
    mute_2 in_mute;
    gain_2 in_gain;

    mute_2 out_mute;
    gain_2 out_gain;
} potato;

basic *strips_0;
banana *strips_1;
potato *strips_2;

// function declarations
int get_kind();
int init( KIND, basic *, banana *, potato * );
void getStates( KIND, basic *, banana *, potato * );