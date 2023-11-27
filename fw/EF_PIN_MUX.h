#ifndef EF_PIN_MUX_H
#define EF_PIN_MUX_H

#include <EF_PIN_MUX_regs.h>
#include <stdint.h>

enum select_types{F0 = 0, F1 = 1, F2 = 2, F3 = 3};

// specific to cheetah pin assignment not generic
enum gpio_select{GPIO0 = 0, GPIO1 = 2, GPIO2 = 4, GPIO3 = 6, GPIO4 = 8, GPIO5 = 10, GPIO6 = 12, GPIO7 = 14, GPIO8 = 16, GPIO9 = 18, GPIO10 = 20, GPIO11 = 22, GPIO12 = 24, GPIO13 = 26, GPIO14 = 28, GPIO24 = 30, GPIO26 = 32, GPIO27 = 34, GPIO28 = 36, GPIO29 = 38, GPIO30 = 40};

void EF_PinMux_writeSelect(uint32_t pin_mux_base, int select);

void EF_PinMux_writeSelect2(uint32_t pin_mux_base, int select);

int EF_PinMux_readSelect(uint32_t pin_mux_base);

int EF_PinMux_readSelect2(uint32_t pin_mux_base);

void EF_PinMux_writeSelectGpio1(uint32_t pin_mux_base, enum gpio_select gpio, enum select_types select);

void EF_PinMux_writeSelectGpio2(uint32_t pin_mux_base, enum gpio_select gpio, enum select_types select);

void EF_PinMux_writeSelectGpio(uint32_t pin_mux_base, enum gpio_select gpio, enum select_types select);

int EF_PinMux_readSelect4Gpio(uint32_t pin_mux_base, enum gpio_select gpio);

#endif