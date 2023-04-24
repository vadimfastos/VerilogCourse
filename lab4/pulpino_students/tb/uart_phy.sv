/* Реализация UART интерфейса. Если приняты ошибочные данные, то они пропускаются. */
module uart_phy # (
	parameter CLOCK_FREQUENCY = 25*1000*1000, // тактовая частота процессора
	parameter BAUDRATE = 9600 // скорость передачи данных (бод)
) (
	
	// тактовые импульсы и сигнал сброса
	input clk,
	input rstn,
	
	// приём данных
	output logic [7:0] rx_data,	// принятые данные, валидны при rx_ready=1
	output logic rx_ready,		// выставляется в 1 на 1 такт, когда принятые данные валидны (после очередного приёма байта)
	
	// передача данных
	input [7:0] tx_data,	// данные, которые нужно передать
	input tx_req,			// нужно выставить в 1 на 1 такт, чтобы начать передачу данных, когда tx_busy=0
	output tx_busy,			// флаг занятости передатчика
	
	// интерфейс UART
	input rxd,
	output logic txd
);
	
	// Коэффициенты делителей частоты для тактирования UART
	localparam CLOCK_DIVIDER = CLOCK_FREQUENCY / (BAUDRATE);
	localparam CLOCK_DIVIDER_HALF = CLOCK_FREQUENCY / (BAUDRATE*2);
	
	
	/* Тактовый сигнал для приёма данных (rx_clk), выставляется на 1 такт, когда нужно принять очередной бит.
		rx_clk_start выcтавляется в 1, когда нужно начать тактирование. Нулевой такт равен половине обычного такта. */
	logic rx_clk_start, rx_clk;
	logic [$clog2(CLOCK_DIVIDER)-1:0] rx_clk_counter;
	assign rx_clk = rx_clk_counter == 0;
	
	always_ff @(posedge clk) begin
		if (!rstn) begin
			rx_clk_counter <= CLOCK_DIVIDER_HALF - 1;
		end else begin
			if (rx_clk_start) begin
				rx_clk_counter <= CLOCK_DIVIDER_HALF - 1;
			end else begin
				rx_clk_counter <= (rx_clk_counter!=0) ? (rx_clk_counter-1) : (CLOCK_DIVIDER-1);
			end
		end
	end
	
	
	/* Тактовый сигнал для передачи данных (tx_clk), выставляется на 1 такт, когда нужно передать очередной бит. */
	logic tx_clk;
	logic [$clog2(CLOCK_DIVIDER)-1:0] tx_clk_counter;
	assign tx_clk = tx_clk_counter == 0;
	
	always_ff @(posedge clk) begin
		if (!rstn) begin
			tx_clk_counter <= CLOCK_DIVIDER - 1;
		end else begin
			tx_clk_counter <= (tx_clk_counter!=0) ? (tx_clk_counter-1) : (CLOCK_DIVIDER-1);
		end
	end
	
	
	// Осуществляем приём данных
	enum logic[1:0] {RX_STATE_IDLE, RX_STATE_START, RX_STATE_DATA, RX_STATE_STOP} rx_state;
	logic [2:0] rx_bit_counter;
	
	// Необходимо начать тактирование приёмника, когда произошёл перепад из 1 в 0 в состоянии ожидания
	assign rx_clk_start = (rx_state==RX_STATE_IDLE) && !rxd;
	
	always_ff @(posedge clk) begin
		if (!rstn) begin
			rx_state <= RX_STATE_IDLE;
			rx_ready <= 0;
		end else begin
			case (rx_state)
				
				// Если мы находимся в состоянии ожидания и на вход приёмника пришёл 0, то ждём полтакта и читаем стартовый бит.
				RX_STATE_IDLE: begin
					if (!rxd)
						rx_state <= RX_STATE_START;
					rx_ready <= 0;
					rx_bit_counter <= 0;
				end
				
				// Принимаем стартовый бит и проверяем его на равенство 0
				RX_STATE_START:
					if (rx_clk)
						rx_state <= (!rxd) ? RX_STATE_DATA : RX_STATE_IDLE;
				
				// Принимаем очередной бит данных
				RX_STATE_DATA:
					if (rx_clk) begin
						rx_data <= {rxd, rx_data[7:1]};
						if (rx_bit_counter == 3'd7)
							rx_state <= RX_STATE_STOP;
						rx_bit_counter <= rx_bit_counter + 1;
					end
				
				// Принимаем стоповый бит и проверяем его на равенство 1
				RX_STATE_STOP:
					if (rx_clk) begin
						rx_ready <= rxd; // принятые данные валидны только если стоповый бит равен 1
						rx_state <= RX_STATE_IDLE;
					end
				
				default: rx_state <= RX_STATE_IDLE;
			endcase
		end
	end
	
	
	// Осуществляем передачу данных
	enum logic [1:0] {TX_STATE_IDLE, TX_STATE_START, TX_STATE_DATA, TX_STATE_STOP} tx_state;
	logic [7:0] tx_buffer;
	logic [2:0] tx_bit_counter;
	
	// Выставляем флаг занятости передатчика
	assign tx_busy = tx_state != TX_STATE_IDLE;
	
	always_ff @(posedge clk) begin
		if (!rstn) begin
			tx_state <= TX_STATE_IDLE;
			txd <= 1;
		end else begin
			case (tx_state)
				
				// Если в состоянии ожидания пришёл запрос на передачу, то выполняем его
				TX_STATE_IDLE:
					if (tx_req) begin
						tx_state <= TX_STATE_START;
						tx_buffer <= tx_data;
						tx_bit_counter <= 3'd0;
					end
				
				// Посылаем стартовый бит
				TX_STATE_START:
					if (tx_clk) begin
						tx_state <= TX_STATE_DATA;
						txd <= 0;
					end
					
				// Посылаем очередной бит данных
				TX_STATE_DATA:
					if (tx_clk) begin
						txd <= tx_buffer[0];
						tx_buffer <= {1'b0, tx_buffer[7:1]};
						if (tx_bit_counter == 3'd7)
							tx_state <= TX_STATE_STOP;
						tx_bit_counter <= tx_bit_counter + 1;
					end
				
				// Посылаем стоповый бит
				TX_STATE_STOP:
					if (tx_clk) begin
						tx_state <= TX_STATE_IDLE;
						txd <= 1;
					end
				
				default: tx_state <= TX_STATE_IDLE;
			endcase
		end
	end
	
	
endmodule
