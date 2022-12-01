`timescale 1ns / 1ps

module Top(
	input clk,
	input [3:0] BTN_Y, 
	input [15:0] SW,
	output BTN_X,
	output[3:0]AN,
	output[7:0] SEGMENT
);

	wire [31:0] my_clkdiv;
	wire [2:0] btn_out;
	reg  [11:0] num;
	wire [3:0] A1, A2, B1, B2, C1, C2;
	wire [3:0] mux_out;
	wire Co;
	wire [3:0] ALU_res;

	/* SW[1:0] to control if the counter for A or B is reversal */
	wire A_Ctrl = SW[0];
	wire B_Ctrl = SW[1];
	/* SW[3:2] to choose the mode of the ALU */
	wire [1:0] ALU_Ctrl = SW[3:2];
	/* SW[5:4] to choose from A B C and 0 */
	/* 00 for A; 01 for B; 10 for C; 11 for 0 */
	wire [1:0] Trans_select = SW[5:4];

	wire [3:0] reg_A_val = num[ 3: 0];
	wire [3:0] reg_B_val = num[ 7: 4];
	wire [3:0] reg_C_val = num[11: 8];


	clkdiv m0(.clk(clk), .rst(1'b0), .clkdiv(my_clkdiv));
	
	pbdebounce m1(.clk_1ms(my_clkdiv[17]), .button(BTN_Y[0]), .pbreg(btn_out[0]));
	pbdebounce m2(.clk_1ms(my_clkdiv[17]), .button(BTN_Y[1]), .pbreg(btn_out[1]));
	pbdebounce m3(.clk_1ms(my_clkdiv[17]), .button(BTN_Y[2]), .pbreg(btn_out[2]));
	
	AddSub4b m4(.A(reg_A_val), .B(4'b0001), .Ctrl(A_Ctrl), .S(A1));
	AddSub4b m5(.A(reg_B_val), .B(4'b0001), .Ctrl(B_Ctrl), .S(B1));
	
	Mux4to1b4_sch m6(.I0(reg_A_val), .I1(reg_B_val), .I2(reg_C_val), .I3(4'b0000),
									 .s(Trans_select), .o(mux_out));
	
	/* ALU module implemented in Lab8 */
	/* A/B	: operands */
	/* S		: select the operation on ALU  */
	/* C 		: result of ALU */
	/* Co		: Carry bit */
	ALU4b m7(.A(reg_A_val), .B(reg_B_val), .C(ALU_res), .Co(Co), .S(ALU_Ctrl)); // (Co) may be useless
	
	disp_num m8(.clk(clk), .HEXS({reg_A_val, reg_B_val, ALU_res, reg_C_val}), 
							.LES(4'b0000), .points(4'b0000), .RST(1'b0), .AN(AN),
							.Segment(SEGMENT));
	
	/* Your code here */
	// SW[15]: 0 for ALU mode, 1 for Trans mode.
	assign A2 = (1'b0 == SW[15]) ? A1 : mux_out; 
	assign B2 = ();
	assign C2 = ();
	
	always@(posedge btn_out[0]) num[3:0] = A2;
	always@() num[7:4] = ();
	always@() num[11:8] = ();
	/******************/

endmodule
