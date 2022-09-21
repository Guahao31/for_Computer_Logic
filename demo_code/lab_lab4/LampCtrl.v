`timescale 1ns / 1ps

module LampCtrl(
 	input wire clk, 
	input wire S1, 
	input wire S2, 
	input wire S3,
	output wire F
	);

  // 规定模块参数，可以对这些参数进行修改，详见FitstLook@Verilog
	parameter C_NUM = 8;
	parameter C_MAX = 8'hFF;

	reg [C_NUM-1:0] count;
	wire [C_NUM-1:0] c_next;
	
	initial begin	//初始化
   	count = C_MAX;//计数最大值
	end

  //button pressed
	assign w=S1^S2^S3;

	//lamp logic
  // 条件运算，与C语义类似；实质为多路选择器
  // 这里的意义是，对F进行连续赋值：当count < C_MAX时赋1，否则赋0
	assign F = (count < C_MAX) ? 1'b1 : 1'b0;

	//count logic
  // 每到clk信号的正边沿，执行
	always@(posedge clk) begin
		if(w == 1'b1)
			count = 0;
		else if(count < C_MAX)
			count = c_next; // c_next = count + 1'b1;
	end

	//next logic
	assign c_next = count + 1'b1;

endmodule // LampCtrl