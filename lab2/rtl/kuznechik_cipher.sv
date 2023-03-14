module kuznechik_cipher(
    input               clk_i,      // �������� ������
                        resetn_i,   // ���������� ������ ������ � �������� ������� LOW
                        request_i,  // ������ ������� �� ������ ����������
                        ack_i,      // ������ ������������� ������ ������������� ������
                [127:0] data_i,     // ��������� ������

    output              busy_o,     // ������, ���������� � ������������� �����
                                    // ���������� ������� �� ����������, ���������
                                    // ������ � �������� ���������� �����������
                                    // �������
           reg          valid_o,    // ������ ���������� ������������� ������
           reg  [127:0] data_o      // ������������� ������
);

reg [127:0] key_mem [0:9];
reg [7:0] S_box_mem [0:255];

reg [7:0] L_mul_16_mem  [0:255];
reg [7:0] L_mul_32_mem  [0:255];
reg [7:0] L_mul_133_mem [0:255];
reg [7:0] L_mul_148_mem [0:255];
reg [7:0] L_mul_192_mem [0:255];
reg [7:0] L_mul_194_mem [0:255];
reg [7:0] L_mul_251_mem [0:255];

initial begin
    $readmemh("keys.mem",key_mem );
    $readmemh("S_box.mem",S_box_mem );

    $readmemh("L_16.mem", L_mul_16_mem );
    $readmemh("L_32.mem", L_mul_32_mem );
    $readmemh("L_133.mem",L_mul_133_mem);
    $readmemh("L_148.mem",L_mul_148_mem);
    $readmemh("L_192.mem",L_mul_192_mem);
    $readmemh("L_194.mem",L_mul_194_mem);
    $readmemh("L_251.mem",L_mul_251_mem);
end


// ���������� �������� ������� ����
enum {FSM_IDLE, FSM_KEY_PHASE, FSM_S_PHASE, FSM_L_PHASE, FSM_FINISH} fsm_state;
logic [3:0] round_num; 
logic [4:0] l_phase_cnt;

// ����� ����� ����������� ������� ������ ����� ������� �� ���������
logic [127:0] data_i_saved;

always_ff @(posedge clk_i) begin
	if (!resetn_i) begin
		fsm_state <= FSM_IDLE;
		valid_o <= 1'b0;
	end else begin
		case (fsm_state)
			
			FSM_IDLE:
				if (request_i) begin
					fsm_state <= FSM_KEY_PHASE;
					round_num <= 4'd0;
					data_i_saved <= data_i;
				end
			
			FSM_KEY_PHASE:
				if (round_num == 9) begin
					fsm_state <= FSM_FINISH;
					valid_o <= 1'b1;
				end else begin
					fsm_state <= FSM_S_PHASE;
					round_num <= round_num + 1;
				end
				
			FSM_S_PHASE: begin
				fsm_state <= FSM_L_PHASE;
				l_phase_cnt <= 0;
			end
			
			FSM_L_PHASE:
				if (l_phase_cnt == 15) begin
					fsm_state <= FSM_KEY_PHASE;
				end else begin
					l_phase_cnt <= l_phase_cnt + 1;
				end
				
			FSM_FINISH:
				if (ack_i) begin
					fsm_state <= FSM_IDLE;
					valid_o <= 1'b0;
				end else if (request_i) begin
					fsm_state <= FSM_KEY_PHASE;
					round_num <= 4'd0;
					valid_o <= 1'b0;
					data_i_saved <= data_i;
				end
			
		endcase
	end
end


// ������� ��������� ������
assign busy_o = (fsm_state != FSM_IDLE);


// �������� ��������� ���������� �����
logic [127:0] key_phase_in, key_phase_out;
assign key_phase_in = (round_num == 0) ? data_i_saved : l_phase_out;
always_ff @(posedge clk_i)
	if (fsm_state == FSM_KEY_PHASE)
		key_phase_out <= key_phase_in ^ key_mem[round_num];

// ����� ����� ��������� ���������� ����� �������� ������� �����
assign data_o = key_phase_out;


// ���������� ��������������
logic [127:0] s_phase_out;
generate
	for (genvar i=0; i<16; i++)
		always_ff @(posedge clk_i)
			if (fsm_state == FSM_S_PHASE)
				s_phase_out[i*8+7:i*8] <= S_box_mem[key_phase_out[i*8+7:i*8]];
endgenerate


// �������� ��������������
logic [127:0] l_phase_in, l_phase_out;
logic [7:0] l_phase_mul_in [0:15], l_phase_mul_out[0:15];

assign l_phase_in = (l_phase_cnt == 0) ? s_phase_out : l_phase_out;

generate
	for (genvar i=0; i<16; i++)
		assign l_phase_mul_in[i] = l_phase_in[i*8+7:i*8];
endgenerate

// ��������� �� (148, 32, 133, 16, 194, 192, 1, 251, 1, 192, 194, 16, 133, 32, 148, 1)
assign l_phase_mul_out[15] = L_mul_148_mem[l_phase_mul_in[15]];
assign l_phase_mul_out[14] = L_mul_32_mem[l_phase_mul_in[14]];
assign l_phase_mul_out[13] = L_mul_133_mem[l_phase_mul_in[13]];
assign l_phase_mul_out[12] = L_mul_16_mem[l_phase_mul_in[12]];
assign l_phase_mul_out[11] = L_mul_194_mem[l_phase_mul_in[11]];
assign l_phase_mul_out[10] = L_mul_192_mem[l_phase_mul_in[10]];
assign l_phase_mul_out[9] = l_phase_mul_in[9];
assign l_phase_mul_out[8] = L_mul_251_mem[l_phase_mul_in[8]];
assign l_phase_mul_out[7] = l_phase_mul_in[7];
assign l_phase_mul_out[6] = L_mul_192_mem[l_phase_mul_in[6]];
assign l_phase_mul_out[5] = L_mul_194_mem[l_phase_mul_in[5]];
assign l_phase_mul_out[4] = L_mul_16_mem[l_phase_mul_in[4]];
assign l_phase_mul_out[3] = L_mul_133_mem[l_phase_mul_in[3]];
assign l_phase_mul_out[2] = L_mul_32_mem[l_phase_mul_in[2]];
assign l_phase_mul_out[1] = L_mul_148_mem[l_phase_mul_in[1]];
assign l_phase_mul_out[0] = l_phase_mul_in[0];

// ���������� ���������� ������������ ����� �����
logic [7:0] l_phase_mul_sum;
generate
	always_comb begin
		l_phase_mul_sum = 8'b0;
		for (int i=0; i<16; i++)
			l_phase_mul_sum = l_phase_mul_sum ^ l_phase_mul_out[i];
	end
endgenerate

// ���������� ��������� ����� ���������� ����
always_ff @(posedge clk_i)
	if (fsm_state == FSM_L_PHASE)
		l_phase_out <= {l_phase_mul_sum, l_phase_in[127:8]};


endmodule
