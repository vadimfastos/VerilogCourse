module kuznechik_cipher_apb_wrapper(

    // Clock and reset
    input  logic            pclk_i,
    input  logic            presetn_i,

    // Address
    input  logic     [31:0] paddr_i,

    // Control-status
    input  logic            psel_i,
    input  logic            penable_i,
    input  logic            pwrite_i,

    // Write
    input  logic [3:0][7:0] pwdata_i,
    input  logic      [3:0] pstrb_i,

    // Slave
    output logic            pready_o,
    output logic     [31:0] prdata_o,
    output logic            pslverr_o

);
    
    import kuznechik_cipher_apb_wrapper_pkg::*;
    localparam ADDR_LEN = 6;
    

    // Регистры устройства
    logic [7:0] reg_rst, reg_req_ack, reg_valid, reg_busy;
    logic [31:0] reg_data_in[0:3], reg_data_out[0:3];
    assign reg_valid[7:1] = 7'b0;
    assign reg_busy[7:1] = 7'b0;
    
    
    // Подключаем модуль, осуществляющий шифрование
    logic [127:0] kuz_data_in, kuz_data_out;
    generate
        for (genvar i=0; i<4; i++) begin
            assign kuz_data_in[i*32+31:i*32] = reg_data_in[i];
            assign reg_data_out[i] = kuz_data_out[i*32+31:i*32];
        end
    endgenerate
    
    logic kuz_resetn, kuz_req, kuz_ack, kuz_busy, kuz_valid;
    kuznechik_cipher cipher(
        .clk_i      (pclk_i),
        .resetn_i   (kuz_resetn),
        .request_i  (kuz_req),
        .ack_i      (kuz_ack),
        .data_i     (kuz_data_in),
        .busy_o     (kuz_busy),
        .valid_o    (kuz_valid),
        .data_o     (kuz_data_out)
    );
    
    // Выставляем сигнал сброса для модуля шифрования и состояния регистров VALID и BUSY
    assign kuz_resetn = presetn_i && reg_rst[0];
    assign reg_valid[0] = kuz_valid;
    assign reg_busy[0] = kuz_busy;


    // Сигнал о необходимости выполнить операцию чтения / записи в текущем такте
    logic req;
    assign req = psel_i && !penable_i;
    
    // Выставляем сигнал завершения операции на шину
    always_ff @(posedge pclk_i)
        pready_o <= req;


    // Проверяем, есть ли обращение к регистрам входных/выходных данных и находим относительный адрес (внутри регистра)
    logic is_addr_reg_in, is_addr_reg_out;
    logic [ADDR_LEN-3:0] addr_reg_in, addr_reg_out;
    assign is_addr_reg_in = (paddr_i[ADDR_LEN:0]>=DATA_IN) && (paddr_i[ADDR_LEN:0]<DATA_IN+16);
    assign is_addr_reg_out = (paddr_i[ADDR_LEN:0]>=DATA_OUT) && (paddr_i[ADDR_LEN:0]<DATA_OUT+16);
    assign addr_reg_in = (paddr_i[ADDR_LEN:0] - DATA_IN) >> 2;
    assign addr_reg_out = (paddr_i[ADDR_LEN:0] - DATA_OUT) >> 2;


    // Реализуем операцию чтения
    always_ff @(posedge pclk_i) begin
        if (!presetn_i) begin
            prdata_o <= '0;
        end else if (req && !pwrite_i) begin
            if (paddr_i[ADDR_LEN:2] == '0) begin
                prdata_o <= {reg_busy, reg_valid, reg_req_ack, reg_rst};
            end else if (is_addr_reg_in) begin
                prdata_o <= reg_data_in[addr_reg_in];
            end else if (is_addr_reg_out) begin
                prdata_o <= reg_data_out[addr_reg_out];
            end
        end
    end
    
    
    // Реализуем операцию записи
    logic is_addr_reg_rst, is_addr_reg_req_ack;
    assign is_addr_reg_rst = (paddr_i[ADDR_LEN:2] == '0) && pstrb_i[0];
    assign is_addr_reg_req_ack = (paddr_i[ADDR_LEN:2] == '0) && pstrb_i[1];
    
    // Запись в регистр сброса
    always_ff @(posedge pclk_i) begin
        if (!presetn_i) begin
            reg_rst <= '1;
        end else if (req && pwrite_i && is_addr_reg_rst) begin
            reg_rst <= pwdata_i[RST];
        end
    end

    // Запись в регистр запроса/подтверждения
    always_ff @(posedge pclk_i) begin
        if (presetn_i && req && pwrite_i && is_addr_reg_req_ack) begin
            reg_req_ack <= pwdata_i[REQ_ACK];
            if (pwdata_i[REQ_ACK][0]) begin
                if (kuz_valid) begin
                    kuz_ack <= 1'b1;
                end else begin
                    kuz_req <= 1'b1;
                end
            end
        end else begin // сброс или отсутствие операции записи к этому регистру
            reg_req_ack <= '0;
            kuz_req <= 1'b0;
            kuz_ack <= 1'b0;
        end
    end
    
    // Запись в регистр входных данных
    generate
        for (genvar i=0; i<4; i++)
            always_ff @(posedge pclk_i) begin
                if (presetn_i && req && pwrite_i && is_addr_reg_in) begin
                    if (pstrb_i[i])
                        reg_data_in[addr_reg_in][8*i+7:8*i] <= pwdata_i[i]; 
                end
             end
    endgenerate
    

    // Выставление сигнала ошибки
    logic err, err_apb, err_no_reg, err_misaligned, err_wr2ro_reg, err_fsm;
    assign err_apb = 1'b0;
    assign err_no_reg = !(paddr_i[ADDR_LEN-1:2]=='0) && !is_addr_reg_in && !is_addr_reg_out;
    assign err_misaligned = paddr_i[1:0] != 2'b0;
    assign err_wr2ro_reg = pwrite_i && ((paddr_i[ADDR_LEN:2]=='0) && (pstrb_i[VALID] || pstrb_i[BUSY]) || is_addr_reg_out);
    assign err_fsm = (pwrite_i && is_addr_reg_req_ack && pwdata_i[REQ_ACK][0]) && (!kuz_valid && kuz_busy);
    assign err = err_apb || err_no_reg || err_misaligned || err_wr2ro_reg || err_fsm;

    always @(posedge pclk_i) begin
        if (req) begin
            pslverr_o <= err;
        end else begin
            pslverr_o <= 1'b0;
        end
    end
    
    
endmodule
