vlib work
vlib riviera

vlib riviera/xpm
vlib riviera/xil_defaultlib

vmap xpm riviera/xpm
vmap xil_defaultlib riviera/xil_defaultlib

vlog -work xpm  -sv2k12 "+incdir+../../../ipstatic" \
"C:/Programs/Xilinx/Vivado/2019.2/data/ip/xpm/xpm_cdc/hdl/xpm_cdc.sv" \

vcom -work xpm -93 \
"C:/Programs/Xilinx/Vivado/2019.2/data/ip/xpm/xpm_VCOMP.vhd" \

vlog -work xil_defaultlib  -v2k5 "+incdir+../../../ipstatic" \
"../../../../pulpino_nexys_a7_100t.srcs/sources_1/ip/xilinx_mmcm/xilinx_mmcm_clk_wiz.v" \
"../../../../pulpino_nexys_a7_100t.srcs/sources_1/ip/xilinx_mmcm/xilinx_mmcm.v" \

vlog -work xil_defaultlib \
"glbl.v"

