#include <avr/io.h>
#include <util/delay.h>
#define F_CPU 16000000UL

void pin_setip(void){
    DDRC = 0x00;
    DDRB = 0xFF;
    DDRD = 0xFF;

    PORTB = 0x00;
    PORTD = 0x00;
}
void ADC_setup(void){
    ADCSRA = 0x87;
    ADMUX = 0x40;
}