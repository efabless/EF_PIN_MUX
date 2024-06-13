#ifndef EF_PIN_MUX_H
#define EF_PIN_MUX_H

#include <EF_PIN_MUX_regs.h>
#include <stdint.h>

enum select_types{F0 = 0, F1 = 1, F2 = 2, F3 = 3};

// specific to cheetah pin assignment not generic
enum gpio_select{GPIO8 = 0, GPIO9 = 2, GPIO10 = 4, GPIO11 = 6, GPIO12 = 8, GPIO13 = 10, GPIO14 = 12, GPIO15 = 14, 
                GPIO16 = 16, GPIO17 = 18, GPIO18 = 20, GPIO19 = 22, GPIO20 = 24, GPIO21 = 26, GPIO22 = 28, GPIO23 = 30, 
                GPIO24 = 32, GPIO25 = 34, GPIO26 = 36, GPIO27 = 38, GPIO28 = 40, GPIO29 = 42, GPIO30 = 44, GPIO31 = 46,
                GPIO32 = 48, GPIO33 = 50, GPIO34 = 52, GPIO35 = 54, GPIO36 = 56, GPIO37 = 58, GPIO38 = 60, GPIO39 = 62,
                GPIO40 = 64, GPIO41 = 66, GPIO42 = 68, GPIO43 = 70, GPIO44 = 72, GPIO45 = 74, GPIO46 = 76, GPIO47 = 78,
                GPIO48 = 80, GPIO49 = 82, GPIO50 = 84, GPIO51 = 86, GPIO52 = 88, GPIO53 = 90, GPIO54 = 92, GPIO55 = 94};

void EF_PinMux_writeSelect(uint32_t pin_mux_base, int select);

void EF_PinMux_writeSelect2(uint32_t pin_mux_base, int select);

void EF_PinMux_writeSelect3(uint32_t pin_mux_base, int select);

int EF_PinMux_readSelect(uint32_t pin_mux_base);

int EF_PinMux_readSelect2(uint32_t pin_mux_base);

int EF_PinMux_readSelect3(uint32_t pin_mux_base);

void EF_PinMux_writeSelectGpio1(uint32_t pin_mux_base, enum gpio_select gpio, enum select_types select);

void EF_PinMux_writeSelectGpio2(uint32_t pin_mux_base, enum gpio_select gpio, enum select_types select);

void EF_PinMux_writeSelectGpio3(uint32_t pin_mux_base, enum gpio_select gpio, enum select_types select);

void EF_PinMux_writeSelectGpio(uint32_t pin_mux_base, enum gpio_select gpio, enum select_types select);

int EF_PinMux_readSelect4Gpio(uint32_t pin_mux_base, enum gpio_select gpio);

#endif