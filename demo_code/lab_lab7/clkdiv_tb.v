`timescale 1ns/1ps

module clkdiv_tb();

  reg clk;
  reg rst;

  wire[31:0] clkdiv;

  clkdiv m0(.clk(clk), .rst(rst), .clkdiv(clkdiv));

  initial begin
    $dumpfile("clkdiv.vcd");
    $dumpvars(1, clkdiv_tb);

    clk = 1'b0;
    rst = 1'b0;
    #50;
    rst = 1'b1;
    #50;
    rst = 1'b0;

    #1000;
    rst = 1'b1;
    #50;
    rst = 1'b0;
    #50;
    $finish();
  end

  always begin
    #5 clk = ~clk;
  end

endmodule