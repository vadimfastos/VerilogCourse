module kuznechik_cipher_apb_wrapper
#(
  parameter APB_ADDR_WIDTH = 12,  // APB slaves are 4KB by default
  parameter APB_DATA_WIDTH = 32
)
(
  input  logic                      clk_i,
  input  logic                      rstn_i,
  input  logic [APB_ADDR_WIDTH-1:0] apb_paddr_i,
  input  logic [APB_DATA_WIDTH-1:0] apb_pwdata_i,
  input  logic                      apb_pwrite_i,
  input  logic                      apb_psel_i,
  input  logic                      apb_penable_i,
  output logic [APB_DATA_WIDTH-1:0] apb_prdata_o,
  output logic                      apb_pready_o,
  output logic                      apb_pslverr_o
);

  // Local declarations

  localparam ADDR_RST    = 12'h0;
  localparam ADDR_REQ    = 12'h4;
  localparam ADDR_ACK    = 12'h8;

  localparam ADDR_VALID   = 12'hc;
  localparam ADDR_BUSY    = 12'h10;

  localparam ADDR_DATA_IN_0 = 12'h14;
  localparam ADDR_DATA_IN_1 = 12'h18;
  localparam ADDR_DATA_IN_2 = 12'h1c;
  localparam ADDR_DATA_IN_3 = 12'h20;

  localparam ADDR_DATA_OUT_0 = 12'h24;
  localparam ADDR_DATA_OUT_1 = 12'h28;
  localparam ADDR_DATA_OUT_2 = 12'h2c;
  localparam ADDR_DATA_OUT_3 = 12'h30;

  logic                      apb_write;
  logic                      apb_read;

  logic                      apb_sel_rst;
  logic                      apb_sel_req;
  logic                      apb_sel_ack;

  logic                      apb_sel_valid;
  logic                      apb_sel_busy;

  logic                      apb_sel_data_in_0;
  logic                      apb_sel_data_in_1;
  logic                      apb_sel_data_in_2;
  logic                      apb_sel_data_in_3;

  logic                      apb_sel_data_out_0;
  logic                      apb_sel_data_out_1;
  logic                      apb_sel_data_out_2;
  logic                      apb_sel_data_out_3;

  logic                      cipher_rstn;

  // From APB regs to cipher
  logic                      regs2cipher_req;
  logic                      regs2cipher_ack;
  logic              [127:0] regs2cipher_data_in;

  // From cipher to APB regs
  logic                      cipher2regs_busy;
  logic                      cipher2regs_valid;
  logic              [127:0] cipher2regs_data_out;

  logic                      ctrl_rst_ff;
  logic                      ctrl_rst_en;
  logic                      ctrl_rst_next;

  logic                      ctrl_req_ff;
  logic                      ctrl_req_en;
  logic                      ctrl_req_next;

  logic                      ctrl_ack_ff;
  logic                      ctrl_ack_en;
  logic                      ctrl_ack_next;

  logic [APB_DATA_WIDTH-1:0] data_in_0_ff;
  logic [APB_DATA_WIDTH-1:0] data_in_0_next;
  logic                      data_in_0_en;

  logic [APB_DATA_WIDTH-1:0] data_in_1_ff;
  logic [APB_DATA_WIDTH-1:0] data_in_1_next;
  logic                      data_in_1_en;

  logic [APB_DATA_WIDTH-1:0] data_in_2_ff;
  logic [APB_DATA_WIDTH-1:0] data_in_2_next;
  logic                      data_in_2_en;

  logic [APB_DATA_WIDTH-1:0] data_in_3_ff;
  logic [APB_DATA_WIDTH-1:0] data_in_3_next;
  logic                      data_in_3_en;

  logic [APB_DATA_WIDTH-1:0] apb_dout_ff;
  logic [APB_DATA_WIDTH-1:0] apb_dout_next;
  logic                      apb_dout_en;

  logic                      apb_ready_ff;
  logic                      apb_ready_next;
  logic                      apb_ready_en;

  logic                      apb_err_ff;
  logic                      apb_err_next;
  logic                      apb_err_en;


  //////////////////////////
  // APB decoding         //
  //////////////////////////

  assign apb_write          = apb_psel_i & apb_pwrite_i;
  assign apb_read           = apb_psel_i & ~apb_pwrite_i;

  assign apb_sel_rst        = (apb_paddr_i == ADDR_RST);
  assign apb_sel_req        = (apb_paddr_i == ADDR_REQ);
  assign apb_sel_ack        = (apb_paddr_i == ADDR_ACK);

  assign apb_sel_valid      = (apb_paddr_i == ADDR_VALID);
  assign apb_sel_busy       = (apb_paddr_i == ADDR_BUSY);

  assign apb_sel_data_in_0  = (apb_paddr_i == ADDR_DATA_IN_0);
  assign apb_sel_data_in_1  = (apb_paddr_i == ADDR_DATA_IN_1);
  assign apb_sel_data_in_2  = (apb_paddr_i == ADDR_DATA_IN_2);
  assign apb_sel_data_in_3  = (apb_paddr_i == ADDR_DATA_IN_3);

  assign apb_sel_data_out_0 = (apb_paddr_i == ADDR_DATA_OUT_0);
  assign apb_sel_data_out_1 = (apb_paddr_i == ADDR_DATA_OUT_1);
  assign apb_sel_data_out_2 = (apb_paddr_i == ADDR_DATA_OUT_2);
  assign apb_sel_data_out_3 = (apb_paddr_i == ADDR_DATA_OUT_3);

  //////////////////////////
  // Control register     //
  //////////////////////////

  // RST bit

  assign ctrl_rst_en = (apb_write & apb_sel_rst);

  assign ctrl_rst_next = apb_pwdata_i[0];

  always_ff @(posedge clk_i or negedge rstn_i)
  if (~rstn_i)
    ctrl_rst_ff <= '0;
  else if (ctrl_rst_en)
    ctrl_rst_ff <= ctrl_rst_next;


  // REQ bit

  assign ctrl_req_en = (apb_write & apb_sel_req)
                     | ctrl_req_ff;

  assign ctrl_req_next = (apb_write & apb_sel_req) ? apb_pwdata_i[0]
                       :                             '0;

  always_ff @(posedge clk_i or negedge rstn_i)
  if (~rstn_i)
    ctrl_req_ff <= '0;
  else if (ctrl_req_en)
    ctrl_req_ff <= ctrl_req_next;


  // ACK bit

  assign ctrl_ack_en = (apb_write & apb_sel_ack)
                     | ctrl_ack_ff;

  assign ctrl_ack_next = (apb_write & apb_sel_ack) ? apb_pwdata_i[0]
                       :                             '0;

  always_ff @(posedge clk_i or negedge rstn_i)
  if (~rstn_i)
    ctrl_ack_ff <= '0;
  else if (ctrl_ack_en)
    ctrl_ack_ff <= ctrl_ack_next;


  //////////////////////////
  // Data in registers    //
  //////////////////////////

  // Data in 0

  assign data_in_0_en = apb_write & apb_sel_data_in_0;

  assign data_in_0_next = apb_pwdata_i;

  always_ff @(posedge clk_i or negedge rstn_i)
  if (~rstn_i)
    data_in_0_ff <= '0;
  else if (data_in_0_en)
    data_in_0_ff <= data_in_0_next;


  // Data in 1

  assign data_in_1_en = apb_write & apb_sel_data_in_1;

  assign data_in_1_next = apb_pwdata_i;

  always_ff @(posedge clk_i or negedge rstn_i)
  if (~rstn_i)
    data_in_1_ff <= '0;
  else if (data_in_1_en)
    data_in_1_ff <= data_in_1_next;



  // Data in 2

  assign data_in_2_en = apb_write & apb_sel_data_in_2;

  assign data_in_2_next = apb_pwdata_i;

  always_ff @(posedge clk_i or negedge rstn_i)
  if (~rstn_i)
    data_in_2_ff <= '0;
  else if (data_in_2_en)
    data_in_2_ff <= data_in_2_next;


  // Data in 3

  assign data_in_3_en = apb_write & apb_sel_data_in_3;

  assign data_in_3_next = apb_pwdata_i;

  always_ff @(posedge clk_i or negedge rstn_i)
  if (~rstn_i)
    data_in_3_ff <= '0;
  else if (data_in_3_en)
    data_in_3_ff <= data_in_2_next;


  //////////////////////////
  // APB data out         //
  //////////////////////////

  assign apb_dout_next = apb_sel_rst        ? APB_DATA_WIDTH'(ctrl_rst_ff)
                       : apb_sel_req        ? APB_DATA_WIDTH'(ctrl_req_ff)
                       : apb_sel_ack        ? APB_DATA_WIDTH'(ctrl_ack_ff)
                       : apb_sel_valid      ? APB_DATA_WIDTH'(cipher2regs_valid)
                       : apb_sel_busy       ? APB_DATA_WIDTH'(cipher2regs_busy)
                       : apb_sel_data_in_0  ? APB_DATA_WIDTH'(data_in_0_ff)
                       : apb_sel_data_in_1  ? APB_DATA_WIDTH'(data_in_1_ff)
                       : apb_sel_data_in_2  ? APB_DATA_WIDTH'(data_in_2_ff)
                       : apb_sel_data_in_3  ? APB_DATA_WIDTH'(data_in_3_ff)
                       : apb_sel_data_out_0 ? APB_DATA_WIDTH'(cipher2regs_data_out[31:0])
                       : apb_sel_data_out_1 ? APB_DATA_WIDTH'(cipher2regs_data_out[63:32])
                       : apb_sel_data_out_2 ? APB_DATA_WIDTH'(cipher2regs_data_out[95:64])
                       : apb_sel_data_out_3 ? APB_DATA_WIDTH'(cipher2regs_data_out[127:96])
                       :                      '0;

  assign apb_dout_en = apb_read;

  always_ff @(posedge clk_i or negedge rstn_i)
  if (~rstn_i)
    apb_dout_ff <= '0;
  else if (apb_dout_en)
    apb_dout_ff <= apb_dout_next;

  assign apb_prdata_o  = apb_dout_ff;


  //////////////////////////
  // APB ready            //
  //////////////////////////

  assign apb_ready_next = ( apb_psel_i & apb_penable_i ) & ~apb_ready_ff;

  assign apb_ready_en = (apb_psel_i & apb_penable_i)
                      | apb_ready_ff;

  always_ff @(posedge clk_i or negedge rstn_i)
  if (~rstn_i)
    apb_ready_ff <= '0;
  else if (apb_ready_en)
    apb_ready_ff <= apb_ready_next;

  assign apb_pready_o  = apb_ready_ff;


  //////////////////////////
  // APB error            //
  //////////////////////////

  // Writes to status are forbidden
  // Writes to data_out registers are forbidden
  assign apb_err_next = ~apb_sel_rst
                      & ~apb_sel_req
                      & ~apb_sel_ack
                      & ~(apb_sel_valid & ~apb_pwrite_i)
                      & ~(apb_sel_busy  & ~apb_pwrite_i)
                      & ~apb_sel_data_in_0
                      & ~apb_sel_data_in_1
                      & ~apb_sel_data_in_2
                      & ~apb_sel_data_in_3
                      & ~(apb_sel_data_out_0 & ~apb_pwrite_i)
                      & ~(apb_sel_data_out_1 & ~apb_pwrite_i)
                      & ~(apb_sel_data_out_2 & ~apb_pwrite_i)
                      & ~(apb_sel_data_out_3 & ~apb_pwrite_i);


  assign apb_err_en = (apb_psel_i & apb_penable_i);

  always_ff @(posedge clk_i or negedge rstn_i)
  if (~rstn_i)
    apb_err_ff <= '0;
  else if (apb_err_en)
    apb_err_ff <= apb_err_next;

  assign apb_pslverr_o = apb_err_ff;


  //////////////////////////
  // Cipher instantiation //
  //////////////////////////

  assign cipher_rstn = rstn_i && ctrl_rst_ff;

  assign regs2cipher_req = ctrl_req_ff;
  assign regs2cipher_ack = ctrl_ack_ff;

  assign regs2cipher_data_in = {data_in_3_ff,
                                data_in_2_ff,
                                data_in_1_ff,
                                data_in_0_ff};

  // Instantiation
  kuznechik_cipher cipher(
      .clk_i      ( clk_i                ),
      .resetn_i   ( cipher_rstn          ),
      .request_i  ( regs2cipher_req      ),
      .ack_i      ( regs2cipher_ack      ),
      .data_i     ( regs2cipher_data_in  ),
      .busy_o     ( cipher2regs_busy     ),
      .valid_o    ( cipher2regs_valid    ),
      .data_o     ( cipher2regs_data_out )
  );


endmodule
