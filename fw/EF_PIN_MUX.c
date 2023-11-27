#ifndef EF_PIN_MUX_C
#define EF_PIN_MUX_C

#include <EF_PIN_MUX.h>

void EF_PinMux_writeSelect(uint32_t pin_mux_base, int select){

    EF_PIN_MUX_TYPE* pin_mux = (EF_PIN_MUX_TYPE*)pin_mux_base;
    pin_mux->fn_sel0 = select ;
}
void EF_PinMux_writeSelect2(uint32_t pin_mux_base, int select){

    EF_PIN_MUX_TYPE* pin_mux = (EF_PIN_MUX_TYPE*)pin_mux_base;
    pin_mux->fn_sel1 = select ;
}

int EF_PinMux_readSelect(uint32_t pin_mux_base){

    EF_PIN_MUX_TYPE* pin_mux = (EF_PIN_MUX_TYPE*)pin_mux_base;
    return (pin_mux->fn_sel0);
}
int EF_PinMux_readSelect2(uint32_t pin_mux_base){

    EF_PIN_MUX_TYPE* pin_mux = (EF_PIN_MUX_TYPE*)pin_mux_base;
    return (pin_mux->fn_sel1);
}

void EF_PinMux_writeSelectGpio1(uint32_t pin_mux_base, enum gpio_select gpio, enum select_types select){

    int select_val = EF_PinMux_readSelect(pin_mux_base);
    select_val &= ~(0x3 << gpio); // zero the needed bits
    select_val |= select << gpio;
    EF_PinMux_writeSelect(pin_mux_base, select_val);
}

void EF_PinMux_writeSelectGpio2(uint32_t pin_mux_base, enum gpio_select gpio, enum select_types select){

    int select_val = EF_PinMux_readSelect2(pin_mux_base);
    select_val &= ~(0x3 << gpio); // zero the needed bits
    select_val |= select << gpio;
    EF_PinMux_writeSelect2(pin_mux_base, select_val);
}

void EF_PinMux_writeSelectGpio(uint32_t pin_mux_base, enum gpio_select gpio, enum select_types select){

    if (gpio > 30) {
        EF_PinMux_writeSelectGpio2(pin_mux_base, gpio - 32, select);
    }else{
        EF_PinMux_writeSelectGpio1(pin_mux_base, gpio, select);
    }
}

int EF_PinMux_readSelect4Gpio(uint32_t pin_mux_base, enum gpio_select gpio){

    int select_val = EF_PinMux_readSelect(pin_mux_base) >> gpio;
    return select_val & 0x3;
}
#endif // PIN_MUX_H