// Copyright 1986-2019 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2019.2 (win64) Build 2708876 Wed Nov  6 21:40:23 MST 2019
// Date        : Tue Apr 11 14:49:07 2023
// Host        : DESKTOP-220IK58 running 64-bit major release  (build 9200)
// Command     : write_verilog -force -mode synth_stub
//               D:/Documents/University/fpga/lab4/pulpino_students/pulpino_nexys_a7_100t/pulpino_nexys_a7_100t.srcs/sources_1/ip/xilinx_mmcm/xilinx_mmcm_stub.v
// Design      : xilinx_mmcm
// Purpose     : Stub declaration of top-level module interface
// Device      : xc7a100tcsg324-1
// --------------------------------------------------------------------------------

// This empty module with port declaration file causes synthesis tools to infer a black box for IP.
// The synthesis directives are for Synopsys Synplify support to prevent IO buffer insertion.
// Please paste the declaration into a Verilog source file or add the file as an additional source.
module xilinx_mmcm(clk_out1, locked, clk_in1)
/* synthesis syn_black_box black_box_pad_pin="clk_out1,locked,clk_in1" */;
  output clk_out1;
  output locked;
  input clk_in1;
endmodule
