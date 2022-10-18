module pbdebounce(
	input wire clk_1ms,
	input wire button, 
	output reg pbreg
	);
 
	reg [7:0] pbshift;

	always@(posedge clk_1ms) begin
		pbshift = pbshift<<1;
		pbshift[0] = button;
		if (pbshift==8'b0)
			pbreg=0;
		if (pbshift==8'hFF)
			pbreg=1;	
	end

endmodule //button要连续按8ms才有效输出一个pbreg.