module pulpino_nexys_a7_tb ();

  logic        clk100mhz;
  logic [15:0] sw;
  logic [15:0] led;
  logic        cpu_resetn;
  tri   [7:0]  ja;
  logic        uart_rxd_out;
  logic        uart_txd_in;


  // Clock generation
  initial begin
    clk100mhz = 0;

    forever
      #5 clk100mhz = ~clk100mhz;
  end

  // Reset generation
  initial begin
    cpu_resetn = 1;
    #10
    cpu_resetn = 0;
    #100
    cpu_resetn = 1;
  end

  // Buttons and switches
  initial begin
    sw  = '0;
    uart_txd_in = 1'b1;
  end



  // JTAG placeholder
  assign ja[3] = 1'b0;
  assign ja[4] = 1'b1;
  assign ja[0] = 1'b0;
  assign ja[1] = 1'b0;


  pulpino_nexys_a7
  //#(.DATA_RAM_INIT_FILE  (""),
  //  .INSTR_RAM_INIT_FILE (""))
  UUT
  (
    .clk100mhz    (clk100mhz),
    .cpu_resetn   (cpu_resetn),
    .sw           (sw),
    .led          (led),
    .ja           (ja),
    .uart_rxd_out (uart_rxd_out),
    .uart_txd_in  (uart_txd_in)
  );


endmodule
