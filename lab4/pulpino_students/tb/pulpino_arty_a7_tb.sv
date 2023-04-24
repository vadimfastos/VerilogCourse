module pulpino_arty_a7_tb ();

  logic CLK100MHZ;

  logic [3:0] sw;

  logic led0_b;
  logic led0_g;
  logic led0_r;
  logic led1_b;
  logic led1_g;
  logic led1_r;
  logic led2_b;
  logic led2_g;
  logic led2_r;
  logic led3_b;
  logic led3_g;
  logic led3_r;

  logic [3:0] led;

  logic [3:0] btn;

  tri [7:0] ja;

  logic uart_rxd_out;
  logic uart_txd_in;

  tri ck_io0;
  tri ck_io1;
  tri ck_io2;
  tri ck_io3;
  tri ck_io4;
  tri ck_io5;
  tri ck_io6;
  tri ck_io7;

  tri ck_scl;
  tri ck_sda;
  logic scl_pup;
  logic sda_pup;

  logic ck_rst;

  // Clock generation
  initial begin
    CLK100MHZ = 0;

    forever 
      #5 CLK100MHZ = ~CLK100MHZ;
  end

  // Reset generation
  initial begin 
    ck_rst = 1;
    #10
    ck_rst = 0;
    #100
    ck_rst = 1;
  end

  // Buttons and switches
  initial begin
    sw  = 4'b0000;
    btn = 4'b0000;

    uart_txd_in = 1'b1;
  end



  // JTAG placeholder
  assign ja[3] = 1'b0;
  assign ja[4] = 1'b1;
  assign ja[0] = 1'b0;
  assign ja[1] = 1'b0;


  pulpino_arty_a7
  #(/*.DATA_RAM_INIT_FILE  (""),
    .INSTR_RAM_INIT_FILE ("")*/) 
  UUT
  (.*);

endmodule