module vga_sync(
	input clk_50MHz,
	output  reg VGA_CLK, 
	output  VGA_HS,
	output  VGA_VS,
	output  VGA_BLANK_N,
	output  VGA_SYNC_N,
	output reg [9:0] h_count,
	output reg [9:0] v_count
);

   always @(posedge clk_50MHz) VGA_CLK <= ~VGA_CLK;
	 
	 parameter H_ACTIVE  = 640;
    parameter H_FP      = 16;
    parameter H_SYNC    = 96;
    parameter H_BP      = 48;
    parameter H_TOTAL   = H_ACTIVE + H_FP + H_SYNC + H_BP;

    parameter V_ACTIVE  = 480;
    parameter V_FP      = 10;
    parameter V_SYNC    = 2;
    parameter V_BP      = 33;
    parameter V_TOTAL   = V_ACTIVE + V_FP + V_SYNC + V_BP;

    reg vga_hs_reg, vga_vs_reg;

    always @(posedge VGA_CLK) begin
        if (h_count < H_TOTAL - 1)
            h_count <= h_count + 1;
        else begin
            h_count <= 0;
            if (v_count < V_TOTAL - 1)
                v_count <= v_count + 1;
            else
                v_count <= 0;
        end
    end

    always @(posedge VGA_CLK) begin
        if (h_count >= H_ACTIVE + H_FP && h_count < H_ACTIVE + H_FP + H_SYNC)
            vga_hs_reg <= 0;
        else
            vga_hs_reg <= 1;
    end

    always @(posedge VGA_CLK) begin
        if (v_count >= V_ACTIVE + V_FP && v_count < V_ACTIVE + V_FP + V_SYNC)
            vga_vs_reg <= 0;
        else
            vga_vs_reg <= 1;
    end

    assign VGA_HS = vga_hs_reg;
    assign VGA_VS = vga_vs_reg;

	 assign VGA_BLANK_N = (h_count < H_ACTIVE && v_count < V_ACTIVE);
    assign VGA_SYNC_N = 1'b0;
	 
endmodule
