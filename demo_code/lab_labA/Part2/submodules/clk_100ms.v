`timescale 1ns / 1ps

module clk_100ms( 
	input clk, 
	output reg clk_100ms
);
	 
	reg [31:0] cnt;

	initial begin
		cnt = 32'b0;
	end

	wire[31:0] cnt_next;
	assign cnt_next = cnt + 1'b1;

	always @(posedge clk) begin
		/* Your code here */
	
	end

endmodule
