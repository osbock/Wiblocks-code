#ifndef __PICO1TR_LED_L_H__
#define __PICO1TR_LED_L_H__

#include <avr/pgmspace.h>
#include <util/delay.h>
#include <PICO1TR.h>

///
/// PICO1TR-LED-L 
/// 8x8 matrix of 5mm LEDs 
///
#define NUM_ROWS  10
#define NUM_COLS  10
#define LAST_ROW  NUM_ROWS - 1
#define LAST_COL  NUM_COLS - 1
#define NUM_PINS  NUM_ROWS + 1

#include <PICO1TR_LED_h>


#endif
