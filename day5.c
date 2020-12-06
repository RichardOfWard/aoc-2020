#!/usr/bin/env -S tcc -run
#include <stdio.h>
#include <math.h>
#define ROW_EXPONENT 7
#define COL_EXPONENT 3

unsigned int posToSeatNum(char xPos[ROW_EXPONENT], char yPos[COL_EXPONENT]) {
    unsigned int row=0, col=0;
    for (unsigned int i = 0; i<ROW_EXPONENT; i++) {
        if (xPos[i]=='B') {
            row += pow(2, ROW_EXPONENT-1-i);
        }
    }
    for (unsigned int i = 0; i<COL_EXPONENT; i++) {
        if (yPos[i]=='R') {
            col += pow(2, COL_EXPONENT-1-i);
        }
    }
    return row * pow(2, COL_EXPONENT) + col;
}

void main(){
    FILE * f = fopen("day5-input.txt", "rb");
    unsigned int maxSeatNum=0;
    while (!feof(f)) {
        char xPos[ROW_EXPONENT]={0, 0, 0, 0, 0, 0, 0};
        char yPos[COL_EXPONENT]={0, 0, 0};
        fscanf(f,
            "%c%c%c%c%c%c%c" // B or F
            "%c%c%c" // L or R
            "\n",
            &xPos[0], &xPos[1], &xPos[2], &xPos[3], &xPos[4], &xPos[5], &xPos[6],
            &yPos[0], &yPos[1], &yPos[2]
        );
        unsigned int seatNum = posToSeatNum(xPos, yPos);
        maxSeatNum = seatNum > maxSeatNum ? seatNum : maxSeatNum;
    }
    printf("%u\n", maxSeatNum);
}
