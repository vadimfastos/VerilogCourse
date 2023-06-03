#ifndef TEXT_H
#define TEXT_H


#include "vga.h"


void text_init();

void text_set_pos_to_zero();

void set_text_color(color_t color);
void set_fon_color(color_t color);

void text_putchar(char symbol);

void draw_simbol(unsigned x, unsigned y, char symbol, color_t text_color, color_t fon_color);


#endif
