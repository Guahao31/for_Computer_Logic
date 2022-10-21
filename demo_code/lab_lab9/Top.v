`timescale 1ns / 1ps

module Top( 
		input clk,
		input [15:0] SW,
		input [3:0] BTN,
		output [7:0] LED,
		output ledclk,
		output ledsout,
		output ledclrn,
		output LEDEN,
		output BTNX3
);

	wire [31:0] div;
	wire [3:0] BTN_OUT;
	wire CK;
	wire [15:0] num;
	wire [8:0] NLED;
	assign BTNX3=0;
	assign NLED = {~LED8, ~LED};

	pbdebounce p1(div[17], BTN[0], BTN_OUT[0]);
	pbdebounce p2(div[17], BTN[1], BTN_OUT[1]);
	pbdebounce p3(div[17], BTN[2], BTN_OUT[2]);
	pbdebounce p4(div[17], BTN[3], BTN_OUT[3]);
	
	clkdiv_pulse m0(.clk(clk), .rst(rst), .Sel_CLK(SW[15]), .pulse(BTN_OUT[0]), .CK(CK), .clkdiv(div[31:0]));
	
	CSR_LATCH Mm2(.C(CK), .R(SW[0]), .S(SW[1]), .Q(LED[1]), .Qn(LED[0]));
	D_LATCH Mm3(.C(CK), .D(SW[2]), .Q(LED[3]), .Qn(LED[2]));
	MS_FLIPFLOP Mm4(.C(CK), .S(SW[4]), .R(SW[3]), .Y(LED[6]), .Q(LED[5]), .Qn(LED[4]));
	D_FLIPFLOP Mm5(.C(CK), .D(SW[5]), .Q(LED8), .Qn(LED[7]));
	
	LEDP2S #(.DATA_BITS(16), .DATA_COUNT_BITS(4), .DIR(0))
			U7 (.clk(clk), .rst(1'b0), .Start(div[20]), .PData({7'h3F, NLED[8:0]}), .sclk(ledclk), .sclrn(ledclrn),
				 .sout(ledsout), .EN(LEDEN));
endmodule
