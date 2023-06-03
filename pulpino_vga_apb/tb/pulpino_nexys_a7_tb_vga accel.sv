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

    // Подключаем реализацию UART интерфейса
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
        // тактовые импульсы и сигнал сброса
        .clk(uart_clk),
        .rstn(uart_rst),

        // приём данных
        .rx_data(uart_rx_data), 	// принятые данные, валидны при rx_ready=1
        .rx_ready(uart_rx_ready),	// выставляется в 1 на 1 такт, когда принятые данные валидны (после очередного приёма байта)

        // передача данных
        .tx_data(uart_tx_data),	// данные, которые нужно передать
        .tx_req(uart_tx_req),	// нужно выставить в 1 на 1 такт, чтобы начать передачу данных, когда tx_busy=0
        .tx_busy(uart_tx_busy),	// флаг занятости передатчика

        // интерфейс UART
        .rxd(uart_rxd_out),
        .txd(uart_txd_in)
    );


    // Посылка байта по UART
    task uart_send_byte(input byte data);

        // ждём, пока передатчик UART не будет свободен
        while (uart_tx_busy)
            #1;

        // посылаем запрос на передачу данных
        uart_tx_data = data;
        @(posedge uart_clk);
            uart_tx_req = 1;
        @(posedge uart_clk);
            uart_tx_req = 0;
        @(posedge uart_clk);

        // ожидаем окончания пересылки
        while (uart_tx_busy)
            #1;
    endtask


    // Приём байта по UART
    task uart_receive_byte(output byte data);
        int timeout;

        // ждём поступления данных
        timeout = 10000000;
        while (!uart_rx_ready && timeout!=0) begin
            #1;
            timeout = timeout - 1;
        end
        if (timeout == 0) begin
            $display("Error: time limit exceeded");
            $finish();
        end

        // считываем данные
        data = uart_rx_data;

        // ждём, когда будет убран флаг, чтобы не считать 2 раза одни и те же данные
        while (uart_rx_ready)
            #1;
    endtask


    /*
    initial begin
        $finish();
    end*/

endmodule
