#include <avr/pgmspace.h>
#include <avr/io.h>

#include <PICO1TR.h>
//
// Configure for the PICO1TR-LED-L
//
#include <PICO1TR_LED_S.h>
#include <PICO1TR_LED_S_char_data.h>

//
// all of the pins used to drive the rows and columns of the LED
// matrix are declared in the led_pins array.
// 
// the row and column ordinals are both 0..7.  from the ordinal an
// index into the led_pin array is calculated.
// 
// *** the row index is the same as the row ordinal 0..7
// *** the column index is
//
//    column index = column ordinal      for column ord < row ordinal
//    column index = column ordianl + 1  otherwise
//

static struct {
  volatile uint8_t *port; // I/O port
  volatile uint8_t *ddr;  //
  uint8_t bit;
} led_pins[NUM_PINS] = 
  { &PORTB, &DDRB, PORTB0, 
    &PORTB, &DDRB, PORTB1, 
    &PORTB, &DDRB, PORTB2, 
    &PORTC, &DDRC, PORTC1,
    &PORTC, &DDRC, PORTC2, 
    &PORTD, &DDRD, PORTD2,
    &PORTD, &DDRD, PORTD3, 
    &PORTD, &DDRD, PORTD4, 
    &PORTD, &DDRD, PORTD5, 
    &PORTD, &DDRD, PORTD6,
    &PORTD, &DDRD, PORTD7 };

//
// Load the generic c functions
//
#include <PICO1TR_LED_c>

