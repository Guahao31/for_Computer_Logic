`timescale 1ns / 1ps

module Top( 
	input wire clk,
	input wire SW,
	output wire LED,
	output wire [7:0] SEGMENT,
	output wire [3:0] AN
);
	 
	wire[15:0] cnt;
	wire [3:0] Hex;
	wire clk_100ms;
	
	/* module clk_100ms at submodules/clk_1s.v */
	clk_100ms clk_div_100ms (.clk(clk), .clk_100ms(clk_100ms));
	
	/* You need to implement module RevCounter */
	RevCounter counter(.clk(clk_100ms), .s(SW), .cnt(cnt), .Rc(LED));

	// Please replace module below with your module completed in Lab **7**
	// imoprt submodules for module disp_num from your prev. project
	disp_num display(.clk(clk), .HEXS(cnt), .LES(4'b0000), .points(4'b0000), .RST(1'b0), .AN(AN), .Segment(SEGMENT));

endmodule
