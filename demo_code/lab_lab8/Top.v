`timescale 1ns / 1ps

module Top(
		input wire clk,
		input wire [1:0] BTN,
		input wire [1:0] SW1,
		input wire [1:0] SW2,
		input wire [11:0] SW,
		output wire [3:0] AN,
		output wire [7:0] SEGMENT,
		output wire BTNX4,
		output wire seg_clk,
		output wire seg_clrn,
		output wire seg_sout,
		output wire SEG_PEN
);
	wire [15:0] num;
	wire [1:0] btn_out;
	wire [3:0] C;
	wire Co;
	wire [31:0] clk_div;
	wire [15:0] disp_hexs;
	wire [15:0] disp_hexs_my;
	
	assign disp_hexs[15:12] = num[7:4];			// B
	assign disp_hexs[11:8]  = num[3:0];			// A
	assign disp_hexs[7:4]   = {3'b000, Co};	
	assign disp_hexs[3:0]   = C[3:0];				// C
	
	/* Code here */
	assign disp_hexs_my = (); // Fill the last four digits of your student id in ()

	assign BTNX4 = 1'b0;
	
	clkdiv m2(clk, 0, clk_div);
	pbdebounce m0(clk_div[17], BTN[0], btn_out[0]);
	pbdebounce m1(clk_div[17], BTN[1], btn_out[1]);
	CreateNumber m3(btn_out, SW1, num);

	// The ALU module you wrote
	ALU m5(	.A(num[3:0]), 
					.B(), 							// fill sth. in ()
					.S(), 							// fill sth. in ()
					.C(), 							// fill sth. in ()
					.Co(Co)); 
	disp_num m6(	.clk(clk), .HEXS(disp_hexs), .LES(), 		// fill sth. in ()
								.points(SW[3:0]), .RST(), 							// fill sth. in ()
								.AN(AN), .Segment(SEGMENT));
	Sseg_Dev m7(.clk(clk), .flash(clk_div[25]), .Hexs({disp_hexs_my, disp_hexs}), .LES(SW[11:4]),
					.point({4'b0000, SW[3:0]}), .rst(1'b0), .Start(clk_div[20]), .seg_clk(seg_clk),
					.seg_clrn(seg_clrn), .SEG_PEN(SEG_PEN), .seg_sout(seg_sout));

endmodule
