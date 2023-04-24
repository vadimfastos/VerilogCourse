onbreak {quit -force}
onerror {quit -force}

asim -t 1ps +access +r +m+xilinx_mmcm -L xpm -L xil_defaultlib -L unisims_ver -L unimacro_ver -L secureip -O5 xil_defaultlib.xilinx_mmcm xil_defaultlib.glbl

do {wave.do}

view wave
view structure

do {xilinx_mmcm.udo}

run -all

endsim

quit -force
