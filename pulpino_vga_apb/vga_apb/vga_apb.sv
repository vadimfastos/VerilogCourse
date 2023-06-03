/* VGA controller with APB interface. Features:
		Use BRAM for framebuffer
		8-bits per pixel
		support 640x480 videomode, but it's easy to change it
*/
module vga_apb # (
	parameter SCREEN_WIDTH = 640,
	parameter SCREEN_HEIGHT = 480,
	parameter APB_ADDR_WIDTH = $clog2(SCREEN_WIDTH * SCREEN_HEIGHT),
	parameter APB_DATA_WIDTH = 32,
	parameter VGA_OUTPUT_COLOR_DEPTH = 4
) (
	input  logic                      clk_i,
	input  logic                      rstn_i,

	// Connect to APB
	input  logic [APB_ADDR_WIDTH-1:0] apb_paddr_i,
	input  logic [APB_DATA_WIDTH-1:0] apb_pwdata_i,
	input  logic                      apb_pwrite_i,
	input  logic                      apb_psel_i,
	input  logic                      apb_penable_i,
	output logic [APB_DATA_WIDTH-1:0] apb_prdata_o,
	output logic                      apb_pready_o,
	output logic                      apb_pslverr_o,

	// We need a separate clock frequency for VGA (25.175 MHz for 640x480) and a separate reset signal synchronous with it.
	input logic vga_clk_i,
	input logic vga_rstn_i,

	// VGA synchronization output
	output logic vga_hs_o,
    output logic vga_vs_o,

	// VGA video output
    output logic [VGA_OUTPUT_COLOR_DEPTH-1:0] vga_r_o,
    output logic [VGA_OUTPUT_COLOR_DEPTH-1:0] vga_g_o,
    output logic [VGA_OUTPUT_COLOR_DEPTH-1:0] vga_b_o
);


	// Horizontal timings (in pixels), for 640x480
	localparam HT_VISIBLE_AREA = 640;
	localparam HT_FRONT_PORCH = 16;
	localparam HT_SYNC_PULSE = 96;
	localparam HT_BACK_PORCH = 48;
	localparam HT_WHOLE_LINE = 800;

	// Vertical timing (in lines), for 640x480
	localparam VT_VISIBLE_AREA = 480;
	localparam VT_FRONT_PORCH = 10;
	localparam VT_SYNC_PULSE = 2;
	localparam VT_BACK_PORCH = 33;
	localparam VT_WHOLE_FRAME = 525;


	/* Buffer for current frame. The image is stored line-by-line. Use 8 bits per pixel.
	To make the screen black at the beginning, we initialize the buffer with zeros. */
	logic [31:0] framebuffer[SCREEN_WIDTH * SCREEN_HEIGHT / 4];
	initial begin
		for (int i=0; i<SCREEN_WIDTH * SCREEN_HEIGHT / 4; i++)
			framebuffer[i] = '0;
	end


	// Execute APB transactions
	logic [APB_ADDR_WIDTH-1:0] apb_req;
	assign apb_req = rstn_i && apb_psel_i && !apb_penable_i;
	always_ff @(posedge clk_i)
		apb_pready_o <= apb_req;
	assign apb_pslverr_o = 1'b0;

	// Check address and get most significant bits (drop 2 least bits)
	logic [APB_ADDR_WIDTH-3:0] apb_index;
	assign apb_index = apb_paddr_i[APB_ADDR_WIDTH-1:2];
	assign apb_addr_correct = apb_paddr_i < (SCREEN_WIDTH * SCREEN_HEIGHT);

	// Execute APB read transaction
	always_ff @(posedge clk_i) begin
		if (apb_req && !apb_pwrite_i && apb_addr_correct) begin
			apb_prdata_o <= framebuffer[apb_index];
		end else begin
			apb_prdata_o <= '0;
		end
	end

	// Execute APB write transaction
	always_ff @(posedge clk_i)
		if (apb_req && apb_pwrite_i && apb_addr_correct)
			framebuffer[apb_index] <= apb_pwdata_i;


	// Use FSM for VGA synchronization. Store current state, pixel and line counters
	enum logic [1:0] {VISIBLE_AREA, FRONT_PORCH, SYNC_PULSE, BACK_PORCH} horz_state, horz_next_state, vert_state, vert_next_state;
	logic [$clog2(HT_VISIBLE_AREA)-1:0] horz_cnt, horz_cnt_next;
	logic [$clog2(VT_VISIBLE_AREA)-1:0] vert_cnt, vert_cnt_next;

	always_ff @(posedge vga_clk_i) begin
		if (!vga_rstn_i) begin
			horz_state <= VISIBLE_AREA;
			vert_state <= VISIBLE_AREA;
			horz_cnt <= '0;
			vert_cnt <= '0;
		end else begin
			horz_state <= horz_next_state;
			vert_state <= vert_next_state;
			horz_cnt <= horz_cnt_next;
			vert_cnt <= vert_cnt_next;
		end
	end


	// Horizontal synchronization
	logic next_line; // transition to a new line was occured
	always_comb begin
		horz_next_state = horz_state;
		horz_cnt_next = horz_cnt + 1;
		next_line = 1'b0;
		
		case (horz_state)
			VISIBLE_AREA:
				if (horz_cnt == HT_VISIBLE_AREA-1) begin
					horz_next_state = FRONT_PORCH;
					horz_cnt_next = '0;
				end
			FRONT_PORCH:
				if (horz_cnt == HT_FRONT_PORCH-1) begin
					horz_next_state = SYNC_PULSE;
					horz_cnt_next = '0;
				end
			SYNC_PULSE:
				if (horz_cnt == HT_SYNC_PULSE-1) begin
					horz_next_state = BACK_PORCH;
					horz_cnt_next = '0;
				end
			BACK_PORCH:
				if (horz_cnt == HT_BACK_PORCH-1) begin
					horz_next_state = VISIBLE_AREA;
					horz_cnt_next = '0;
					next_line = 1'b1;
				end
		endcase
	end


	// Vertical synchronization
	logic next_frame; // transition to a new frame was occured
	always_comb begin
		vert_next_state = vert_state;
		vert_cnt_next = vert_cnt;
		next_frame = 1'b0;

		if (next_line) begin
			vert_cnt_next = vert_cnt + 1;
			case (vert_state)
				VISIBLE_AREA:
					if (vert_cnt == VT_VISIBLE_AREA-1) begin
						vert_next_state = FRONT_PORCH;
						vert_cnt_next = '0;
					end
				FRONT_PORCH:
					if (vert_cnt == VT_FRONT_PORCH-1) begin
						vert_next_state = SYNC_PULSE;
						vert_cnt_next = '0;
					end
				SYNC_PULSE:
					if (vert_cnt == VT_SYNC_PULSE-1) begin
						vert_next_state = BACK_PORCH;
						vert_cnt_next = '0;
					end
				BACK_PORCH:
					if (vert_cnt == VT_BACK_PORCH-1) begin
						vert_next_state = VISIBLE_AREA;
						vert_cnt_next = 0;
						next_frame = 1'b1;
					end
			endcase
		end
	end


	// Sync pulse generation
	logic vga_hs, vga_vs;
	assign vga_hs = horz_state != SYNC_PULSE;
	assign vga_vs = vert_state != SYNC_PULSE;
	
	
	// Determine whether a pixel should be displayed on the screen
	logic pixel_present;
	assign pixel_present = (vert_state==VISIBLE_AREA) && (horz_state==VISIBLE_AREA);
	

	/* Counter of the current pixel address in memory. For read pixel color from framebuffer we 
		also need to store pixel cell (pixel address in words) and pixel offset in word. */
	logic [$clog2(SCREEN_WIDTH * SCREEN_HEIGHT)-1:0] pixel_addr, pixel_addr_next;
	logic [$clog2(SCREEN_WIDTH * SCREEN_HEIGHT)-3:0] pixel_index;
	logic [1:0] pixel_offset;

	always_comb begin
		pixel_addr_next = pixel_present ? (pixel_addr + 1) : pixel_addr;
		if (!vga_rstn_i || next_frame)
			pixel_addr_next = '0;
	end
	
	always_ff @(posedge vga_clk_i) begin
		pixel_addr <= pixel_addr_next;
		pixel_index <= pixel_addr_next[$clog2(SCREEN_WIDTH * SCREEN_HEIGHT)-1:2];
		pixel_offset <= pixel_addr_next[1:0];
	end


	/*	
	 *	It takes 2 additional clock cycles to get RGB for each pixel:
	 *		1) Reading a word from the framebuffer
	 * 		2) Extract pixel color from the read word and convert it into RGB values
	 *	Therefore, to work correctly, you need to add an additional 2 clock cycles delay
	 *	for synchronization signals and pixel_present signal.
	*/
	logic [1:0] pixel_present_ff, vga_hs_ff, vga_vs_ff;
	always_ff @(posedge vga_clk_i) begin
		pixel_present_ff <= {pixel_present, pixel_present_ff[1]};
		vga_hs_ff <= {vga_hs, vga_hs_ff[1]};
		vga_vs_ff <= {vga_vs, vga_vs_ff[1]};
	end
	

	/* Read pixels colors from framebuffer.
		There is an additional delay due to reading the video memory and registers.
		So we need add flip-flop to pixel_offset register */
	logic [31:0] pixels_color;
	logic [1:0] pixel_offset_ff;
	always_ff @(posedge vga_clk_i) begin
		pixels_color <= framebuffer[pixel_index];
		pixel_offset_ff <= pixel_offset;
	end


	// Get pixel color from read data
	logic [7:0] pixel_color;
	always_comb begin
		case (pixel_offset_ff)
			2'b00: pixel_color = pixels_color[7:0];
			2'b01: pixel_color = pixels_color[15:8];
			2'b10: pixel_color = pixels_color[23:16];
			2'b11: pixel_color = pixels_color[31:24];
		endcase
	end
	

	// Transfrom 8-bit color to RGB values. This operation takes 1 additional cycle.
	logic [VGA_OUTPUT_COLOR_DEPTH-1:0] pixel_r, pixel_g, pixel_b;
	vga_apb_color2rgb # (
		.VGA_OUTPUT_COLOR_DEPTH(VGA_OUTPUT_COLOR_DEPTH)
	) vga_apb_color2rgb_inst (
		.clk_i(vga_clk_i),
		.color_i(pixel_color),
		.r_o(pixel_r),
		.g_o(pixel_g),
		.b_o(pixel_b)
	);
	

	// VGA output: synchronization signals and current pixel RGB (in visible area) or 0
	always_ff @(posedge vga_clk_i) begin
		vga_hs_o <= vga_hs_ff[0];
		vga_vs_o <= vga_vs_ff[0];

		vga_r_o <= pixel_present_ff[0] ? pixel_r : '0;
		vga_g_o <= pixel_present_ff[0] ? pixel_g : '0;
		vga_b_o <= pixel_present_ff[0] ? pixel_b : '0;
	end

endmodule



/* Transform 8-bit number to RGB values. This operation takes 2 cycles. There are 2 ways of transform:
	1) Use palette - tables with RGB values for each pixel number
	2) Convert each color channel. In this case, 2 bits per channel are used.
		Bits in color_i 5:4 are for red, bits 3:2 for green and bits 1:0 for blue color.
*/
module vga_apb_color2rgb #(
	parameter VGA_OUTPUT_COLOR_DEPTH = 4,
	parameter USE_PALETTE = 0
) (
	input logic clk_i,
	input logic [7:0] color_i,

	output logic [VGA_OUTPUT_COLOR_DEPTH-1:0] r_o,
	output logic [VGA_OUTPUT_COLOR_DEPTH-1:0] g_o,
	output logic [VGA_OUTPUT_COLOR_DEPTH-1:0] b_o
);
	generate
		
		if (USE_PALETTE == 1) begin // Use palette 

			logic [VGA_OUTPUT_COLOR_DEPTH*3-1:0] palette[0:255];
			always_ff @(posedge clk_i) begin
				r_o <= palette[color_i][VGA_OUTPUT_COLOR_DEPTH*3-1:VGA_OUTPUT_COLOR_DEPTH*2];
				g_o <= palette[color_i][VGA_OUTPUT_COLOR_DEPTH*2-1:VGA_OUTPUT_COLOR_DEPTH*1];
				b_o <= palette[color_i][VGA_OUTPUT_COLOR_DEPTH*1-1:VGA_OUTPUT_COLOR_DEPTH*0];
			end

			// You have to set the palette. You can read it from the file.
			initial
				$readmemb("vga_palette.mem", palette);
			
		end else begin // Convert each color channel
			
			logic [VGA_OUTPUT_COLOR_DEPTH-1:0] r, g, b;
			vga_apb_color2rgb_transform r_inst(.in(color_i[5:4]), .out(r));
			vga_apb_color2rgb_transform g_inst(.in(color_i[3:2]), .out(g));
			vga_apb_color2rgb_transform b_inst(.in(color_i[1:0]), .out(b));

			always_ff @(posedge clk_i) begin
				r_o <= r;
				g_o <= g;
				b_o <= b;
			end

		end

	endgenerate
endmodule



// Transform 2 bits color channel value to VGA_OUTPUT_COLOR_DEPTH bits
// IMPORTANT: You should change this module if VGA_OUTPUT_COLOR_DEPTH!=4
module vga_apb_color2rgb_transform # (
	parameter VGA_OUTPUT_COLOR_DEPTH = 4
) (
	input logic [1:0] in,
	output logic [VGA_OUTPUT_COLOR_DEPTH-1:0] out
);

	always_comb begin
		case (in)
			2'b00: out = '0; 
			2'b01: out = {in, in}; // only for VGA_OUTPUT_COLOR_DEPTH=4 (out = in/3*15 = in*4+in) !!!
			2'b10: out = {in, in}; // only for VGA_OUTPUT_COLOR_DEPTH=4 (out = in/3*15 = in*4+in) !!!
			2'b11: out = '1;
		endcase
	end

endmodule
