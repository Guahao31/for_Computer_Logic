module LampCtrl_tb;
	// Inputs
	reg clk;
	reg S1;
	reg S2;
	reg S3;
	// Outputs
	wire F;

	// Instantiate the Unit Under Test (UUT)
	LampCtrl #(.C_NUM(8), .C_MAX(8'hFF))
    uut  ( .clk(clk), .S1(S1), .S2(S2), .S3(S3), .F(F));

  initial begin
    // 将vcd文件输出为“LampCtrl.vcd”
    $dumpfile("LampCtrl.vcd");
    $dumpvars(1, LampCtrl_tb);

		// Initialize Inputs
		clk = 0;
		S1 = 0;S2 = 0;S3 = 0;

		#600 S1 = 1;	
		#20 S1 = 0;
		#6000 S2 = 1;
		#20 S2 = 0;
		#6000 S3 = 1;
		#20 S3 = 0;
    $finish;
	end
	
	always begin
		#10 clk = ~clk;
	end	

endmodule // LampCtrl_tb
