`timescale 1ns/1ps

module clkdiv #(
  parameter DIV_WIDTH = 32
) (
  input clk,
  input rst,
  output reg[DIV_WIDTH-1:0] clkdiv
);

  always @(posedge clk or posedge rst) begin
    if(rst) begin
      // reset counter
      clkdiv <= 0;
    end else begin
      clkdiv <= clkdiv + 1'b1;
    end
  end

endmodule

