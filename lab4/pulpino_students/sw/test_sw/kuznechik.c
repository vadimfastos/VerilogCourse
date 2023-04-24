#include "kuznechik.h"
#include <pulpino.h>


volatile struct KUZNECHIK_REGS * KUZNECHIK;


// Инициализация модуля
void kuznechik_init() {
    CGREG |= (1 << CGKUZ); // Включаем тактирование
    KUZNECHIK = (struct KUZNECHIK_REGS*)(KUZNECHIK_BASE_ADDR);
    KUZNECHIK->RST = 1; //  Делаем сброс устройства
}


// Зашифровать блок данных с помощью шифра Кузнечик
bool kuznechik_process_data_block(const void *src, void *dst) {

    /* регистры устройства
    volatile uint32_t *reg_rst = (uint32_t*)(KUZNECHIK_BASE_ADDR + KUZNECHIK_ADDR_RST);
    volatile uint32_t *reg_req = (uint32_t*)(KUZNECHIK_BASE_ADDR + KUZNECHIK_ADDR_REQ);
    volatile uint32_t *reg_ack = (uint32_t*)(KUZNECHIK_BASE_ADDR + KUZNECHIK_ADDR_ACK);
    const volatile uint32_t *reg_valid = (const uint32_t*)(KUZNECHIK_BASE_ADDR + KUZNECHIK_ADDR_VALID);
    const volatile uint32_t *reg_busy = (const uint32_t*)(KUZNECHIK_BASE_ADDR + KUZNECHIK_ADDR_BUSY);
    volatile uint32_t *reg_in = (uint32_t*)(KUZNECHIK_BASE_ADDR + KUZNECHIK_ADDR_DATA_IN_0);
    const volatile  uint32_t *reg_out = (const uint32_t*)(KUZNECHIK_BASE_ADDR + KUZNECHIK_ADDR_DATA_OUT_0);*/
    
    // мы не можем ждать освобождения модуля бесконечно
    const int max_wait_cycles = 16000;

    // ждём освобождения модуля шифрования
    int cur_wait_cycles = max_wait_cycles;
    while (cur_wait_cycles!=0 && KUZNECHIK->BUSY!=0)
        cur_wait_cycles--;
    if (cur_wait_cycles == 0) {
        KUZNECHIK->RST = 1;
        return false;
    }

    // записываем исходные данные
    uint32_t *src_data = (uint32_t*)src;
    for (int i=0; i<KUZNECHIK_BLOCK_LEN/4; i++)
        KUZNECHIK->DATA_IN[i] = src_data[i];
    KUZNECHIK->REQ = 1;

    // ждём завершения операции
    cur_wait_cycles = max_wait_cycles;
    while (cur_wait_cycles!=0 && KUZNECHIK->VALID==0)
        cur_wait_cycles--;
    if (cur_wait_cycles == 0) {
        KUZNECHIK->RST = 1;
        return false;
    }

    // считываем зашифрованные данные из регистра устройства
    uint32_t *dst_data = (uint32_t*)dst;
    for (int i=0; i<KUZNECHIK_BLOCK_LEN/4; i++)
        dst_data[i] = KUZNECHIK->DATA_OUT[i];
    KUZNECHIK->ACK = 1;
    return true;
}
