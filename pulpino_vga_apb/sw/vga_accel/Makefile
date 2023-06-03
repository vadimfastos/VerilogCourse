# and don't touch the rest unless you know what you're doing.
#CROSS_COMPILE ?= /tools/riscv/bin/riscv64-unknown-elf-
CROSS_COMPILE ?= riscv64-unknown-elf-
mkfile_path := $(abspath $(lastword $(MAKEFILE_LIST)))
current_dir := $(patsubst %/,%,$(dir $(mkfile_path)))

CC      =   $(CROSS_COMPILE)gcc
LD      =   $(CROSS_COMPILE)ld
OBJDUMP =   $(CROSS_COMPILE)objdump
OBJCOPY =   $(CROSS_COMPILE)objcopy
SIZE    =   $(CROSS_COMPILE)size

DFLAGS  =

ARCH = -march=rv32imc -mabi=ilp32

# Board support
BSP           = \ #board_support

BSP_INCLUDE   = \ #$(BSP)/hwlib/include

BOARD_INCLUDE = ./includes/sys_lib/inc\
	./includes/string_lib/inc\

BOOT_INCLUDE  = \

OBJS = main.o\
	kuznechik.o\
	text.o\
	./includes/sys_lib/src/spi.o\
	./includes/sys_lib/src/gpio.o\
	./includes/sys_lib/src/uart.o\
	./includes/sys_lib/src/utils.o\
	./includes/string_lib/src/qprintf.o\
	./includes/sys_lib/src/i2c.o\
	./includes/sys_lib/src/int.o\
	./includes/sys_lib/src/timer.o\
	./includes/sys_lib/src/exceptions.o\
	./accel/driver_adxl362_basic.o\
	./accel/driver_adxl362_interface.o\
	./accel/driver_adxl362.o

EMB_OBJS =  ./includes/ref/crt0.riscv.o

LDS_EMB     = ./includes/ref/link.common.ld

OUTPUT      = vga_accel
OUTPUT_EMB  = $(OUTPUT)_emb


.PHONY: all dat 
all: clean embedded dat


.PHONY: embedded
embedded: $(OUTPUT_EMB)
$(OUTPUT_EMB): $(LDS_EMB) $(EMB_OBJS) $(OBJS) $(OUTPUT_OBJ)
	${CC} ${ARCH} $(BOARD_INCLUDE:%=-I%) $(BSP_INCLUDE:%=-I%) -flto -O2 -Wl,--gc-sections -o $(OUTPUT_EMB).elf $(EMB_OBJS) -nostartfiles $(OBJS) $(OUTPUT_OBJ) -lm -T $(LDS_EMB) -lc
	${OBJCOPY} -O binary $(OUTPUT_EMB).elf $(OUTPUT_EMB).bin
	${OBJDUMP} -D $(OUTPUT_EMB).elf > disasm_emb.S
	$(SIZE) $(OUTPUT_EMB).elf

dat: embedded
	${OBJCOPY} -I elf32-little -O binary -j .vectors -j .text -j .text.__libc_init_array $(OUTPUT_EMB).elf $(OUTPUT_EMB)_text.bin
	hexdump -v -e '"%08x\n"' $(OUTPUT_EMB)_text.bin >../$(OUTPUT_EMB)_text.dat
	
	${OBJCOPY} -I elf32-little -O binary -j .preinit_array -j .init_array -j .fini_array -j .rodata -j .shbss -j .data -j .bss -j .stack -j .stab -j .stabstr $(OUTPUT_EMB).elf $(OUTPUT_EMB)_data.bin
	hexdump -v -e '"%08x\n"' $(OUTPUT_EMB)_data.bin >../$(OUTPUT_EMB)_data.dat


.PHONY: clean
clean:
	rm -f $(OBJS) $(OUTPUT_OBJ) $(DBG_OBJS) $(EMB_OBJS)
	rm -f $(OUTPUT_DBG)
	rm -f $(OUTPUT_EMB).elf $(OUTPUT_EMB).bin $(OUTPUT_EMB)_data.bin $(OUTPUT_EMB)_text.bin
	rm -f ../$(OUTPUT_EMB)_data.dat ../$(OUTPUT_EMB)_text.dat
	rm -f disasm_debug.S disasm_emb.S

%.o:	%.S
	${CC} ${ARCH} $(BOARD_INCLUDE:%=-I%) -c $^ -o $@

%.o:	%.c
	${CC} ${ARCH} $(DFLAGS) $(BOARD_INCLUDE:%=-I%) $(BSP_INCLUDE:%=-I%) $(GDBDEBUG) -c $^ -o $@
