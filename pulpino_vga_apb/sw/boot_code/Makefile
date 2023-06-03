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

OBJS = boot_code.o\
	./includes/sys_lib/src/spi.o\
	./includes/sys_lib/src/gpio.o\
	./includes/sys_lib/src/uart.o\
	./includes/sys_lib/src/utils.o\
	./includes/string_lib/src/qprintf.o\
	
EMB_OBJS =  ./includes/ref/crt0.boot.o 


LDS_BOOT    = ./includes/ref/link.boot.ld
OUTPUT      = boot_code


.PHONY: all 
all: clean bootable dat_boot 



.PHONY: bootable
bootable: $(OUTPUT)
$(OUTPUT): $(LDS_BOOT) $(EMB_OBJS) $(OBJS)
	${CC} ${ARCH} $(BOARD_INCLUDE:%=-I%) $(BOOT_INCLUDE:%=-I%) -flto -O3 -Wl,--gc-sections -o $(OUTPUT).elf $(EMB_OBJS) -nostartfiles $(OBJS) -lm -T $(LDS_BOOT) -lc
	${OBJCOPY} -O binary $(OUTPUT).elf $(OUTPUT).bin
	${OBJDUMP} -D $(OUTPUT).elf > disasm_boot.S
	$(SIZE) $(OUTPUT).elf


.PHONY: dat_boot
dat_boot: bootable
	python generate_dat.py $(OUTPUT).bin ../$(OUTPUT).dat

.PHONY: clean
clean:
	rm -f $(OBJS) $(DBG_OBJS) $(EMB_OBJS)
	rm -f $(OUTPUT_DBG)
	rm -f $(OUTPUT).elf $(OUTPUT).bin
	rm -f ../$(OUTPUT).dat
	rm -f disasm.S disasm_debug.S disasm_emb.S disasm_boot.S


%.o:	%.S
	${CC} ${ARCH} $(BOARD_INCLUDE:%=-I%) -c $^ -o $@

%.o:	%.c
	${CC} ${ARCH} $(DFLAGS) $(BOARD_INCLUDE:%=-I%) $(BOOT_INCLUDE:%=-I%) $(BSP_INCLUDE:%=-I%) $(GDBDEBUG) -c $^ -o $@
