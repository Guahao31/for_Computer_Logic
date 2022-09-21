module top
  (
    input [7:0] in,
    output [15:0] out
    );

  wire [7:0] reversed;

  // Module reverse be declaration somewhere else
  // "module reverse(input [7:0] in, output [7:0] out);"
  reverse reverse_instance (.in(in), .out(reversed));
  
  // The module declare before
  sign_extender sign_extender_instance (.original(in), .sign_extended_original(out));

endmodule