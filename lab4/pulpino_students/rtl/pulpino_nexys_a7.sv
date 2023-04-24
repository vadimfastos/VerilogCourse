module pulpino_nexys_a7
 #(parameter DATA_RAM_INIT_FILE   = "test_sw_emb_data.dat",
   parameter INSTR_RAM_INIT_FILE  = "test_sw_emb_text.dat")
 (
  input logic         clk100mhz,
  input logic         cpu_resetn,

  input  logic [15:0] sw,
  output logic [15:0] led,

  inout  logic [7:0]  ja,

  output logic        uart_rxd_out,
  input  logic        uart_txd_in
);

  // Clock and reset +
  logic clk;
  logic locked;

  xilinx_mmcm clk_gen
  (
    .clk_in1  (clk100mhz),
    .clk_out1 (clk),
    .locked   (locked)
  );


  logic rst_n;
  assign rst_n = (locked & cpu_resetn) ? 1'b1 : 1'b0;


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


  assign gpio_in[15:0] = sw;
  assign gpio_in[31:16] = '0;

  assign led = gpio_out[31:16];


  // Example for gpio ports
  // assign ck_io0 = (gpio_dir[24] == GPIO_DIR_OUT) ? gpio_out[24] : 1'bz;
  // assign gpio_in[24] = ck_io0;

  // assign ck_io1 = (gpio_dir[25] == GPIO_DIR_OUT) ? gpio_out[25] : 1'bz;
  // assign gpio_in[25] = ck_io1;

  // assign ck_io2 = (gpio_dir[26] == GPIO_DIR_OUT) ? gpio_out[26] : 1'bz;
  // assign gpio_in[26] = ck_io2;

  // assign ck_io3 = (gpio_dir[27] == GPIO_DIR_OUT) ? gpio_out[27] : 1'bz;
  // assign gpio_in[27] = ck_io3;

  // assign ck_io4 = (gpio_dir[28] == GPIO_DIR_OUT) ? gpio_out[28] : 1'bz;
  // assign gpio_in[28] = ck_io4;

  // assign ck_io5 = (gpio_dir[29] == GPIO_DIR_OUT) ? gpio_out[29] : 1'bz;
  // assign gpio_in[29] = ck_io5;

  // assign ck_io6 = (gpio_dir[30] == GPIO_DIR_OUT) ? gpio_out[30] : 1'bz;
  // assign gpio_in[30] = ck_io6;

  // assign ck_io7 = (gpio_dir[31] == GPIO_DIR_OUT) ? gpio_out[31] : 1'bz;
  // assign gpio_in[31] = ck_io7;


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
