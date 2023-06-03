module pulpino_nexys_a7_tb_vga_accel ();
    logic        clk100mhz;
    logic [15:0] sw;
    logic [15:0] led;
    logic        cpu_resetn;
    tri   [7:0]  ja;
    logic        uart_rxd_out;
    logic        uart_txd_in;

    logic vga_hs, vga_vs;
    logic [3:0] vga_r, vga_g, vga_b;
    
    logic acl_sclk, acl_csn;
    logic acl_miso, acl_mosi;
    logic [1:0] acl_int;
    
    assign acl_miso = 0;

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
    end

    // JTAG placeholder
    assign ja[3] = 1'b0;
    assign ja[4] = 1'b1;
    assign ja[0] = 1'b0;
    assign ja[1] = 1'b0;

    pulpino_nexys_a7
    //#(.DATA_RAM_INIT_FILE  (""),
    //  .INSTR_RAM_INIT_FILE (""))
    UUT (
        .clk100mhz    (clk100mhz),
        .cpu_resetn   (cpu_resetn),
        .sw           (sw),
        .led          (led),
        .ja           (ja),
        .uart_rxd_out (uart_rxd_out),
        .uart_txd_in  (uart_txd_in),
        // VGA
        .vga_hs,
        .vga_vs,
        .vga_r,
        .vga_g,
        .vga_b,
        // Accelerometer
        .acl_sclk(acl_sclk),
        .acl_csn(acl_csn),
        .acl_miso(acl_miso),
        .acl_mosi(acl_mosi),
        .acl_int(acl_int)
    );

    // ���������� ���������� UART ����������
    logic uart_rx_ready, uart_tx_req, uart_tx_busy;
    logic [7:0] uart_rx_data, uart_tx_data;
    logic uart_clk, uart_rst;
    always begin
        uart_clk = 0;
        #25;
        uart_clk = 1;
        #25;
    end
    initial begin
        uart_rst = 1'b0;
        #100;
        uart_rst = 1'b1;
    end
    uart_phy # (
        .CLOCK_FREQUENCY(20*1000*1000),
        .BAUDRATE(115200)
    ) uart_phy_i (
        // �������� �������� � ������ ������
        .clk(uart_clk),
        .rstn(uart_rst),

        // ���� ������
        .rx_data(uart_rx_data), 	// �������� ������, ������� ��� rx_ready=1
        .rx_ready(uart_rx_ready),	// ������������ � 1 �� 1 ����, ����� �������� ������ ������� (����� ���������� ����� �����)

        // �������� ������
        .tx_data(uart_tx_data),	// ������, ������� ����� ��������
        .tx_req(uart_tx_req),	// ����� ��������� � 1 �� 1 ����, ����� ������ �������� ������, ����� tx_busy=0
        .tx_busy(uart_tx_busy),	// ���� ��������� �����������

        // ��������� UART
        .rxd(uart_rxd_out),
        .txd(uart_txd_in)
    );


    // ������� ����� �� UART
    task uart_send_byte(input byte data);

        // ���, ���� ���������� UART �� ����� ��������
        while (uart_tx_busy)
            #1;

        // �������� ������ �� �������� ������
        uart_tx_data = data;
        @(posedge uart_clk);
            uart_tx_req = 1;
        @(posedge uart_clk);
            uart_tx_req = 0;
        @(posedge uart_clk);

        // ������� ��������� ���������
        while (uart_tx_busy)
            #1;
    endtask


    // ���� ����� �� UART
    task uart_receive_byte(output byte data);
        int timeout;

        // ��� ����������� ������
        timeout = 10000000;
        while (!uart_rx_ready && timeout!=0) begin
            #1;
            timeout = timeout - 1;
        end
        if (timeout == 0) begin
            $display("Error: time limit exceeded");
            $finish();
        end

        // ��������� ������
        data = uart_rx_data;

        // ���, ����� ����� ����� ����, ����� �� ������� 2 ���� ���� � �� �� ������
        while (uart_rx_ready)
            #1;
    endtask


    /*
    initial begin
        $finish();
    end*/

endmodule
