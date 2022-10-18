module top (
  input clk,
  input[7:0] SW,
  input[3:0] btn,
  output[3:0] AN,
  output[7:0] SEGMENT,
  output BTNX4
);

  wire[15:0] num;

  assign BTNX4 = 0;
  CreateNumber c0(.btn(btn), .num(num));
  
  // Note: The following port names may be different from yours, please compare and modify the port names below
  // e.g. enable signals of LED may be named *Les* rather than *LES*, then you need to change .LES() to .Les() below
  disp_num d0(.clk(clk), .Hexs(num), .LES(SW[7:4]), .points(SW[3:0]), .rst(1'b0), .AN(AN[3:0]), .SEGMENT(SEGMENT[7:0]));

endmodule