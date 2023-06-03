onbreak {quit -f}
onerror {quit -f}

vsim -t 1ps -lib xil_defaultlib xilinx_mmcm_opt

do {wave.do}

view wave
view structure
view signals

do {xilinx_mmcm.udo}

run -all

quit -force
