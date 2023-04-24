## Memory
#create_ip -name blk_mem_gen -vendor xilinx.com -library ip -module_name xilinx_mem_8192x32
#set_property -dict [list CONFIG.Memory_Type {Single_Port_RAM} CONFIG.Use_Byte_Write_Enable {true} CONFIG.Byte_Size {8} CONFIG.Write_Width_A {32} CONFIG.Write_Depth_A {8192} CONFIG.Register_PortA_Output_of_Memory_Primitives {false} CONFIG.Use_RSTA_Pin {true}] [get_ips xilinx_mem_8192x32]

## MMCM
create_ip -name clk_wiz -vendor xilinx.com -library ip -module_name xilinx_mmcm
set_property -dict [list CONFIG.CLKOUT1_REQUESTED_OUT_FREQ {50.000} CONFIG.USE_RESET {false} CONFIG.MMCM_CLKOUT0_DIVIDE_F {20.000} CONFIG.CLKOUT1_JITTER {151.636}] [get_ips xilinx_mmcm]