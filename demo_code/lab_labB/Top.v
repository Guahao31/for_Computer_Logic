`timescale 1ns / 1ps

module Top(
	input clk,
	input [3:0] BTN_Y, 
	input [15:0] SW,

	/* Unused if not programming */
	output BTN_X,
	output[3:0]AN,
	output[7:0] SEGMENT,
	/*****************************/

	/* Added for check */
	output[3:0] debug_A,
	output[3:0] debug_B,
	output[3:0] debug_C,
	output[3:0] debug_res
	/*******************/
);

	/* Assignment for debug signals */
	assign debug_A = reg_A_val;
	assign debug_B = reg_B_val;
	assign debug_C = reg_C_val;
	assign debug_res = ALU_res;
	/*********************************/

	wire [31:0] my_clkdiv;
	wire [2:0] btn_out;
	reg  [11:0] num = 12'b0;
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

	// clkdiv m0(.clk(clk), .rst(1'b0), .clkdiv(my_clkdiv));

	/* pbdebounce module DELETED for testing purpose */
	// pbdebounce m1(.clk_1ms(my_clkdiv[17]), .button(BTN_Y[0]), .pbreg(btn_out[0]));
	// pbdebounce m2(.clk_1ms(my_clkdiv[17]), .button(BTN_Y[1]), .pbreg(btn_out[1]));
	// pbdebounce m3(.clk_1ms(my_clkdiv[17]), .button(BTN_Y[2]), .pbreg(btn_out[2]));

	/* Assign btn_out without debouncing */
	assign btn_out = BTN_Y;

	// AddSub4b m4(.A(reg_A_val), .B(4'b0001), .Ctrl(A_Ctrl), .S(A1));
	// AddSub4b m5(.A(reg_B_val), .B(4'b0001), .Ctrl(B_Ctrl), .S(B1));

	wire[3:0] A_plus = reg_A_val+4'b1;
	wire[3:0] A_minus = reg_A_val-4'b1;

	wire[3:0] B_plus = reg_B_val+4'b1;
	wire[3:0] B_minus = reg_B_val-4'b1;

	assign A1 = A_Ctrl == 1'b0 ? A_plus : A_minus;
	assign B1 = B_Ctrl == 1'b0 ? B_plus : B_minus;
	
	// Mux4to1b4_sch m6(.I0(reg_A_val), .I1(reg_B_val), .I2(reg_C_val), .I3(4'b0000),
	// 								 .s(Trans_select), .o(mux_out));

	assign mux_out = Trans_select == 2'b00 ? reg_A_val :
									 Trans_select == 2'b01 ? reg_B_val :
									 Trans_select == 2'b10 ? reg_C_val :
									 Trans_select == 2'b11 ? 4'b0000 : 4'bxxxx;
	
	/* ALU module implemented in Lab8 */
	/* A/B	: operands */
	/* S		: select the operation on ALU  */
	/* C 		: result of ALU */
	/* Co		: Carry bit */
	ALU4b m7(.A(reg_A_val), .B(reg_B_val), .C(ALU_res), .Co(Co), .S(ALU_Ctrl)); // (Co) may be useless
	
	// disp_num m8(.clk(clk), .HEXS({reg_A_val, reg_B_val, ALU_res, reg_C_val}), 
	// 						.LES(4'b0000), .points(4'b0000), .RST(1'b0), .AN(AN),
	// 						.Segment(SEGMENT));
	
	/* Your code here */
	// SW[15]: 0 for ALU mode, 1 for Trans mode.
	assign A2 = (1'b0 == SW[15]) ? A1 : mux_out; 
	assign B2 = (1'b0 == SW[15]) ? B1 : mux_out;
	assign C2 = (1'b0 == SW[15]) ? ALU_res : mux_out;
	
	always@(posedge btn_out[0]) num[3:0] = A2;
	always@(posedge btn_out[1]) num[7:4] = B2;
	always@(posedge btn_out[2]) num[11:8] = C2;
	/******************/

endmodule


module ALU4b(
	input[3:0] A,
	input[3:0] B,
	input[1:0] S,
	output[3:0] C,
	output Co
);

	wire[4:0] res;
	assign res = S == 2'b00 ? A+B :
							 S == 2'b01 ? A-B :
							 S == 2'b10 ? A&B : 
							 S == 2'b11 ? A|B :
							 4'bxxxx;

	assign Co = res[4];
	assign C = res[3:0];

endmodule