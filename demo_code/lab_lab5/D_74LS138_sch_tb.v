`timescale 1ns / 1ps

module D_74LS138_sch_tb();

// Inputs
   reg G;
   reg G2A;
   reg G2B;
   reg C;
   reg A;
   reg B;

// Output
   wire [7:0] Y;

// Instantiate the UUT
   D_74LS138 UUT (
		.Y(Y),
		.G(G),
		.G2A(G2A),
		.G2B(G2B),
    .A(A),
		.B(B), 
		.C(C)
   );
// Initialize Inputs
  integer i;
  initial begin
		C = 0; B = 0; A = 0;
		G = 1; G2A = 0; G2B = 0; #50;

		for(i=0; i<=7; i=i+1) begin
      {C,B,A} = i;
      #50;
    end

    G=1'b0; G2A=1'b0; G2B=1'b0; #50;
    G=1'b1; G2A=1'b1; G2B=1'b0; #50;
    G=1'b1; G2A=1'b0; G2B=1'b1; #50;
  end
endmodule // D_74LS138_sch_tb
