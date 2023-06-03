#define __riscv__

#include <gpio.h>
#include <uart.h>
#include <utils.h>
#include <stdio.h>
#include <pulpino.h>
#include <string.h>
#include <string_lib.h>
#include <math.h>
#include <int.h>

#include "kuznechik.h"
#include "vga.h"
#include "text.h"
#include "accel/driver_adxl362_basic.h"
#include "accel/driver_adxl362_interface.h"


int accel_raw_x, accel_raw_y, accel_raw_z; // сырые данные с акселерометра
float accel_ax, accel_ay, accel_az; // ускорения
float accel_rot_x, accel_rot_y, accel_rot_z; // углы поворота
float accel_vx, accel_vy, accel_vz; // скорости
float accel_x, accel_y, accel_z; // перемещения


// Перевод из радиан в градусы
float rad2deg(float rad) {
    if (isnan(rad))
        return 720;
    float deg = rad / M_PI * 180;
    if (deg < -360)
        return -360;
    if (deg > 360)
        return 360;
    return deg;
}


// Стандартный арккосинус у нас не работает
float arccos(float x) {
    float negate = (float)(x < 0);
    x = fabs(x);
    float ret = -0.0187293;
    ret = ret * x;
    ret = ret + 0.0742610;
    ret = ret * x;
    ret = ret - 0.2121144;
    ret = ret * x;
    ret = ret + 1.5707288;
    ret = ret * sqrt(1.0-x);
    ret = ret - 2 * negate * ret;
    return negate * 3.14159265358979 + ret;
}


// Преобразование вещественного числа типа float в строку
char *float2str(float num, char *str) {
    int integer = num;
    if (num < 0)
        num = -num;
    int frac = (num - (float)integer) * 1000000;

    sprintf(str, "%3d.%06d", integer, frac);
    return str;
}


// Преобразование 16-битного числа в строку
char *hex2str(int16_t num, char *str) {
    const char digits[] = "0123456789ABCDEF";

    uint16_t x = (uint16_t)num;
    str[0] = digits[(x >> 12) & 0xF];
    str[1] = digits[(x >> 8) & 0xF];
    str[2] = digits[(x >> 4) & 0xF];
    str[3] = digits[(x >> 0) & 0xF];
    str[4] = 0;
    return str;
}


// Получение и обработка данных с акселерометра
void accel_handler() {
    const float g = 9.8;

    // Считывем данные с акселерометра
    int16_t raw[3]; float a[3];
    adxl362_interface_delay_ms(10);
    adxl362_basic_read(raw, a);

    // Получаем значения ускорений по каждой оси
    int raw_x = raw[0], raw_y = raw[1], raw_z = raw[2];
    float ax = a[0], ay = a[1], az = a[2];
    ax *= g ; ay *= g; az *= g;
    
    // Расчитываем углы поворота
    float rot_x, rot_y, rot_z;
    /*rot_x = atan(ax / hypot(ay, az));
    rot_y = atan(ay / hypot(ax, az));
    rot_z = atan(az / hypot(ax, ay));*/

    float aa = sqrt(ax*ax + ay*ay + az*az);
    float cosx = ax / aa;
    float cosy = ay / aa;
    float cosz = az / aa;
    rot_x = arccos(cosx);
    rot_y = arccos(cosy);
    rot_z = arccos(cosz);

    /*char obuf[256];
    adxl362_interface_debug_print("Acceleration: %s\r\n", float2str(aa, obuf));
    adxl362_interface_debug_print("Cos of rotation X, angle: %s\r\n", float2str(cosx, obuf));
    adxl362_interface_debug_print("Cos of rotation Y, angle: %s\r\n", float2str(cosy, obuf));
    adxl362_interface_debug_print("Cos of rotation Z, angle: %s\r\n", float2str(cosz, obuf));
    adxl362_interface_debug_print("Rotation X, angle: %s\r\n", float2str(rot_x, obuf));
    adxl362_interface_debug_print("Rotation Y, angle: %s\r\n", float2str(rot_y, obuf));
    adxl362_interface_debug_print("Rotation Z, angle: %s\r\n", float2str(rot_z, obuf));*/

    rot_x = rad2deg(rot_x);
    rot_y = rad2deg(rot_y);
    rot_z = rad2deg(rot_z);

    // Рассчитываем скорости
    float vx = 0, vy = 0, vz = 0;

    // Рассчитываем перемещения
    float x = 0, y = 0, z = 0;

    // Записываем значения
    accel_raw_x = raw_x; accel_raw_y = raw_y; accel_raw_z = raw_z; 
    accel_ax = ax; accel_ay = ay; accel_az = az;
    accel_rot_x = rot_x; accel_rot_y = rot_y; accel_rot_z = rot_z;
    accel_vx = vx; accel_vy = vy; accel_vz = vz;
    accel_x = x; accel_y = y; accel_z = z;
}


int main() {

    int_disable();
    uart_set_cfg(0, 27); // 115200 baud UART, no parity (50MHz CPU)
    vga_init();
    text_init();
    adxl362_basic_init();

    // принимаем блок данных по UART, шифруем и выдаём ответ
    /* 
    kuznechik_init();
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
    }*/

    
    uint8_t color = 0;
    for (unsigned y=0; y<480; y++)
        for (unsigned x=0; x<640; x++) {
            draw_pixel(x, y, color);
            color++;
        }
    //vga_clear_screen(COLOR_BLACK);

    
    while (1) {
        accel_handler();
        
        // Копируем данные
        int raw_x = accel_raw_x, raw_y = accel_raw_y, raw_z = accel_raw_z;
        float ax = accel_ax, ay = accel_ay, az = accel_az;
        float rot_x = accel_rot_x, rot_y = accel_rot_y, rot_z = accel_rot_z;
        float vx = accel_vx, vy = accel_vy, vz = accel_vz;
        float x = accel_x, y = accel_y, z = accel_z;

        // Начинаем выводить сначала экрана
        text_set_pos_to_zero();

        // Выводим сообщения
        char obuf[256];
        set_text_color(COLOR_WHITE);
        printf("Hello, world!\r\nThis is accelerometer example\r\n");
        
        set_text_color(COLOR_BLUE);
        printf("RAW data from axis X: 0x%s\r\n", hex2str(raw_x, obuf));
        printf("RAW data from axis Y: 0x%s\r\n", hex2str(raw_y, obuf));
        printf("RAW data from axis Z: 0x%s\r\n", hex2str(raw_z, obuf));

        set_text_color(COLOR_GREEN);
        printf("Proper acceleration on axis X, m/s^2: %s\r\n", float2str(ax, obuf));
        printf("Proper acceleration on axis Y, m/s^2: %s\r\n", float2str(ay, obuf));
        printf("Proper acceleration on axis Z, m/s^2: %s\r\n", float2str(az, obuf));

        set_text_color(COLOR_RED);
        printf("Rotate axis X, degrees: %s\r\n", float2str(rot_x, obuf));
        printf("Rotate axis Y, degrees: %s\r\n", float2str(rot_y, obuf));
        printf("Rotate axis Z, degrees: %s\r\n", float2str(rot_z, obuf));

        /*set_text_color(COLOR_RED);
        printf("Velocity on axis X, m/s: %s\r\n", float2str(vx, obuf));
        printf("Velocity on axis Y, m/s: %s\r\n", float2str(vy, obuf));
        printf("Velocity on axis Z, m/s: %s\r\n", float2str(vz, obuf));*/

        /*set_text_color(COLOR_RED);
        printf("X, m: %s\r\n", float2str(x, obuf));
        printf("Y, m: %s\r\n", float2str(y, obuf));
        printf("Z, m: %s\r\n", float2str(z, obuf));*/
    }

    adxl362_basic_deinit();
    while (1) ;
    return 0;
}


int putchar(int character) {
	//uart_sendchar(character);
	text_putchar(character);
    return character;
}
