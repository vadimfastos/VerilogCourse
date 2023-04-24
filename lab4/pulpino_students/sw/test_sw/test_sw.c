#define __riscv__
#define LED_DELAY 1000000

//#include <spi.h>
#include <gpio.h>
#include <uart.h>
//#include <utils.h>
#include <pulpino.h>
#include "kuznechik.h"
#include <string.h>


void led_delay() {
    for (int i = 0; i < LED_DELAY; i++) {
        //wait some time
        #ifdef __riscv__
        asm volatile ("nop");
        #else
        asm volatile ("l.nop");
        #endif
    }
}


int main() {

    uart_set_cfg(0, 27); // 115200 baud UART, no parity (50MHz CPU)
    kuznechik_init();

    /*uart_send("Hello world!\n", 13); // 13 is a number of chars sent: 12 + "\n" 
    uart_wait_tx_done();*/

    /*set_pin_function(31, FUNC_GPIO);
    set_gpio_pin_direction(31, DIR_OUT);
    set_gpio_pin_value(31, 0);
    led_delay();
    set_gpio_pin_value(31, 1);
    led_delay();
    set_gpio_pin_value(31, 0);*/

    // принимаем блок данных по UART, шифруем и выдаём ответ
    while(1) {
        uint8_t src_data[KUZNECHIK_BLOCK_LEN], dst_data[KUZNECHIK_BLOCK_LEN];
        for (int i=0; i<KUZNECHIK_BLOCK_LEN; i++)
            src_data[i] = (uint8_t)uart_getchar();

        if (kuznechik_process_data_block(src_data, dst_data)) {
            uart_send(dst_data, KUZNECHIK_BLOCK_LEN);
            uart_wait_tx_done();
        } else {
            const char err_msg[] = "Error!\n";
            uart_send(err_msg, strlen(err_msg));
            uart_wait_tx_done();
        }
    }

    return 0;
}
