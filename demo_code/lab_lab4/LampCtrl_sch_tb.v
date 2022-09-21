module LampCtrl_sch_tb();
// Inputs
   reg S1;
   reg S2;
   reg S3;

// Output
   wire F;

// Instantiate the UUT
   lamp_ctrl UUT (
		.S1(S1), 
		.S2(S2), 
		.S3(S3), 
		.F(F)
   );

// Initialize Inputs
	initial begin
	S3=0;S2=0; S1=0;#50;
	           S1=1; #50;
		 S2=1;S1=0; #50;
              S1=1; #50;
    S3=1;S2=0;S1=0; #50;
              S1=1; #50; 
         S2=1;S1=0; #50;
		      S1=1; #50;
	end

endmodule // LampCtrl_sch_tb
