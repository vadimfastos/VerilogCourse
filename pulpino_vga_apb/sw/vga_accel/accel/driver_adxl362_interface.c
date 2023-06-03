/**
 * Copyright (c) 2015 - present LibDriver All rights reserved
 * 
 * The MIT License (MIT)
 *
 * Permission is hereby granted, free of charge, to any person obtaining a copy
 * of this software and associated documentation files (the "Software"), to deal
 * in the Software without restriction, including without limitation the rights
 * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 * copies of the Software, and to permit persons to whom the Software is
 * furnished to do so, subject to the following conditions:
 *
 * The above copyright notice and this permission notice shall be included in all
 * copies or substantial portions of the Software.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
 * SOFTWARE. 
 *
 * @file      driver_adxl362_interface_template.c
 * @brief     driver adxl362 interface template source file
 * @version   1.0.0
 * @author    Shifeng Li
 * @date      2023-02-28
 *
 * <h3>history</h3>
 * <table>
 * <tr><th>Date        <th>Version  <th>Author      <th>Description
 * <tr><td>2023/02/28  <td>1.0      <td>Shifeng Li  <td>first upload
 * </table>
 */

#include "driver_adxl362_interface.h"
#include <spi.h>
#include <stdio.h>
#include <stdarg.h>
#include <uart.h>

static int accel_spi_buff[256];

/**
 * @brief  interface spi bus init
 * @return status code
 *         - 0 success
 *         - 1 spi init failed
 * @note   none
 */
uint8_t adxl362_interface_spi_init(void)
{
    spi_setup_master(1);
    *(volatile int *)(SPI_REG_CLKDIV) = 20;
    *(volatile int *)(SPI_REG_INTCFG) = 0;
    return 0;
}

/**
 * @brief  interface spi bus deinit
 * @return status code
 *         - 0 success
 *         - 1 spi deinit failed
 * @note   none
 */
uint8_t adxl362_interface_spi_deinit(void)
{
    return 0;
}

/**
 * @brief      interface spi bus read
 * @param[in]  reg is the register address
 * @param[out] *buf points to a data buffer
 * @param[in]  len is the length of data buffer
 * @return     status code
 *             - 0 success
 *             - 1 read failed
 * @note       none
 */
uint8_t adxl362_interface_spi_read(uint8_t reg, uint8_t *buf, uint16_t len)
{
    SPI_STATUS = 1 << SPI_CMD_SWRST;
    while((SPI_STATUS & 0x01)==0);
    spi_setup_cmd_addr(reg, 8, 0, 0);
    spi_set_datalen(len << 3);
    spi_start_transaction(SPI_CMD_RD, 0);
    //spi_read_fifo((int*)buf, len << 3);

    uint8_t *p = buf; int16_t l = len;
    while (l > 0) {
        while ((((*(volatile int*) (SPI_REG_STATUS)) >> 16) & 0xFF) == 0);
        uint32_t data = *(volatile uint32_t*) (SPI_REG_RXFIFO);

        for (int i=((l > 4) ? 4 : l)-1; i>=0; i--) {
            p[i] = data & 0xFF;
            data >>= 8;
        }

        p += 4; l -= 4;
    }

    while((SPI_STATUS & 0x01)==0);
    
    adxl362_interface_debug_print("read: reg=0x%x; *buf=0x%x; len=%d; \r\n", reg, *((unsigned*)buf), len);
    /*while((SPI_STATUS & 0x01)==0);	//wait until SPI is idle
    SPI_SPILEN= (8<<16);	//set data length to be 8 bits, address and command lengths 0 bits
    SPI_STATUS = 0x0102;		//initiate a write operation with select CS0
    while (((SPI_STATUS >> 24) & 0xFF) >= 8);	//wait until tx buffer has available place
    SPI_TXFIFO=reg<<24;

    while (len > 0) {
        while((SPI_STATUS & 0x01)==0);	//wait until SPI is idle
        SPI_SPILEN= (8<<16);	//set data length to be 8 bits, address and command lengths 0 bitsS
        SPI_STATUS=0x0101;			//initiate a read operation with select CS0
        while (((SPI_STATUS >> 16) & 0xFF) == 0);	//wait until rx buffer has available place
        *buf = (uint8_t)(SPI_RXFIFO);
        buf++; len--;
    }*/
    
    return 0;
}

/**
 * @brief      interface spi bus read
 * @param[in]  addr is the spi register address
 * @param[out] *buf points to a data buffer
 * @param[in]  len is the length of the data buffer
 * @return     status code
 *             - 0 success
 *             - 1 read failed
 * @note       none
 */
uint8_t adxl362_interface_spi_read_address16(uint16_t addr, uint8_t *buf, uint16_t len)
{   
    SPI_STATUS = 1 << SPI_CMD_SWRST;
    while((SPI_STATUS & 0x01)==0);
    spi_setup_cmd_addr(addr, 16, 0, 0);
    spi_set_datalen(len << 3);
    spi_start_transaction(SPI_CMD_RD, 0);
    //spi_read_fifo((int*)buf, len << 3);

    uint8_t *p = buf; int16_t l = len;
    while (l > 0) {
        while ((((*(volatile int*) (SPI_REG_STATUS)) >> 16) & 0xFF) == 0);
        uint32_t data = *(volatile uint32_t*) (SPI_REG_RXFIFO);

        for (int i=((l > 4) ? 4 : l)-1; i>=0; i--) {
            p[i] = data & 0xFF;
            data >>= 8;
        }

        p += 4; l -= 4;
    }

    while((SPI_STATUS & 0x01)==0);

    adxl362_interface_debug_print("read_address16: addr=0x%x; *buf=0x%x; len=%d; \r\n", addr, *((unsigned*)buf), len);
    /*while((SPI_STATUS & 0x01)==0);	//wait until SPI is idle
    SPI_SPILEN= (16<<16);	//set data length to be 8 bits, address and command lengths 0 bits
    SPI_STATUS = 0x0102;		//initiate a write operation with select CS0
    while (((SPI_STATUS >> 24) & 0xFF) >= 8);	//wait until tx buffer has available place
    SPI_TXFIFO=addr<<16;

    while (len > 0) {
        while((SPI_STATUS & 0x01)==0);	//wait until SPI is idle
        SPI_SPILEN= (8<<16);	//set data length to be 8 bits, address and command lengths 0 bitsS
        SPI_STATUS=0x0101;			//initiate a read operation with select CS0
        while (((SPI_STATUS >> 16) & 0xFF) == 0);	//wait until rx buffer has available place
        *buf = (uint8_t)(SPI_RXFIFO);
        buf++; len--;
    }*/

    return 0;
}

/**
 * @brief     interface spi bus write
 * @param[in] addr is the spi register address
 * @param[in] *buf points to a data buffer
 * @param[in] len is the length of the data buffer
 * @return    status code
 *            - 0 success
 *            - 1 write failed
 * @note      none
 */
uint8_t adxl362_interface_spi_write_address16(uint16_t addr, uint8_t *buf, uint16_t len)
{
    SPI_STATUS = 1 << SPI_CMD_SWRST;
    while((SPI_STATUS & 0x01)==0);
    spi_setup_cmd_addr(addr, 16, 0, 0);
    spi_set_datalen(len << 3);
    //spi_write_fifo((int*)buf, len << 3);
    
    uint8_t *cur_pos = buf;
    for (uint16_t i=0; i<len; i+=4, cur_pos+=4) {
        while ((((*(volatile int*) (SPI_REG_STATUS)) >> 24) & 0xFF) >= 8);

        uint32_t byte0 = (i+0<len) ? cur_pos[0] : 0;
        uint32_t byte1 = (i+1<len) ? cur_pos[1] : 0;
        uint32_t byte2 = (i+2<len) ? cur_pos[2] : 0;
        uint32_t byte3 = (i+3<len) ? cur_pos[3] : 0;

        *(volatile unsigned*) (SPI_REG_TXFIFO) = (byte0 << 24) | (byte1 << 16) | (byte2 << 8) | (byte3 << 0);
    }
        
    spi_start_transaction(SPI_CMD_WR, 0);
    while((SPI_STATUS & 0x01)==0);

    adxl362_interface_debug_print("write_address16: addr=0x%x; *buf=0x%x; len=%d; \r\n", addr, *((unsigned*)buf), len);

    /*while((SPI_STATUS & 0x01)==0);	//wait until SPI is idle
    SPI_SPILEN= (16<<16);	//set data length to be 8 bits, address and command lengths 0 bits
    SPI_STATUS = 0x0102;		//initiate a write operation with select CS0
    while (((SPI_STATUS >> 24) & 0xFF) >= 8);	//wait until tx buffer has available place
    SPI_TXFIFO=addr<<16;

    while (len > 0) {
        while((SPI_STATUS & 0x01)==0);	//wait until SPI is idle
        SPI_SPILEN= (8<<16);	//set data length to be 8 bits, address and command lengths 0 bits
        SPI_STATUS = 0x0102;		//initiate a write operation with select CS0
        while (((SPI_STATUS >> 24) & 0xFF) >= 8);	//wait until tx buffer has available place
        SPI_TXFIFO=(*buf)<<24;
        buf++; len--;
    }*/

    return 0;
}

/**
 * @brief     interface delay ms
 * @param[in] ms
 * @note      none
 */
void adxl362_interface_delay_ms(uint32_t ms)
{
    uint32_t cycles = ms * 50000000 / 1000 / 2;
    __asm__ __volatile__(
        "wait_loop:\r\n"
        "addi %0, %0, -1\r\n"
        "bnez %0, wait_loop\r\n"
        :
        : "r"(cycles)
    );
}

/**
 * @brief     interface print format data
 * @param[in] fmt is the format data
 * @note      none
 */
void adxl362_interface_debug_print(const char *const fmt, ...)
{
    char buffer[256];
    int pc;
    va_list va;

    va_start(va, fmt);

    pc = vsprintf(buffer, fmt, va);

    va_end(va);
    
    for (int i=0; buffer[i] != '\0'; i++)
        uart_sendchar(buffer[i]);
    uart_wait_tx_done();
}

/**
 * @brief     interface receive callback
 * @param[in] type is the irq type
 * @note      none
 */
void adxl362_interface_receive_callback(uint8_t type)
{
    switch (type)
    {
        case ADXL362_STATUS_ERR_USER_REGS :
        {
            adxl362_interface_debug_print("adxl362: irq seu error detect.\n");
            
            break;
        }
        case ADXL362_STATUS_AWAKE :
        {
            adxl362_interface_debug_print("adxl362: irq awake.\n");
            
            break;
        }
        case ADXL362_STATUS_INACT :
        {
            adxl362_interface_debug_print("adxl362: irq inactivity.\n");
            
            break;
        }
        case ADXL362_STATUS_ACT :
        {
            adxl362_interface_debug_print("adxl362: irq activity.\n");
            
            break;
        }
        case ADXL362_STATUS_FIFO_OVERRUN :
        {
            adxl362_interface_debug_print("adxl362: irq fifo overrun.\n");
            
            break;
        }
        case ADXL362_STATUS_FIFO_WATERMARK :
        {
            adxl362_interface_debug_print("adxl362: irq fifo watermark.\n");
            
            break;
        }
        case ADXL362_STATUS_FIFO_READY :
        {
            adxl362_interface_debug_print("adxl362: irq fifo ready.\n");
            
            break;
        }
        case ADXL362_STATUS_DATA_READY :
        {
            adxl362_interface_debug_print("adxl362: irq data ready.\n");
            
            break;
        }
        default :
        {
            adxl362_interface_debug_print("adxl362: unknown code.\n");
            
            break;
        }
    }
}
