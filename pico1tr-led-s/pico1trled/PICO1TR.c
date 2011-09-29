#include <PICO1TR.h>

void debug_led_blink(uint8_t n) {
  uint8_t i = 0;
  while(1) {
    debug_led_on();
    delay_ms(100);
    debug_led_off();
    delay_ms(100);
    if (n == 0) continue;
    if (++i == n) break;
  }
};

void delay_ms(uint16_t millis) {
  while ( millis ) {
    _delay_ms(1);
    millis--;
  }
}

void delay_us(uint16_t micros) {
  while ( micros ) {
    _delay_us(1);
    micros--;
  }
}

