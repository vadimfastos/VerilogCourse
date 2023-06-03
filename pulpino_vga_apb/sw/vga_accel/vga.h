#ifndef VGA_H
#define VGA_H


#include <stdint.h>
#include <pulpino.h>


#define VGA_FRAMEBUFFER_ADDR 0x1A200000
#define VGA_SCREEN_WIDTH 640
#define VGA_SCREEN_HEIGHT 480


/* Тип данных для хранения цвета пикселей, для хранения цвета одного пикселя ипользуется 1 байт.
    Биты 1:0 - синий цвет (R)
    Биты 3:2 - зелёный цвет (G)
    Биты 5:4 - красный цвет (B)
    Биты 7:6 - не используются
*/
typedef unsigned char color_t;

static inline color_t rgb2color(unsigned r, unsigned g, unsigned b) {
    r = r & 0x03;
    g = g & 0x03;
    b = b & 0x03;
    return (r<<4) | (g<<2) | b;
}

#define COLOR_RED 0x30
#define COLOR_GREEN 0x0C
#define COLOR_BLUE 0x03
#define COLOR_BLACK 0x00
#define COLOR_WHITE 0x3F


// Инициализация модуля VGA - включение тактирования
static inline void vga_init() {
    CGREG |= (1 << CGVGA);
}


// Вывод пикселя на экран, медленная реализация
/*static inline void draw_pixel(unsigned x, unsigned y, color_t color) {
    uint32_t *framebuffer = (uint32_t *)(VGA_FRAMEBUFFER_ADDR);

    unsigned pixel_number = y * VGA_SCREEN_WIDTH + x;
    unsigned pixel_index = pixel_number >> 2;
    unsigned pixel_offset = (pixel_number && 0x03) * 8;

    uint32_t pixels = framebuffer[pixel_index];
    pixels &= ~(0xFF << pixel_offset);
    pixels |= (uint32_t)color << pixel_offset;
    framebuffer[pixel_index] = pixels;
}*/


// Вывод пикселя на экран, ускоренная реализация
static inline void draw_pixel(unsigned x, unsigned y, color_t color) {
    uint32_t *framebuffer = (uint32_t *)(VGA_FRAMEBUFFER_ADDR);

    unsigned pixel_index, pixel_offset;
    #if VGA_SCREEN_WIDTH == 640
        /*
        unsigned pixel_number = y * VGA_SCREEN_WIDTH + x;
        unsigned pixel_index = pixel_number >> 2;
        unsigned pixel_offset = (pixel_number && 0x03) * 8;
        
        y*640 + x = y*5*128 + x = (y*4+y)*128 + x = (((y<<2)+y)<<7) + x
        (y*640 + x) >> 2 = ((((y<<2)+y)<<7) + x) >> 2 = (((y<<2)+y)<<5) + (x>>2)
        ((y*640 + x) & 0x03) * 8 = (x & 0x03) << 3
        */

        pixel_index = ( ((y<<2) + y) << 5 ) + (x>>2);
        pixel_offset = (x & 0x03) << 3;
    #else
        #error Change screen width or compute formula
    #endif

    uint32_t pixels = framebuffer[pixel_index];
    pixels &= ~(0xFF << pixel_offset);
    pixels |= (uint32_t)color << pixel_offset;
    framebuffer[pixel_index] = pixels;
}


// Заливка экрана выбранным цветом
static inline void vga_clear_screen(color_t color) {
    unsigned c = (unsigned)color;
    unsigned data = (c << 24) | (c << 16) | (c << 8) | (c << 0);

    uint32_t *framebuffer = (uint32_t *)(VGA_FRAMEBUFFER_ADDR);
    for (unsigned i=0; i<VGA_SCREEN_WIDTH*VGA_SCREEN_HEIGHT/4; i++)
        framebuffer[i] = data;
}


#endif
