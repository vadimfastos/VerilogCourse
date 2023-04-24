module pulpino_arty_a7
 #(parameter DATA_RAM_INIT_FILE   = "test_sw_emb_data.dat",
   parameter INSTR_RAM_INIT_FILE  = "test_sw_emb_text.dat") 
 (

  input CLK100MHZ,

  input [3:0] sw,

  output led0_b,
  output led0_g,
  output led0_r,
  output led1_b,
  output led1_g,
  output led1_r,
  output led2_b,
  output led2_g,
  output led2_r,
  output led3_b,
  output led3_g,
  output led3_r,

  output [3:0] led,

  input [3:0] btn,

  inout [7:0] ja,
  // inout [7:0] jb,
  // inout [7:0] jc,
  // inout [7:0] jd,

  output uart_rxd_out,
  input  uart_txd_in,

  inout ck_io0,
  inout ck_io1,
  inout ck_io2,
  inout ck_io3,
  inout ck_io4,
  inout ck_io5,
  inout ck_io6,
  inout ck_io7,
  // ck_io8,
  // ck_io9,
  // ck_io10,
  // ck_io11,
  // ck_io12,
  // ck_io13,
  // ck_io26,
  // ck_io27,
  // ck_io28,
  // ck_io29,
  // ck_io30,
  // ck_io31,
  // ck_io32,
  // ck_io33,
  // ck_io34,
  // ck_io35,
  // ck_io36,
  // ck_io37,
  // ck_io38,
  // ck_io39,
  // ck_io40,
  // ck_io41,
  // ck_a0,
  // ck_a1,
  // ck_a2,
  // ck_a3,
  // ck_a4,
  // ck_a5,
  // ck_a6,
  // ck_a7,
  // ck_a8,
  // ck_a9,
  // ck_a10,
  // ck_a11,

  //ck_miso,
  //ck_mosi,
  //ck_sck,
  //ck_ss,

  inout ck_scl,
  inout ck_sda,
  output scl_pup,
  output sda_pup,

  //ck_ioa
  input ck_rst

);

  // Clock and reset +
  logic clk;
  logic locked;

  xilinx_mmcm clk_gen
  (
    .clk_in1  (CLK100MHZ),
    .clk_out1 (clk),
    .locked   (locked)
  );


  logic rst_n;
  assign rst_n = (locked & ck_rst) ? 1'b1 : 1'b0;


  //SPI Slave
  logic       spi_clk_i;
  logic       spi_cs_i;
  logic [1:0] spi_mode_o;
  logic       spi_sdo0_o;
  logic       spi_sdo1_o;
  logic       spi_sdo2_o;
  logic       spi_sdo3_o;
  logic       spi_sdi0_i;
  logic       spi_sdi1_i;
  logic       spi_sdi2_i;
  logic       spi_sdi3_i;



  assign spi_clk_i  = 1'b0;
  assign spi_cs_i   = 1'b0;
  assign spi_sdi0_i = 1'b0;
  assign spi_sdi1_i = 1'b0;
  assign spi_sdi2_i = 1'b0;
  assign spi_sdi3_i = 1'b0;



  //SPI Master
  logic       spi_master_clk_o;
  logic       spi_master_csn0_o;
  logic       spi_master_csn1_o;
  logic       spi_master_csn2_o;
  logic       spi_master_csn3_o;
  logic [1:0] spi_master_mode_o;
  logic       spi_master_sdo0_o;
  logic       spi_master_sdo1_o;
  logic       spi_master_sdo2_o;
  logic       spi_master_sdo3_o;
  logic       spi_master_sdi0_i;
  logic       spi_master_sdi1_i;
  logic       spi_master_sdi2_i;
  logic       spi_master_sdi3_i;


  assign spi_master_sdi0_i = 1'b0;
  assign spi_master_sdi1_i = 1'b0;
  assign spi_master_sdi2_i = 1'b0;
  assign spi_master_sdi3_i = 1'b0;



  // I2C +
  logic scl_pad_i;
  logic scl_pad_o;
  logic scl_padoen_o;
  logic sda_pad_i;
  logic sda_pad_o;
  logic sda_padoen_o;

  assign scl_pup = 1'bz;
  assign sda_pup = 1'bz;

  assign ck_scl = scl_padoen_o ? scl_pad_o : 1'bz;
  assign ck_sda = sda_padoen_o ? sda_pad_o : 1'bz;

  assign scl_pad_i = ck_scl;
  assign sda_pad_i = ck_sda;


  // UART +
  logic uart_tx;
  assign uart_rxd_out = uart_tx;

  logic uart_rx;
  assign uart_rx = uart_txd_in;


  // GPIO

  localparam GPIO_DIR_IN  =  0;
  localparam GPIO_DIR_OUT =  1;


  logic [31:0] gpio_in;
  logic [31:0] gpio_out;
  logic [31:0] gpio_dir;


  assign gpio_in[3:0] = btn;
  assign gpio_in[7:4] = sw;

  assign led = gpio_out[11:8];
  
  assign led0_b = gpio_out[12];
  assign led0_g = gpio_out[13];
  assign led0_r = gpio_out[14];
  assign led1_b = gpio_out[15];
  assign led1_g = gpio_out[16];
  assign led1_r = gpio_out[17];
  assign led2_b = gpio_out[18];
  assign led2_g = gpio_out[19];
  assign led2_r = gpio_out[20];
  assign led3_b = gpio_out[21];
  assign led3_g = gpio_out[22];
  assign led3_r = gpio_out[23];


  assign ck_io0 = (gpio_dir[24] == GPIO_DIR_OUT) ? gpio_out[24] : 1'bz;
  assign gpio_in[24] = ck_io0;

  assign ck_io1 = (gpio_dir[25] == GPIO_DIR_OUT) ? gpio_out[25] : 1'bz;
  assign gpio_in[25] = ck_io1;

  assign ck_io2 = (gpio_dir[26] == GPIO_DIR_OUT) ? gpio_out[26] : 1'bz;
  assign gpio_in[26] = ck_io2;

  assign ck_io3 = (gpio_dir[27] == GPIO_DIR_OUT) ? gpio_out[27] : 1'bz;
  assign gpio_in[27] = ck_io3;

  assign ck_io4 = (gpio_dir[28] == GPIO_DIR_OUT) ? gpio_out[28] : 1'bz;
  assign gpio_in[28] = ck_io4;

  assign ck_io5 = (gpio_dir[29] == GPIO_DIR_OUT) ? gpio_out[29] : 1'bz;
  assign gpio_in[29] = ck_io5;

  assign ck_io6 = (gpio_dir[30] == GPIO_DIR_OUT) ? gpio_out[30] : 1'bz;
  assign gpio_in[30] = ck_io6;

  assign ck_io7 = (gpio_dir[31] == GPIO_DIR_OUT) ? gpio_out[31] : 1'bz;
  assign gpio_in[31] = ck_io7;


  // JTAG signals +
  logic tck_i;
  logic trstn_i;
  logic tms_i;
  logic tdi_i;
  logic tdo_o;

  assign tck_i   = ja[3];
  assign trstn_i = ja[4];
  assign tms_i   = ja[0];
  assign tdi_i   = ja[1];
  assign ja[2]   = tdo_o;
  
  assign ja[5] = '0;
  assign ja[6] = '0;
  assign ja[7] = '0;


pulpino_top
  #(
    .USE_ZERO_RISCY (1),
    .RISCY_RV32F    (0),
    .ZERO_RV32M     (1),
    .ZERO_RV32E     (0),
    .DATA_RAM_INIT_FILE   (DATA_RAM_INIT_FILE),
    .INSTR_RAM_INIT_FILE  (INSTR_RAM_INIT_FILE)
  )
  pulpino_inst
  (
    // Clock and Reset
    .clk   (clk),
    .rst_n (rst_n),

    .clk_sel_i        (1'b0),
    .clk_standalone_i (1'b0),
    .testmode_i       (1'b0),
    .fetch_enable_i   (1'b1),
    .scan_enable_i    (1'b0),

    //SPI Slave
    .spi_clk_i  (spi_clk_i) /*verilator clocker*/,
    .spi_cs_i   (spi_cs_i) /*verilator clocker*/,
    .spi_mode_o (spi_mode_o),
    .spi_sdo0_o (spi_sdo0_o),
    .spi_sdo1_o (spi_sdo1_o),
    .spi_sdo2_o (spi_sdo2_o),
    .spi_sdo3_o (spi_sdo3_o),
    .spi_sdi0_i (spi_sdi0_i),
    .spi_sdi1_i (spi_sdi1_i),
    .spi_sdi2_i (spi_sdi2_i),
    .spi_sdi3_i (spi_sdi3_i),

    //SPI Master
    .spi_master_clk_o  (spi_master_clk_o),
    .spi_master_csn0_o (spi_master_csn0_o),
    .spi_master_csn1_o (spi_master_csn1_o),
    .spi_master_csn2_o (spi_master_csn2_o),
    .spi_master_csn3_o (spi_master_csn3_o),
    .spi_master_mode_o (spi_master_mode_o),
    .spi_master_sdo0_o (spi_master_sdo0_o),
    .spi_master_sdo1_o (spi_master_sdo1_o),
    .spi_master_sdo2_o (spi_master_sdo2_o),
    .spi_master_sdo3_o (spi_master_sdo3_o),
    .spi_master_sdi0_i (spi_master_sdi0_i),
    .spi_master_sdi1_i (spi_master_sdi1_i),
    .spi_master_sdi2_i (spi_master_sdi2_i),
    .spi_master_sdi3_i (spi_master_sdi3_i),

    .scl_pad_i    (scl_pad_i),
    .scl_pad_o    (scl_pad_o),
    .scl_padoen_o (scl_padoen_o),
    .sda_pad_i    (sda_pad_i),
    .sda_pad_o    (sda_pad_o),
    .sda_padoen_o (sda_padoen_o),

    .uart_tx  (uart_tx), // o
    .uart_rx  (uart_rx), // i
    .uart_rts (),
    .uart_dtr (),
    .uart_cts (),
    .uart_dsr (),

    .gpio_in     (gpio_in),
    .gpio_out    (gpio_out),
    .gpio_dir    (gpio_dir),
    .gpio_padcfg (),

    // JTAG signals
    .tck_i   (tck_i),
    .trstn_i (trstn_i),
    .tms_i   (tms_i),
    .tdi_i   (tdi_i),
    .tdo_o   (tdo_o),

    // PULPino specific pad config
    .pad_cfg_o (),
    .pad_mux_o ()
  );



endmodule