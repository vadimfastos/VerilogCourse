`timescale 1ns / 1ps

module tb_vga_apb();


    // Generate 100 MHz clock frequency and reset signal
    logic clk, rstn;
    always begin
        clk = 0;
        #5;
        clk = 1;
        #5;
    end
    initial begin
        rstn = 0;
        #100;
        rstn = 1;
    end


    // Generate 25 MHz async clock (we can't generate 25.175 MHz) frequency for VGA and async reset signal for VGA
    logic vga_clk, vga_rstn;
    always begin
        #1;
        vga_clk = 0;
        #20;
        vga_clk = 1;
        #19;
    end
    initial begin
        vga_rstn = 1;
        #1;
        vga_rstn = 0;
        #83;
        vga_rstn = 1;
    end


    // APB signals
    logic apb_psel, apb_penable, apb_pwrite, apb_pready, apb_pslverr;
    logic [31:0] apb_paddr, apb_pwdata, apb_prdata;

    
    // Output VGA signals - we will see it in waveform
    logic vga_hs, vga_vs;
    logic [3:0] vga_r, vga_g, vga_b;


    // Create VGA module instanse
    localparam SCREEN_WIDTH = 640;
	localparam SCREEN_HEIGHT = 480;
    vga_apb # (
        .SCREEN_WIDTH(SCREEN_WIDTH),
        .SCREEN_HEIGHT(SCREEN_HEIGHT)
    ) DUT (
        .clk_i(clk),
        .rstn_i(rstn),

        .apb_paddr_i(apb_paddr),
        .apb_pwdata_i(apb_pwdata),
        .apb_pwrite_i(apb_pwrite),
        .apb_psel_i(apb_psel),
        .apb_penable_i(apb_penable),
        .apb_prdata_o(apb_prdata),
        .apb_pready_o(apb_pready),
        .apb_pslverr_o(apb_pslverr),

        .vga_clk_i(vga_clk),
        .vga_rstn_i(vga_rstn),

        .vga_hs_o(vga_hs),
        .vga_vs_o(vga_vs),

        .vga_r_o(vga_r),
        .vga_g_o(vga_g),
        .vga_b_o(vga_b)
    );


    // Execute APB read transaction
    task apb_read(input logic [31:0] addr, output logic [31:0] rdata);
        // Setup phase
        apb_psel = 1'b1;
        apb_penable = 1'b0;
        apb_pwrite = 1'b0;
        apb_paddr = addr;

        // Access phase
        @(posedge clk);
        apb_penable <= 1'b1;
        do begin
            @(posedge clk);
        end while(!apb_pready);
        rdata = apb_prdata;

        // Check error
        if (apb_pslverr) begin
            $display("APB write transaction error: addr=0x%0h, rdata=0x%0h", addr, rdata);
            $finish();
        end

        // Unset control signals
        apb_psel = 1'b0;
        apb_penable = 1'b0;
    endtask


    // Execute APB write transaction
    task apb_write(input logic [31:0] addr, input logic [31:0] wdata);
        // Setup phase
        apb_psel = 1'b1;
        apb_penable = 1'b0;
        apb_pwrite = 1'b1;
        apb_paddr = addr;
        apb_pwdata = wdata;

        // Access phase
        @(posedge clk);
        apb_penable <= 1'b1;
        do begin
            @(posedge clk);
        end while(!apb_pready);

        // Check error
        if (apb_pslverr) begin
            $display("APB write transaction error: addr=0x%0h, wdata=0x%0h", addr, wdata);
            $finish();
        end

        // Unset control signals
        apb_psel = 1'b0;
        apb_penable = 1'b0;
    endtask

    
    /* Put pixel on the screen.
        We use 8 bits (1 byte) per pixel, but we can access only to 4 bytes.
        For draw pixel we need to read 4 pixels, change requested pixel color and then write it. */
    task draw_pixel(input int unsigned x, input int unsigned y, input logic [7:0] color);
        int unsigned pixel_number, pixel_address;
        logic [1:0] pixel_offset;
        logic [31:0] pixels;

        pixel_number = y * SCREEN_WIDTH + x;
        pixel_address = {pixel_number[31:2], 2'b0};
        pixel_offset = pixel_number[1:0];
        
        apb_read(pixel_address, pixels);
        case (pixel_offset)
            2'b00: pixels[7:0] = color;
            2'b01: pixels[15:8] = color;
            2'b10: pixels[23:16] = color;
            2'b11: pixels[31:24] = color;
        endcase
        apb_write(pixel_address, pixels);
    endtask


    // Check VGA using waveform
    logic [7:0] color;
    initial begin
        apb_psel = 1'b0;
        apb_penable = 1'b0;
        while (!rstn)
            #1;
        
        color = '0;
        for (int unsigned y=0; y<SCREEN_HEIGHT; y++)
            for (int unsigned x=0; x<SCREEN_WIDTH; x++) begin
                draw_pixel(x, y, color);
                color = color + 1;
            end
    end

endmodule
