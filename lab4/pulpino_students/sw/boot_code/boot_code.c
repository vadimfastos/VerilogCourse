// Copyright 2017 ETH Zurich and University of Bologna.
// Copyright and related rights are licensed under the Solderpad Hardware
// License, Version 0.51 (the “License”); you may not use this file except in
// compliance with the License.  You may obtain a copy of the License at
// http://solderpad.org/licenses/SHL-0.51. Unless required by applicable law
// or agreed to in writing, software, hardware and materials distributed under
// this License is distributed on an “AS IS” BASIS, WITHOUT WARRANTIES OR
// CONDITIONS OF ANY KIND, either express or implied. See the License for the
// specific language governing permissions and limitations under the License.

#define __riscv__
#define LED_DELAY 10

//#include <spi.h>
#include <gpio.h>
//#include <uart.h>
//#include <utils.h>
#include <pulpino.h>



int main()
{
  set_pin_function(31, FUNC_GPIO);
  set_gpio_pin_direction(31, DIR_OUT);
  
  set_gpio_pin_value(31, 0);
  
  for (int i = 0; i < LED_DELAY; i++) {
    //wait some time to have proper power up of external flash
    #ifdef __riscv__
        asm volatile ("nop");
    #else
        asm volatile ("l.nop");
    #endif
  }

  set_gpio_pin_value(31, 1);

  for (int i = 0; i < LED_DELAY; i++) {
    //wait some time to have proper power up of external flash
    #ifdef __riscv__
        asm volatile ("nop");
    #else
        asm volatile ("l.nop");
    #endif
  }

  set_gpio_pin_value(31, 0);


  //jump to program start address (instruction base address)
  jump_and_start((volatile int *)(INSTR_RAM_START_ADDR));
}



void jump_and_start(volatile int *ptr)
{
#ifdef __riscv__
  asm("jalr x0, %0\n"
      "nop\n"
      "nop\n"
      "nop\n"
      : : "r" (ptr) );
#else
  asm("l.jr\t%0\n"
      "l.nop\n"
      "l.nop\n"
      "l.nop\n"
      : : "r" (ptr) );
#endif
}
