module Add1b(
  input a,
  input b,
  input ci,
  output s,
  output co
);

  assign s = a ^ b ^ ci;
  assign co = (a&b) | (a&ci) | (b&ci);

endmodule

module AddSub #(
  parameter WIDTH = 8 // WIDTH should be greater than 1
) (
  input [WIDTH-1:0] A,
  input [WIDTH-1:0] B,
  input Ctrl,
  output[WIDTH-1:0] S,
  output Co
);

  wire[WIDTH:0] C_temp;
  assign C_temp[0] = Ctrl;

  wire[WIDTH-1:0] S_temp;

  wire[WIDTH-1:0] Bo;
  assign Bo = {WIDTH{Ctrl}} ^ B;

  genvar i;
  generate 
    for(i = 0; i < WIDTH; i = i+1) begin
      Add1b u0 ( .a(A[i]), .b(Bo[i]), .ci(C_temp[i]), .s(S_temp[i]), .co(C_temp[i+1]) );
    end
  endgenerate

  assign Co = C_temp[WIDTH];
  assign S = S_temp;


endmodule