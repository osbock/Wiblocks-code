#ifndef __PICO1TR_H__
#define __PICO1TR_H__

#include <avr/pgmspace.h>
#include <util/delay.h>

//
// the PICO has the debug LED connected to PD7.
// debug_led_init, debug_led_on, debug_led_off
// debug_led_blink enable the control of the
// LED.
// 
#define DEBUG_LED_PORT PORTD
#define DEBUG_LED_DDR  DDRD
#define DEBUG_LED_BIT  7
/// 
/// debug LED macros and functions
///
#define debug_led_on()   DEBUG_LED_PORT |=  (1<<DEBUG_LED_BIT)
#define debug_led_off()  DEBUG_LED_PORT &= ~(1<<DEBUG_LED_BIT)
#define debug_led_init() DEBUG_LED_DDR  |=  (1<<DEBUG_LED_BIT)
void debug_led_blink(uint8_t n);
///
/// wrappers for the delay functions provided by 
/// delay.h
///
void delay_ms(uint16_t millis);
void delay_us(uint16_t micros);

#endif
